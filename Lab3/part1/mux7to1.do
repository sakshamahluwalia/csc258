vlib work

vlog -timescale 1ns/1ns mux7to1.v

vsim mux7to1

log {/*}

add wave {/*}

force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 1

force {SW[7]} 0 0 ns, 1 10 ns -repeat 20
force {SW[8]} 0 0 ns, 1 20 ns -repeat 40
force {SW[9]} 0 0 ns, 1 40 ns -repeat 80

run 80ns

