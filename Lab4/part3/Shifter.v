module Shifter(LoadVal, ShiftRight, load_n, clk, reset_n, ASR, Q);

	input [7:0] LoadVal;
	input ShiftRight;
	input reset_n;
	input load_n;
	input clk;

	output [7:0] Q;

	wire asrout;

	asr a1(
		.asr(ASR),
		.sigbit(Load_val[7]),
		.q(asrout)
	)

	shifterbit s7(
		.load_val(Load_val[7]),
		.in(asrout),
		.shift(ShiftRight),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(Q[7])
		);

	shifterbit s6(
		.load_val(Load_val[6]),
		.in(Q[7]),
		.shift(ShiftRight),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(Q[6])
		);

	shifterbit s5(
		.load_val(Load_val[5]),
		.in(Q[6]),
		.shift(ShiftRight),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(Q[5])
		);

	shifterbit s4(
		.load_val(Load_val[4]),
		.in(Q[5]),
		.shift(ShiftRight),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(Q[4])
		);

	shifterbit s3(
		.load_val(Load_val[3]),
		.in(Q[4]),
		.shift(ShiftRight),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(Q[3])
		);

	shifterbit s2(
		.load_val(Load_val[2]),
		.in(Q[3]),
		.shift(ShiftRight),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(Q[2])
		);

	shifterbit s1(
		.load_val(Load_val[1]),
		.in(Q[2]),
		.shift(ShiftRight),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(Q[1])
		);
	
	shifterbit s0(
		.load_val(Load_val[0]),
		.in(Q[1]),
		.shift(ShiftRight),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(Q[0])
		);

endmodule

module asr(ASR, sigbit, q)

	input ASR;
	input sigbit;

	output reg q;

	always @(*)
	begin
		if (asr == 1'b0)
			q <= sigbit
		else 
			q <= 1'b0
	end
endmodule

module shifterbit(load_val, in, shift, load_n, clk, reset_n, out);

	input load_val;
	input in;
	input shift;
	input load_n;
	input clk;
	input reset_n;

	output out;

	wire outmux1, outmux2;

	mux2to1 m1(
		.x(out),
		.y(in),
		.s(shift),
		.m(outmux1)
		);

	mux2to1 m2(
		.x(load_val),
		.y(outmux1),
		.s(load_n),
		.m(outmux2)
		);

	flipflop f1(
		.d(outmux2),
		.clock(clk),
		.reset_n(reset_n),
		.q(out)
		);
endmodule

module mux2to1(x, y, s, m);
	input x; //selected when s is 0
	input y; //selected when s is 1
	input s; //select signal
	output m; //output
	
   assign m = s & y | ~s & x;
endmodule

module flipflop(d, clock, reset_n, q);
	input [7:0] d;
	input clock;
	input reset_n;
	output [7:0] q;
	
	reg [7:0] q;
	always @(posedge clock)
	begin
		if (reset_n == 1'b0)
			q <= 0;
		else
			q <= d;
	end
endmodule