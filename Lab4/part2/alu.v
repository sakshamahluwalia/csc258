module alu(SW, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, KEY, LEDR);
	input [9:0] SW;
	input [2:0] KEY;
	output [7:0] LEDR;
	output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

	wire [4:0] c1, c2;
	wire [7:0] wout;
	reg [7:0] ALUout;
		
	register reg1(
		.reset_n(SW[9]),
		.clock(KEY[0]),
		.d(ALUout[7:0]),
		.q(wout[7:0])
	);
	
	ripplecarry carry1(
		.SW({1'b0, SW[3:0], 4'b0001}),
		.LEDR(c1)
	);
	
	ripplecarry carry2(
		.SW({1'b0, SW[3:0], wout[3:0]}),
		.LEDR(c2)
	);
	
	always @(*)
	begin
		case (SW[7:5])
			3'b111: ALUout = {3'b000, c1};
			3'b110: ALUout = {3'b000, c2};
			3'b101: ALUout = SW[3:0] + wout[3:0];
			3'b100: ALUout = {SW[3:0] | wout[3:0], SW[3:0] ^ wout[3:0]};
			3'b011: ALUout = | SW[3:0] | wout[3:0];	
			3'b010: ALUout = wout[3:0] << SW[3:0];
			3'b001: ALUout = wout[3:0] >> SW[3:0];
			3'b000: ALUout = SW[3:0] * wout[3:0];
			default: ALUout = 8'b00000000;
		endcase
	end

	assign LEDR = ALUout;
	
	hex_display hex0( // displays A
		.SW(SW[3:0]),
		.HEX(HEX0[6:0])
	);

	hex_display hex1( // display nothing
		.SW(4'b0000),
		.HEX(HEX1[6:0])
	);

	hex_display hex2( // display nothing
		.SW(4'b0000),
		.HEX(HEX2[6:0])
	);

	hex_display hex3( // display nothing
		.SW(4'b0000),
		.HEX(HEX3[6:0])
	);

	hex_display hex4( // least significant 4 bits of Register
		.SW(wout[3:0]),
		.HEX(HEX4[6:0])
	);

	hex_display hex5( // most significant 4 bits of Register
		.SW(wout[7:4]),
		.HEX(HEX5[6:0])
	);
endmodule

module register(reset_n, clock, d, q);
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

module fulladder(A, B, cin, S, cout);
	input A;
	input B;
	input cin;
	output S;
	output cout;

	assign S = (~A & ~B & cin) | (~A & B & ~cin) | (A & ~B & ~cin) | (A & B & cin);
	assign cout = (A & cin) | (B & cin) | (A & B);
endmodule

module ripplecarry(SW, LEDR);
	input [8:0] SW;
	output [9:0] LEDR;

	wire connection_0; //connect cout from FA0 to FA1
	wire connection_1; //connect cout from FA1 to FA2
	wire connection_2; //connect cout from FA2 to FA3

	fulladder FA0(
		.A(SW[0]), //represents a_0
		.B(SW[4]), //represents b_0
		.cin(SW[8]), //represents c_in
		.S(LEDR[0]), //represents s_0
		.cout(connection_0)
	);

	fulladder FA1(
		.A(SW[1]), //represents a_1
		.B(SW[5]), //represents b_1
		.cin(connection_0), //represents c_1
		.S(LEDR[1]), //represents s_1
		.cout(connection_1)
	);

	fulladder FA2(
		.A(SW[2]), //represents a_2
		.B(SW[6]), //represents b_2
		.cin(connection_1), //represents c_2
		.S(LEDR[2]), //represents s_2
		.cout(connection_2)
	);

	fulladder FA3(
		.A(SW[3]), //represents a_3
		.B(SW[7]), //represents b_3
		.cin(connection_2), //represents c_3
		.S(LEDR[3]), //represents s_3
		.cout(LEDR[4])
	);
endmodule

module hex_display(SW,HEX);
	input [3:0] SW;
	output [6:0] HEX;

	zero m1(
		.a(SW[3]),
		.b(SW[2]),
		.c(SW[1]),
		.d(SW[0]),
		.m(HEX[0])
		);
	one m2(
		.a(SW[3]),
		.b(SW[2]),
		.c(SW[1]),
		.d(SW[0]),
		.m(HEX[1])
		);
	two m3(
		.a(SW[3]),
		.b(SW[2]),
		.c(SW[1]),
		.d(SW[0]),
		.m(HEX[2])
		);
	three m4(
		.a(SW[3]),
		.b(SW[2]),
		.c(SW[1]),
		.d(SW[0]),
		.m(HEX[3])
		);
   	four m5(
		.a(SW[3]),
		.b(SW[2]),
		.c(SW[1]),
		.d(SW[0]),
		.m(HEX[4])
		);
	five m6(
		.a(SW[3]),
		.b(SW[2]),
		.c(SW[1]),
		.d(SW[0]),
		.m(HEX[5])
		);
	six m7(
		.a(SW[3]),
		.b(SW[2]),
		.c(SW[1]),
		.d(SW[0]),
		.m(HEX[6])
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
