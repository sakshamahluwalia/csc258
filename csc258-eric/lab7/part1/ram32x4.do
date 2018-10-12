vlib work

vlog -timescale 1ps/1ps ram32x4.v

vsim -L altera_mf_ver ram32x4

log {/*}
add wave {/*}


# clock
force {clock} 1 2.5, 0 5 -r 7.5

# data
force {data[3:0]} 0010 0, 0011 10, 1010 20, 1011 30

# wren
force {wren} 1 0, 0 10 -r 20

# address
force {address[4:0]} 00000 0, 00001 10, 00010 20, 00011 30

run 40ps
