vlib work

vlog -timescale 1ns/1ns updated_part2.v

vsim question3

log {/*}

add wave {/*}

force {ld} 0 0, 1 40, 0 60
force {resetn} 0 0, 1 20
force {clk} 0 0, 1 10 -r 20
force {fill} 0 0, 1 80, 0 0 100
force {coord} 2#0000000 0, 2#1100110 40, 2#1111000 80
force {colour_in} 2#010
run 500ns
