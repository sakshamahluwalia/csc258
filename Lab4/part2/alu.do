vlib work

vlog -timescale 1ns/1ns alu.v

vsim alu

log {/*}

add wave {/*}

#force {KEY[0]} 1
#force {SW[9]} 0
#force {SW[3: 0]} 2#1010
#force {SW[7: 5]} 2#000

#clock
force {KEY[0]} 0 0, 1 5 -r 10
#reset
force {SW[9]} 0 0, 1 10, 0 90, 1 100, 0 180, 1 190
# fix A values
force {SW[3: 0]} 2#0000 0, 2#0011 90, 2#0100 180 -r 270

#  functions, 10ns each:
force {SW[7: 5]} 2#111 00, 2#110 20, 2#101 30, 2#100 40, 2#011 50, 2#010 60, 2#001 70, 2#000 80 -r 90

run 250ns