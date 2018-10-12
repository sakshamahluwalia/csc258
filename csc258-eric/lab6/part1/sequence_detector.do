vlib work

vlog -timescale 1ns/1ns sequence_detector.v

vsim sequence_detector

log {/*}
add wave {/*}

# resetn
force {SW[0]} 1

# clock signal
force {KEY[0]} 0 0, 1 25 -r 50

# input w
force {SW[1]} 0 0, 1 90, 0 310, 1 380, 0 450


run 500ns

# resetn
force {SW[0]} 0

# clock signal
force {KEY[0]} 0 0, 1 25 -r 50

# input w
force {SW[1]} 0 0, 1 90, 0 310, 1 380, 0 450


run 500ns