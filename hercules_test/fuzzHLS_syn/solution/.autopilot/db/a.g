#!/bin/sh
lli=${LLVMINTERP-lli}
exec $lli \
    /home/jackie/RISC-V_Research/fuzzHLS/hercules_test/fuzzHLS_syn/solution/.autopilot/db/a.g.bc ${1+"$@"}
