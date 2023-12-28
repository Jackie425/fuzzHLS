total_num=$1
hls_success=0
hls_hercules=0
hls_crash=0
timeout=0
fail=0
fuzz_c="fuzzHLS.c"
fuzz="fuzzHLS"

ref_out="check.data"

mkdir -p build
mkdir -p fail_hls
mkdir -p success_hls
mkdir -p hercules_hls
cd build/

touch ./cosim_result.data
for ((i=0; i<total_num; i=i+1))
do
  echo "******************************Running csmith*******************************";
  csmith --no-packed-struct --no-compound-assignment --no-embedded-assigns --no-argc --max-funcs 5 --max-block-depth 2 --max-array-dim 3 --max-expr-complexity 2 --probability-configuration ../fuzzHLS_probabilities > ./$fuzz_c
  sleep 2
  sed -i 's/return 0;/return (crc32_context ^ 0xFFFFFFFFUL);/g' $fuzz_c
  sed -i 's/int main (void)/int hls_top(void)/g' $fuzz_c
  sed -i '/platform_main_end(crc32_context ^ 0xFFFFFFFFUL, print_hash_value);/d' $fuzz_c
  echo "******************************Running gcc*******************************";
  gcc ../main.c $fuzz_c -I$HOME/csmith/include -o $fuzz
  sleep 2
  timeout 10 ./$fuzz > ./$ref_out
  if [ $? -eq 124 ]; then
    timeout=1
    echo "******************************time out********************************";
  fi
  echo "******************************Enter Vivado********************************";
  timeout 300 vivado_hls ../hls.tcl 
  if [ $? -eq 124 ]; then
    timeout=1
    echo "******************************time out********************************";
  fi
  sleep 5
  if [ $timeout = 1 ]; then
    ((hls_crash++))
    echo "******************************HLS synth CRASH********************************";
  elif grep -q "Cosim SUCCESS" cosim_result.data; then
    cp fuzzHLS.c ../success_hls/$i.c
    echo "******************************Co-sim PASS********************************";
  elif grep -q "Cosim FAIL" cosim_result.data; then
    ((hls_fail++))
    echo "******************************Co-sim FAIL********************************";
    cp fuzzHLS.c ../fail_hls/$i.c
    fail=1
    #exit
  else 
    echo "******************************HLS synth CRASH********************************";
  fi
  sleep 5


  if [ $timeout = 1 ] || [ $fail = 1 ]; then
    echo "******************************Crash no Hercules*******************************";
  else 
    echo "******************************Begin Hercules*******************************";
    clang -I ~/csmith/include/ -Xclang -ast-dump -fno-color-diagnostics -fsyntax-only $fuzz_c > fuzzHLS_dump_ast.data
    python ../parseAST.py $fuzz_c fuzzHLS_dump_ast.data
    echo "******************************Running gcc*******************************";
    gcc ../main.c $fuzz_c -I$HOME/csmith/include -o $fuzz
    sleep 2
    timeout 10 ./$fuzz > ./$ref_out
    if [ $? -eq 124 ]; then
    timeout=1
    echo "******************************time out********************************";
    fi
    echo "******************************Enter Vivado********************************";
      timeout 300 vivado_hls ../hls.tcl 
    if [ $? -eq 124 ]; then
      timeout=1
      echo "******************************Hercules time out********************************";
    fi
    sleep 5
    if [ $timeout = 1 ]; then
      ((hls_crash++))
      echo "******************************Hercules HLS synth CRASH********************************";
    elif grep -q "Cosim SUCCESS" cosim_result.data; then
      ((hls_success++))
      cp fuzzHLS.c ../success_hls/$i.c
      echo "******************************Hercules Co-sim PASS********************************";
    elif grep -q "Cosim FAIL" cosim_result.data; then
      ((hls_hercules++))
      echo "******************************Hercules Co-sim FAIL********************************";
      cp fuzzHLS.c ../hercules_hls/$i.c
      fail=1
      #exit
    else 
      ((hls_crash++))
      echo "******************************HLS synth CRASH********************************";
    fi
    sleep 5
  fi


  echo "******************************Finish $i Iteration*******************************";
  timeout=0
  fail=0
  > cosim_result.data
  > check.data
done

echo "HERCULES TIME $hls_hercules"
echo "SUCCESS TIME $hls_success"
echo "CRASH TIME $hls_crash"
echo "END fuzzing HLS!";
