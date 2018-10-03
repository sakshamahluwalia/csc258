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
