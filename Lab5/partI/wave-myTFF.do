# Setup
vlib work
vlog -timescale 1ns/1ns myTFF.v
vsim myTFF
log {/*}
add wave {/*}

force {KEY[0]} 0 0, 1 10 -r 20
force {SW[0]} 0 0, 1 10 -r 20
force {SW[1]} 0 0, 1 100 -r 200

run 200ns


