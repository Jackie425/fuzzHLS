fuzz_c="fuzzHLS.c"
fuzz="fuzzHLS"
ref_out="check.data"

mkdir -p build
cd build/
touch ./cosim_result.data
touch ./result.data
csmith --no-jumps --no-comma-operators --no-packed-struct --no-compound-assignment --no-global-variables --nomain --no-checksum --no-embedded-assigns --no-argc --max-funcs 5 --max-block-depth 2 --max-array-dim 3 --max-expr-complexity 2 --probability-configuration ../fuzzHLS_probabilities > ./$fuzz_c

# 获取开始行号
start_line=$(grep -n "{ /\* block id: 0 \*/" ./$fuzz_c | cut -d : -f 1)
echo "start_line = $start_line"
# 获取结束行号
end_line=$(awk -v start=$start_line 'NR>start && !((($1 ~ /^uint|^int/ && substr($2,1,2) == "l_") || ($1 == "const" && $2 ~ /^uint|^int/ && substr($3,1,2) == "l_"))) {print NR; exit}' $fuzz_c)
echo "end_line = $end_line"
# 从开始行读取，直到遇到空行，提取变量名，条件是找到以"l_"开头的字段后，从"l_"开始到"["或" "或";"结束
vars_name=$(awk -v start=$start_line -v end=$end_line 'NR>start && NR<end && $0!="" {for(i=1;i<=NF;i++) if(substr($i,1,2) == "l_") {var_name = $i; gsub("[[; ].*", "", var_name); printf var_name ","}}' $fuzz_c | sed 's/,$//')
vars=$(awk -v start=$start_line -v end=$end_line 'NR>start && NR<end && $0!="" {for(i=1;i<=NF;i++) if(substr($i,1,2) == "l_") {var_name = $i; if(substr(var_name,length(var_name)) == ";") var_name = substr(var_name, 1, length(var_name)-1); printf "volatile " $(i-1) " " var_name ","}}' $fuzz_c | sed 's/,$//')
echo "vars = $vars"

# 在fuzz_c文件中全局匹配func_1(void)并替换为func_1($vars)
sed -i "s/func_1(void)/func_1($vars)/g" $fuzz_c

# 全局匹配func_1，匹配到该行就将这一行的"static "和"const"删除
sed -i '/func_1/s/static //; /func_1/s/const //' $fuzz_c

# 提取fuzz_c文件中start_line到end_line之间的内容
content=$(sed -n "$((start_line+1)),$((end_line-1))p" $fuzz_c)
echo "content = $content"

# 删除fuzz_c文件中start_line到end_line之间的所有内容
sed -i "$((start_line+1)),$((end_line-1))d" $fuzz_c

while true; do
    # 从end_line开始，找到下一个含有/* block id:的行作为新的start_line
    start_line=$(awk -v start=$start_line 'NR>start && /\/\* block id:/ {print NR; exit}' $fuzz_c)
    if [ -z "$start_line" ]; then
        # 如果没有找到新的开始行，那么退出循环
        break
    fi
    echo "start_line = $start_line"
    # 获取新的结束行
    end_line=$(awk -v start=$start_line 'NR>start && !((($1 ~ /^uint|^int/ && substr($2,1,2) == "l_") || ($1 == "const" && $2 ~ /^uint|^int/ && substr($3,1,2) == "l_"))) {print NR; exit}' $fuzz_c)
    echo "end_line = $end_line"
    # 在开始行和结束行之间的每一行的第一个字段前加上"volatile "
    for ((i=start_line+1; i<end_line; i++)); do
        sed -i "${i}s/^\(\s*\)\(\S\+\)/\1volatile \2/" $fuzz_c
    done
done

# 获取开始行号
start_line=$(grep -n "/\* --- FORWARD DECLARATIONS --- \*/" ./$fuzz_c | cut -d : -f 1)
echo "start_line = $start_line"

# 获取结束行号
end_line=$(awk -v start=$start_line 'NR>start && $0=="" {print NR; exit}' $fuzz_c)
echo "end_line = $end_line"

for ((i=start_line+1; i<end_line; i++)); do
    # 获取去掉";"后的内容
    template=$(sed -n "${i}p" $fuzz_c | tr -d ';')
    # 使用这个内容作为模板对全局进行匹配，获取匹配的行号
    match_lines=$(grep -n "$template" $fuzz_c | cut -d : -f 1)
    # 在匹配的行和之前遍历的那一行的每一个"("和","后面加上"volatile "
    for line in $match_lines; do
        sed -i "${line}s/(/(volatile /g; ${line}s/,/, volatile /g" $fuzz_c
    done
