vlib work

vlog -timescale 1ns/1ns alu.v

vsim alu

log {/*}
add wave {/*}

# Testcase 1
force {SW[7: 0]} 2#00000000
force {KEY[2: 0]} 2#000 0, 2#001 10, 2#010 20, 2#011 30, 2#100 40, 2#101 50 -r 60
run 60ns

# Testcase 2
force {SW[7: 0]} 2#11111111
force {KEY[2: 0]} 2#000 0, 2#001 10, 2#010 20, 2#011 30, 2#100 40, 2#101 50 -r 60
run 60ns

# Testcase 3
force {SW[7: 0]} 2#10101010
force {KEY[2: 0]} 2#000 0, 2#001 10, 2#010 20, 2#011 30, 2#100 40, 2#101 50 -r 60
run 60ns

# Testcase 4
force {SW[7: 0]} 2#11000101
force {KEY[2: 0]} 2#000 0, 2#001 10, 2#010 20, 2#011 30, 2#100 40, 2#101 50 -r 60
run 60ns
