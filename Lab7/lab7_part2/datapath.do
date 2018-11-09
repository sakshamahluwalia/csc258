vlib work

vlog -timescale 1ns/1ns part2.v

vsim datapath

log {/*}
add wave {/*}
force {clock} 0 0,1 5 -r 10
force {resetn} 0 0,1 10
force {enable} 0 0, 1 40
force {load_x} 1 0,0 10
force {load_y} 0 0,1 20
force {load_colour} 0 0,1 20
force {point} 7'b0000000 0, 7'b00000000 10
force {c_in} 3'b010 
run 200ns
