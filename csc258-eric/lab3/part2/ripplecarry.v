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
	output [7:0] LEDR;

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

