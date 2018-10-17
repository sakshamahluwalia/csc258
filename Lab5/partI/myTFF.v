module myTFF(SW, KEY, HEX0, HEX1);
    input [1:0] SW; // SW[0] is the 'enable' switch, SW[1] is the 'clear_b_signal' switch
    input [3:0] KEY; 
    
    output [6:0] HEX0;
    output [6:0] HEX1;     
    
    wire [7:0] w;

    mytff8bit mytff0(   
        .enable(SW[0]),
        .clk(KEY[0]),
        .clear_b(SW[1]),
        .Q(w[7:0])
    );
    
    hex_display d0(
	.data_in(w[3:0]),
	.hex_out(HEX0[6:0])
    );

    hex_display d1(
	.data_in(w[7:4]),
	.hex_out(HEX1[6:0])
    );

endmodule

module mytff8bit(enable, clk, clear_b, Q);
    input enable;
    input clk;
    input clear_b;
    output [7:0] Q;

    toggleflipflop mytff0(
        .t(enable),
        .clock(clk),
        .clear_b_signal(clear_b),
        .q(Q[0])
    );

    toggleflipflop mytff1(
        .t(enable & Q[0]),
        .clock(clk),
        .clear_b_signal(clear_b),
        .q(Q[1])
    );

    toggleflipflop mytff2(
        .t(enable & Q[0] & Q[1]),
        .clock(clk),
        .clear_b_signal(clear_b),
        .q(Q[2])
    );

    toggleflipflop mytff3(
        .t(enable & Q[0] & Q[1] & Q[2]),
        .clock(clk),
        .clear_b_signal(clear_b),
        .q(Q[3])
    );

    toggleflipflop mytff4(
        .t(enable & Q[0] & Q[1] & Q[2] & Q[3]),
        .clock(clk),
        .clear_b_signal(clear_b),
        .q(Q[4])
    );

    toggleflipflop mytff5(
        .t(enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4]),
        .clock(clk),
        .clear_b_signal(clear_b),
        .q(Q[5])
    );

    toggleflipflop mytff6(
        .t(enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5]),
        .clock(clk),
        .clear_b_signal(clear_b),
        .q(Q[6])
    );

    toggleflipflop mytff7(
        .t(enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6]),
        .clock(clk),
        .clear_b_signal(clear_b),
        .q(Q[7])
    );
endmodule

module toggleflipflop(t, clock, clear_b_signal, q);
		input t; // t input fr the given register
		input clock; //Clock signal
		input clear_b_signal; //to clear the register 
		output q; // output of the register. 
		
		reg q;
		
		always @(posedge clock, negedge clear_b_signal)
		begin
			if (clear_b_signal == 1'b0)
				q <= 0;
			else if (t)
				q <= ~q;
		end
endmodule

module hex_display(data_in, hex_out);
	input [3:0] data_in;
	output [6:0] hex_out;
	
	segment_zero s0(
		.c3(data_in[3]),
		.c2(data_in[2]),
		.c1(data_in[1]),
		.c0(data_in[0]),
		.x(hex_out[0])
	);
	
	segment_one s1(
		.c3(data_in[3]),
		.c2(data_in[2]),
		.c1(data_in[1]),
		.c0(data_in[0]),
		.x(hex_out[1])
	);
	
	segment_two s2(
		.c3(data_in[3]),
		.c2(data_in[2]),
		.c1(data_in[1]),
		.c0(data_in[0]),
		.x(hex_out[2])
	);
	
	segment_three s3(
		.c3(data_in[3]),
		.c2(data_in[2]),
		.c1(data_in[1]),
		.c0(data_in[0]),
		.x(hex_out[3])
	);
	
	segment_four s4(
		.c3(data_in[3]),
		.c2(data_in[2]),
		.c1(data_in[1]),
		.c0(data_in[0]),
		.x(hex_out[4])
	);
	
	segment_five s5(
		.c3(data_in[3]),
		.c2(data_in[2]),
		.c1(data_in[1]),
		.c0(data_in[0]),
		.x(hex_out[5])
	);
	
	segment_six s6(
		.c3(data_in[3]),
		.c2(data_in[2]),
		.c1(data_in[1]),
		.c0(data_in[0]),
		.x(hex_out[6])
	);
endmodule

module segment_zero(c3, c2, c1, c0, x);
	input c3;
	input c2;
	input c1;
	input c0;

	output x;
	
	assign x = ~((c3 | c2 | c1 | ~c0) & (c3 | ~c2 | c1 | c0) & (~c3 | ~c2 | c1 | ~c0) & (~c3 | c2 | ~c1 | ~c0));
endmodule

module segment_one(c3, c2, c1, c0, x);
	input c3;
	input c2;
	input c1;
	input c0;

	output x;
	
	assign x = ~((~c1 | ~c0 | ~c3) & (~c1 | c0 | ~c2) & (c1 | c0 | ~c3 | ~c2) & (c1 | ~c0 | c3 | ~c2));
endmodule

module segment_two(c3, c2, c1, c0, x);
	input c3;
	input c2;
	input c1;
	input c0;

	output x;
	
	assign x = ~((~c3 | ~c2 | c1 | c0) & (~c1 | ~c3 | ~c2) & (c3 | c2 | ~c1 | c0));
endmodule

module segment_three(c3, c2, c1, c0, x);
	input c3;
	input c2;
	input c1;
	input c0;

	output x;
	
	assign x = ~((c3 | ~c2 | c1 | c0) & (c2 | c1 | ~c0) & (~c2 | ~c1 | ~c0) & (~c3 | c2 | ~c1 | c0));
endmodule

module segment_four(c3, c2, c1, c0, x);
	input c3;
	input c2;
	input c1;
	input c0;

	output x;
	
	assign x = ~((c1 | c0 | c3 | ~c2) & (c2 | c1 | ~c0) & (~c0 | c3));
endmodule

module segment_five(c3, c2, c1, c0, x);
	input c3;
	input c2;
	input c1;
	input c0;

	output x;
	
	assign x = ~((~c0 | c3 | c2) & (c3 | ~c1 | ~c0) & (~c1 | c3 | c2) & (c1 | ~c0 | ~c3 | ~c2));
endmodule

module segment_six(c3, c2, c1, c0, x);
	input c3;
	input c2;
	input c1;
	input c0;

	output x;
	
	assign x = ~((~c3 | ~c2 | c1 | c0) & (c1 | c3 | c2) & (~c1 | ~c0 | c3 | ~c2));
endmodule