done

# 提取content中的每一行以l_开头的字段，然后根据字段中[的数量生成相应的打印语句
var_print=""
while IFS= read -r var
do
    # 计算[的数量
    num_brackets=$(echo "$var" | grep -o "\[" | wc -l)
    # 根据[的数量生成打印语句
    case $num_brackets in
        0)
            # 如果没有[，直接打印变量
            var_print+="    printf(\"$var = %X\\\\n\", $var);\n"
            ;;
        1)
            # 如果有一个[，提取[后的数字作为循环index，利用for循环遍历这个一维数组打印变量
            array_size=${var#*[*}
            array_size=${array_size%]*}
            var=${var%%[*}
            var_print+="    for(i = 0; i < $array_size; i++) { printf(\"$var[%d] = %X\\\\n\", i, $var[i]); }\n"
            ;;
        2)
            # 如果有两个[，提取两层[后面的数字作为两层循环的index，利用for循环遍历这个二维数组打印变量
            array_size1=${var#*[*}
            array_size1=${array_size1%%]*}
            array_size2=${var#*[*[*}
            array_size2=${array_size2%%]*}
            var=${var%%[*}
            var_print+="    for(i = 0; i < $array_size1; i++) { for(j = 0; j < $array_size2; j++) { printf(\"$var[%d][%d] = %X\\\\n\", i, j, $var[i][j]); } }\n"
            ;;
        3)
            # 如果有三个[，以此类推...
            array_size3=${var#*[*}
            array_size3=${array_size3%%]*}
            array_size4=${var#*[*[*}
            array_size4=${array_size4%%]*}
            array_size5=${var#*[*[*[*}
            array_size5=${array_size5%%]*}
            var=${var%%[*}
            var_print+="    for(i = 0; i < $array_size3; i++) { for(j = 0; j < $array_size4; j++) { for(k = 0; k < $array_size5; k++) { printf(\"$var[%d][%d][%d] = %X\\\\n\", i, j, k, $var[i][j][k]); } } }\n"
            ;;
    esac
done < <(echo "$content" | awk '{for(i=1;i<=NF;i++) if(substr($i,1,2) == "l_") {var_name = $i; gsub(";","",var_name); print var_name}}')
echo "var_print = $var_print"

# 创建新的main.c文件
echo -e "#include <stdio.h>\n#include <stdint.h>\n\nint main (void){\n    int i, j, k;\n$content\n    printf(\"return %X\\\\n\", func_1($vars_name));\n$var_print\n    return 0;\n}" > main.c

# 替换为向file中打印字符串
var_print=${var_print//printf(/fprintf(file, }

# 创建新的testbench.c文件
echo -e "
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

int main (void){\n
    int i, j, k;
    char *fuzzHLS = getenv(\"fuzzHLS\");
    if(fuzzHLS == NULL) {
        printf(\"Failed to get environment variable fuzzHLS\\\\n\");
        return 1;
    }

    char result_file[256];
    snprintf(result_file, sizeof(result_file), \"%s/build/result.data\", fuzzHLS);

    FILE *file = fopen(result_file, \"w\");
    if(file == NULL) {
        printf(\"Failed to open file\\\\n\");
        return 1;
    }\n
$content\n
    fprintf(file, \"return %X\\\\n\", func_1($vars_name));\n
$var_print\n
    fclose(file);
    int ret;
    char sys_dir[256];
    sprintf(sys_dir, \"diff --brief -w %s/build/result.data %s/build/check.data\", fuzzHLS, fuzzHLS);
    ret = system(sys_dir);
    if (ret != 0) {
        printf(\"Test failed !!!\\\\n\");
        ret = 1;
        return ret;
    } else {
        printf(\"Test passed !\\\\n\");
        return ret;
    }
    return 0;
}" > testbench.c


gcc -O3 ./main.c $fuzz_c -I$HOME/csmith/include -o $fuzz

timeout 10 ./$fuzz > ./$ref_out
if [ $? -eq 124 ]; then
  echo "time out";
  exit
fi

timeout 300 vivado_hls ../hls.tcl 
if [ $? -eq 124 ]; then
  exit
fi

#if grep -q "Cosim SUCCESS" cosim_result.data; then
#  cp fuzzHLS.c ../success_hls/$i.c
#elif grep -q "Cosim FAIL" cosim_result.data; then
#  exit
#else 
#  exit
#fi