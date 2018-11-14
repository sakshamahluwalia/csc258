vlib work

vlog -timescale 1ns/1ns part2.v

vsim q3

log {/*}

add wave {/*}


force {clock} 0 0, 1 10 -r 20
force {resetn} 0 0, 1 20
force {load} 0 0, 1 40, 0 60
force {drw} 0 0, 1 80, 0 0 100
force {c_in} 2#010
force {point} 2#0000000 0, 2#1100110 40, 2#1111000 80

run 500ns
