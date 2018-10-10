module alu(SW, LEDR);
	input SW[7:0];
	input KEY[2:0];
	output LEDR[7:0];

	wire[4:0] c1, c2;

	ripplecarry c1(
		.SW({1'b0, SW[7:4], 4'b0001}),
		.LEDR(c1)
		);

	ripplecarry c2(
		.SW({1'b0, SW[7:0]}),
		.LEDR(c2)
		);

	reg [7:0] ALUout;

	always @(*)
	begin
		case (KEY[2:0])
			3'b111: ALUout = {3'b000, c1};
			3'b110: ALUout = {3'b000, c2};
			3'b101: ALUout = SW[7:4] + SW[3:0];
			3'b100: ALUout = {SW[7:4] | SW[3:0], SW[7:4] ^ SW[3:0]};
			3'b011: ALUout = | SW[7:0];	
			3'b010: ALUout = {SW[7:4], SW[3:0]};
			default: ALUout = 8'b00000000;
		endcase
	end

	assign LEDR = ALUout;


end module

module fulladder(A, B, cin, S, cout);
	input A;
	input B;
	input cin;
	output S;
	output cout;

	assign S = (A ^ B) ^ cin;
	assign cout = (A & cin) | (B & cin) | (A & B);
endmodule

module ripplecarry(SW, LEDR);
	input [8:0] SW;
	output [7:0] LEDR;

	wire FAzeroToFAone;
	wire FAoneToFAtwo;
	wire FAtwoToFAthree;

	fulladder A0(
		.A(SW[0]),
		.B(SW[4]),
		.cin(SW[8]),
		.S(LEDR[0]),
		.cout(FAzeroToFAone)
	);

	fulladder A1(
		.A(SW[1]),
		.B(SW[5]),
		.cin(FAzeroToFAone),
		.S(LEDR[1]),
		.cout(FAoneToFAtwo)
	);

	fulladder A2(
		.A(SW[2]),
		.B(SW[6]),
		.cin(FAoneToFAtwo),
		.S(LEDR[2]),
		.cout(FAtwoToFAthree)
	);

	fulladder A3(
		.A(SW[3]),
		.B(SW[7]),
		.cin(FAtwoToFAthree),
		.S(LEDR[3]),
		.cout(LEDR[4])
	);
endmodule

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
