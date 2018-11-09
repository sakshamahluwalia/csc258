vlib work

vlog -timescale 1ns/1ns updated_part2.v

vsim datapath

log {/*}
add wave {/*}
force {clk} 0 0,1 5 -r 10
force {resetn} 0 0,1 10
force {enable} 0 0, 1 40
force {ld_x} 1 0,0 10
force {ld_y} 0 0,1 20
force {ld_colour} 0 0,1 20
force {coord} 7'b0000000 0, 7'b00000001 10
force {colour_in} 3'b010 
run 200ns
