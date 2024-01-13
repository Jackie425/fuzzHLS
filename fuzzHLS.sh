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

csmith --no-packed-struct --no-compound-assignment --no-embedded-assigns --no-argc --max-funcs 5 --max-block-depth 2 --max-array-dim 3 --max-expr-complexity 2 --probability-configuration ../fuzzHLS_probabilities > ./$fuzz_c
sleep 2
sed -i 's/return 0;/return (crc32_context ^ 0xFFFFFFFFUL);/g' $fuzz_c
sed -i 's/int main (void)/int hls_top(void)/g' $fuzz_c
sed -i '/platform_main_end(crc32_context ^ 0xFFFFFFFFUL, print_hash_value);/d' $fuzz_c

gcc ../main.c $fuzz_c -I$HOME/csmith/include -o $fuzz
sleep 2

timeout 10 ./$fuzz > ./$ref_out
if [ $? -eq 124 ]; then
  echo "time out";
  exit
fi

timeout 300 vivado_hls ../hls.tcl 
if [ $? -eq 124 ]; then
  exit
fi