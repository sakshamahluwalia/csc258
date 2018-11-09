vlib work

vlog -timescale 1ns/1ns poly_function.v

vsim fpga_top

log {/*}

add wave {/*}

force {KEY[0]} 0
force {KEY[1]} 1
run 1ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {KEY[0]} 1
run 1ns 

#load A
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
run 1ns

force {KEY[1]} 0
run 1ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {KEY[1]} 1
run 1ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

#load B
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
run 1ns

force {KEY[1]} 0
run 1ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {KEY[1]} 1
run 1ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

#load C
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
run 1ns

force {KEY[1]} 0
run 1ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {KEY[1]} 1
run 1ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

#load X
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
run 1ns

force {KEY[1]} 0
run 1ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {KEY[1]} 1
run 1ns

force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns

force {CLOCK_50} 0 0ns, 1 10ns -r 20ns

run 140ns
