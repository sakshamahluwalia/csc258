vlib work

vlog -timescale 1ns/1ns shifter.v

vsim shifter

log {/*}
add wave {/*}
# LEDR = q
# SW[9] = reset_n;
force {SW[9]} 0 0, 1 5, 0 100, 1 105
# SW[7:0] = LoadVal[7:0];
force {SW[7: 0]} 10101010 0, 10101010 100
# KEY[0] = clk;
force {KEY[0]} 0 0, 1 5 -r 10
# KEY[1] = Load_n;
force {KEY[1]} 0 10, 1 20, 0 110, 1 120
# KEY[2] = ShiftRight;
force {KEY[2]} 0 0, 1 20 -r 100
# KEY[3] = ASR
force {KEY[3]} 0 0, 1 100 -r 200
run 180ns