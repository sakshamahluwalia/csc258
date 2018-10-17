module flash_counter(SW, HEX0, CLOCK_50);
	input CLOCK_50;
	input [9:0] SW; 
	output [6:0] HEX0;	
	wire [3:0] out;
	
	counter c0(CLOCK_50, SW[3], SW[2], SW[7:4], SW[9], SW[1:0], out);
	
	hexDisplay h0(out, HEX0);
endmodule

module counter(clk, reset_n, enable, d, par_load, freq, q);
	input clk, enable, par_load, reset_n;
	input [1:0] freq;
	input [3:0] d;
	output [3:0] q;
	
	wire [27:0] hz1, hz05, hz025;
	reg out;
	
	rate_divider r1hz(clk, reset_n, enable,{2'b00, 26'd49999999},hz1);
	rate_divider r05hz(clk, reset_n, enable,{1'b0, 27'd99999999},hz05); 
	rate_divider r025hz(clk, reset_n, enable,{28'd499999999},hz025); 
	
	always @(*)
		begin
			case(freq)
				2'b00: out = enable;
				2'b01: out = (hz1 == 0) ? 1 : 0;
				2'b10: out = (hz05 == 0) ? 1 : 0;
				2'b11: out = (hz025 == 0) ? 1 : 0;
			endcase
		end
		
	display_counter d0(clk, reset_n, out, d, par_load, q);
	
endmodule

module display_counter(clk, reset_n, enable, d, par_load, q);
	input enable, clk, reset_n, par_load;
	input [3:0] d;
	output reg [3:0] q;
	
	always @(posedge clk, negedge reset_n)
	begin
		if (reset_n == 1'b0)
			q <= 4'b0000;
		else if (par_load == 1'b1)
			q <= d;
		else if (enable == 1'b1)
			begin
				if (q == 4'b1111)
					q <= 4'b0000;
				else
					q <= q + 1'b1;
			end
	end
endmodule

module rate_divider(clk, reset_n, enable, d, q);
	input enable, clk, reset_n;
	input [27:0] d;
	output reg [27:0] q;
	
	always @(posedge clk)
	begin
		if (reset_n == 1'b0)
			q <= d;
		else if (enable == 1'b1)
			begin
				if (q == 0)
					q <= d;
				else
					q <= q - 1'b1;
			end
	end
	
endmodule

module hexDisplay(HEX_in, HEX_out);
	input [3:0] HEX_in;
	output [6:0] HEX_out;
	
	segment0 ZERO(
		.c3(HEX_in[3]),
		.c2(HEX_in[2]),
		.c1(HEX_in[1]),
		.c0(HEX_in[0]),
		.x(HEX_out[0])
	);
	
	segment1 ONE(
		.c3(HEX_in[3]),
		.c2(HEX_in[2]),
		.c1(HEX_in[1]),
		.c0(HEX_in[0]),
		.x(HEX_out[1])
	);
	
	segment2 TWO(
		.c3(HEX_in[3]),
		.c2(HEX_in[2]),
		.c1(HEX_in[1]),
		.c0(HEX_in[0]),
		.x(HEX_out[2])
	);
	
	segment3 THREE(
		.c3(HEX_in[3]),
		.c2(HEX_in[2]),
		.c1(HEX_in[1]),
		.c0(HEX_in[0]),
		.x(HEX_out[3])
	);
	
	segment4 FOUR(
		.c3(HEX_in[3]),
		.c2(HEX_in[2]),
		.c1(HEX_in[1]),
		.c0(HEX_in[0]),
		.x(HEX_out[4])
	);
	
	segment5 FIVE(
		.c3(HEX_in[3]),
		.c2(HEX_in[2]),
		.c1(HEX_in[1]),
		.c0(HEX_in[0]),
		.x(HEX_out[5])
	);
	
	segment6 SIX(
		.c3(HEX_in[3]),
		.c2(HEX_in[2]),
		.c1(HEX_in[1]),
		.c0(HEX_in[0]),
		.x(HEX_out[6])
	);
endmodule

module segment0(c3, c2, c1, c0, x);
	input c3;
	input c2;
	input c1;
	input c0;
	output x;
	assign x = ~((c3 | c2 | c1 | ~c0) & (c3 | ~c2 | c1 | c0) & (~c3 | ~c2 | c1 | ~c0) & (~c3 | c2 | ~c1 | ~c0));
endmodule

module segment1(c3, c2, c1, c0, x);
	input c3;
	input c2;
	input c1;
	input c0;
	output x;
	assign x = ~((~c1 | ~c0 | ~c3) & (~c1 | c0 | ~c2) & (c1 | c0 | ~c3 | ~c2) & (c1 | ~c0 | c3 | ~c2));
endmodule

module segment2(c3, c2, c1, c0, x);
	input c3;
	input c2;
	input c1;
	input c0;
	output x;
	assign x = ~((~c3 | ~c2 | c1 | c0) & (~c1 | ~c3 | ~c2) & (c3 | c2 | ~c1 | c0));
endmodule

module segment3(c3, c2, c1, c0, x);
	input c3;
	input c2;
	input c1;
	input c0;
	output x;
	assign x = ~((c3 | ~c2 | c1 | c0) & (c2 | c1 | ~c0) & (~c2 | ~c1 | ~c0) & (~c3 | c2 | ~c1 | c0));
endmodule

module segment4(c3, c2, c1, c0, x);
	input c3;
	input c2;
	input c1;
	input c0;
	output x;
	assign x = ~((c1 | c0 | c3 | ~c2) & (c2 | c1 | ~c0) & (~c0 | c3));
endmodule

module segment5(c3, c2, c1, c0, x);
	input c3;
	input c2;
	input c1;
	input c0;
	output x;
	assign x = ~((~c0 | c3 | c2) & (c3 | ~c1 | ~c0) & (~c1 | c3 | c2) & (c1 | ~c0 | ~c3 | ~c2));
endmodule

module segment6(c3, c2, c1, c0, x);
	input c3;
	input c2;
	input c1;
	input c0;
	output x;
	assign x = ~((~c3 | ~c2 | c1 | c0) & (c1 | c3 | c2) & (~c1 | ~c0 | c3 | ~c2));
endmodule
