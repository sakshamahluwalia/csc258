module hex_display(SW,HEX);
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
