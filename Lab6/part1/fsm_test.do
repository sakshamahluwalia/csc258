vlib work

vlog -timescale 1ns/1ns sequence_detector.v

vsim sequence_detector

log {/*}

add wave {/*}

# test first case all one's
force {SW[0]} 0

run 10ns

force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

force {SW[0]} 1
force {SW[1]} 1

force {KEY[0]} 0 0ns, 1 10ns -r 20 ns

run 100ns

force {SW[0]} 0

run 10ns

force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

# test other case 1101

force {SW[0]} 0

run 10ns

force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

force {SW[0]} 1
force {SW[1]} 1

force {KEY[0]} 0 0ns, 1 10ns -r 20 ns

run 40ns

force {SW[1]} 0

force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

force {SW[1]} 1

force {KEY[0]} 0 0ns, 1 10ns -r 20 ns

run 20ns

force {SW[1]} 0

force {KEY[0]} 0 0ns, 1 10ns -r 20 ns

run 40ns
