module shifter(SW, KEY, LEDR);
	input [9:0] SW; // SW[7:0] = LoadVal[7:0]; SW[9] = reset_n
	input [3:0] KEY; // KEY[0] = clk; KEY[1] = Load_n; KEY[2] = ShiftRight; KEY[3] = ASR
	output [7:0] LEDR; // LEDR = q
	
	shifter8bit s(
		.LoadVal(SW[7:0]),
		.Load_n(KEY[1]),
		.ShiftRight(KEY[2]),
		.ASR(KEY[3]),
		.clk(KEY[0]),
		.reset_n(SW[9]),
		.q(LEDR[7:0])
	);
endmodule

module shifter8bit(LoadVal, Load_n, ShiftRight, ASR, clk, reset_n, q);
	input [7:0]LoadVal;
	input Load_n;
	input ShiftRight;
	input ASR;
	input clk;
	input reset_n;
	output [7:0]q;
	
	wire wout;
	
	asrcircuit asr(
					.asr(ASR),
					.first(LoadVal[7]),
					.m(wout)
	);
	
	shifterbit s7(
					.in(wout),
					.load_val(LoadVal[7]),
					.load_n(Load_n),
					.shift(ShiftRight),
					.clk(clk),
					.reset_n(reset_n),
					.out(q[7])
	);
	
	shifterbit s6(
					.in(q[7]),
					.load_val(LoadVal[6]),
					.load_n(Load_n),
					.shift(ShiftRight),
					.clk(clk),
					.reset_n(reset_n),
					.out(q[6])
	);
	
	shifterbit s5(
					.in(q[6]),
					.load_val(LoadVal[5]),
					.load_n(Load_n),
					.shift(ShiftRight),
					.clk(clk),
					.reset_n(reset_n),
					.out(q[5])
	);
	
	shifterbit s4(
					.in(q[5]),
					.load_val(LoadVal[4]),
					.load_n(Load_n),
					.shift(ShiftRight),
					.clk(clk),
					.reset_n(reset_n),
					.out(q[4])
	);
	
	shifterbit s3(
					.in(q[4]),
					.load_val(LoadVal[3]),
					.load_n(Load_n),
					.shift(ShiftRight),
					.clk(clk),
					.reset_n(reset_n),
					.out(q[3])
	);
	
	shifterbit s2(
					.in(q[3]),
					.load_val(LoadVal[2]),
					.load_n(Load_n),
					.shift(ShiftRight),
					.clk(clk),
					.reset_n(reset_n),
					.out(q[2])
	);
	
	shifterbit s1(
					.in(q[2]),
					.load_val(LoadVal[1]),
					.load_n(Load_n),
					.shift(ShiftRight),
					.clk(clk),
					.reset_n(reset_n),
					.out(q[1])
	);
	
	shifterbit s0(
					.in(q[1]),
					.load_val(LoadVal[0]),
					.load_n(Load_n),
					.shift(ShiftRight),
					.clk(clk),
					.reset_n(reset_n),
					.out(q[0])
	);
endmodule

module shifterbit(in, load_val, load_n, shift, clk, reset_n, out);
	input in;
	input load_val;
	input load_n;
	input shift;
	input clk;
	input reset_n;
	output out;
	
	wire data_from_other_mux;
	wire data_to_dff;
	
	mux2to1 M0(
			.x(out),
			.y(in),
			.s(shift),
			.m(data_from_other_mux)
	);
	
	mux2to1 M1(
			.x(load_val),
			.y(data_from_other_mux),
			.s(load_n),
			.m(data_to_dff)
	);
	
	flipflop F0(
			.d(data_to_dff),
			.q(out),
			.clock(clk),
			.reset_n(reset_n)
	);
	
endmodule

module asrcircuit(asr, first, m);
	input asr, first;
	output reg m;
	
	always @(*)
	begin
		if (asr == 1'b1)
			m <= first;
		else
			m <= 1'b0;
	end
endmodule


module mux2to1(x, y, s, m);
	input x; //selected when s is 0
	input y; //selected when s is 1
	input s; //select signal
	output m; //output
	
   assign m = s & y | ~s & x;
endmodule

module flipflop(d, q, clock, reset_n);
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

