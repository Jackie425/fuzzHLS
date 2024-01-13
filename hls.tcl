open_project fuzzHLS_syn

add_files fuzzHLS.c -cflags "-I/home/jackie/csmith/include"
add_files -tb testbench.c -cflags "-I/home/jackie/csmith/include" 

set_top func_1

open_solution -reset solution
set_part xczu19eg-ffvc1760-2-i
create_clock -period 10
#csim_design
csynth_design
#cosim_design -rtl verilog -trace_level none

exit

