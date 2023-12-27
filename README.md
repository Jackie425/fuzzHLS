fuzzHLS
generate fuzzing C code and use vivado hls synthesis to RTL
automatically checking the result of generated RTL is correct or not
picking the wrong one to ./fail_hls and named with index of iteration.

usage:
make total_num=1000
to create 1000 fuzzing DUT and pick the wrong one to ./fail_hls
make clean
to clear the ./build dir
