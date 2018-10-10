vlib work

vlog -timescale 1ns/1ns ripplecarry.v

vsim ripplecarry

log {/*}

add wave {/*}

force {SW[8]} 0

# a = 0 (0000)
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
# b = 0 (0000)
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
# output = 0 (00000)
run 10ns

# a = 15 (1111)
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
# b = 15 (1111)
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
# output = 30 (11110)
run 10ns

force {SW[8]} 1

# a = 8 (1000)
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
# b = 8 (1000)
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1
# output = 31 (11111)
run 10ns
