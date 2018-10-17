module counter(SW, KEY, HEX0, HEX1);
	input [1:0] SW;
	input [0:0] KEY;
	output [6:0] HEX0, HEX1;
	
	wire [3:0] h0, h1;
	
	counter8 c(SW[1], KEY[0], SW[0], {h1, h0});
	
	hex hex0(h0, HEX0);		
	hex hex1(h1, HEX1);

endmodule

module counter8(enable, clk, clear_b, out);
	input enable, clk, clear_b;
	output [7:0] out;
	
	wire w0, w1, w2, w3, w4, w5, w6;
	assign w0 = enable & out[0];
	assign w1 = w0 & out[1];
	assign w2 = w1 & out[2];
	assign w3 = w2 & out[3];
	assign w4 = w3 & out[4];
	assign w5 = w4 & out[5];
	assign w6 = w5 & out[6];
	
	t_ff t0(enable, clk, clear_b, out[0]);
	t_ff t1(w0, clk, clear_b, out[1]);
	t_ff t2(w1, clk, clear_b, out[2]);
	t_ff t3(w2, clk, clear_b, out[3]);
	t_ff t4(w3, clk, clear_b, out[4]);
	t_ff t5(w4, clk, clear_b, out[5]);
	t_ff t6(w5, clk, clear_b, out[6]);
	t_ff t7(w6, clk, clear_b, out[7]);
	

endmodule

module t_ff(in, clk, clear_b, out);
	input clk, clear_b, in;
	output reg out;
	always @(posedge clk, negedge clear_b)
	begin
		if (clear_b == 1'b0)
			out <= 1'b0;
		else if (in == 1'b1)
			out <= ~out;
	end
endmodule






// HEX

module hex_display(SW, HEX);
	input [3:0] SW;
	output [6:0] HEX0;

	zero m1(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX0[0])
		);

	one m2(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX0[1])
		);
	two m3(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX0[2])
		);
	three m4(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX0[3])
		);
   	four m5(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX0[4])
		);
	five m6(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX0[5])
		);
	six m7(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX0[6])
		);
endmodule

module zero(a,b,c,d,m);
	input a;
	input b;
	input c;
	input d;
	output m;

	assign m = (~a & b & ~c & ~d) | (~a & ~b & ~c & d) | (a & b & ~c & d) | (a & ~b & c & d);
endmodule

module one(a,b,c,d,m);
	input a;
	input b;
	input c;
	input d;
	output m;

	assign m = (a & b & ~d) | (~a & b & ~c & d) | (a & c & d) | (b & c & ~d);
endmodule

module two(a,b,c,d,m);
	input a;
	input b;
	input c;
	input d;
	output m;

	assign m = (a & b & ~d) | (a & b & c) | (~a & ~b & c & ~d);
endmodule

module three(a,b,c,d,m);
	input a;
	input b;
	input c;
	input d;
	output m;

	assign m = (~a & b & ~c & ~d) | (~a & ~b & ~c & d) | (b & c & d) | (a & ~b & c & ~d);
endmodule

module four(a,b,c,d,m);
	input a;
	input b;
	input c;
	input d;
	output m;

   assign m = (~a & b & ~c) | (~b & ~c & d) | (~a & c & d);
endmodule

module five(a,b,c,d,m);
	input a;
	input b;
	input c;
	input d;
	output m;

	assign m = (~a & ~b & d) | (a & b & ~c & d) | (~a & c & d) | (~a & ~b & c);
endmodule

module six(a,b,c,d,m);
	input a;
	input b;
	input c;
	input d;
	output m;

	assign m = (~a & ~b & ~c) | (a & b & ~c & ~d) | (~a & b & c & d);
endmodule

