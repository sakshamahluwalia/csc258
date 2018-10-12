// Part 2 skeleton

module part2
	(
	CLOCK_50,						//	On Board 50 MHz
	// Your inputs and outputs here
        KEY,
        SW,
	// The ports below are for the VGA output.  Do not change.
	VGA_CLK,   						//	VGA clk
	VGA_HS,							//	VGA H_SYNC
	VGA_VS,							//	VGA V_SYNC
	VGA_BLANK_N,						//	VGA BLANK
	VGA_SYNC_N,						//	VGA SYNC
	VGA_R,   						//	VGA Red[9:0]
	VGA_G,	 						//	VGA Green[9:0]
	VGA_B   						//	VGA Blue[9:0]
	);

	input	CLOCK_50;				//	50 MHz
	input   [9:0]   SW;
	input   [3:0]   KEY;

	// Declare your inputs and outputs here
	// Do not change the following outputs
	output	VGA_CLK;   				//	VGA clk
	output	VGA_HS;					//	VGA H_SYNC
	output	VGA_VS;					//	VGA V_SYNC
	output	VGA_BLANK_N;				//	VGA BLANK
	output	VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   			//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 			//	VGA Green[9:0]
	output	[9:0]	VGA_B;   			//	VGA Blue[9:0]

	wire resetn;
	assign resetn = KEY[0];

	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;

	wire ld_x, ld_y, ld_colour, enable;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clk(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";

	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.

	// output ld_x;
	// output ld_y;
	// output ld_colour;
	// output writeEn;
	// output enable;


	// Instantiate datapath
	// datapath d0(...);
	datapath d0(
		.clk(CLOCK_50),
		.ld_x(ld_x),
		.ld_y(ld_y),
		.ld_colour(ld_colour),
		.resetn(resetn),
		.enable(enable),
		.colour_in(SW[9:7]),
		.coord(SW[6:0]),
		.x_out(x),
		.y_out(y),
		.colour_out(colour)
		);

	// Instantiate FSM control
	// control c0(...);
	control c0(
		.clk(CLOCK_50),
		.resetn(resetn),
		.ld(KEY[3]),
		.fill(KEY[1]),
		.ld_x(ld_x),
		.ld_y(ld_y),
		.ld_colour(ld_colour),
		.writeEn(writeEn),
		.enable(enable)
		);

endmodule

module datapath
	(
		clk,
		ld_x,
		ld_y,
		ld_colour,
		resetn,
		enable,
		colour_in,
		coord,
		x_out,
		y_out,
		colour_out
	);

	input clk;
	input ld_x;
	input ld_y;
	input ld_colour;
	input resetn;
	input enable;
	input [2:0] colour_in;
	input [6:0] coord;

	output [7:0] x_out;
	output [6:0] y_out;
	output [2:0] colour_out;

	reg [2:0] count_x, count_y;
	reg [7:0] x;
	reg [6:0] y;
	reg [2:0] colour;

	wire y_enable;


	// registers for x, y and color
	always @(posedge clk) begin
		if (!resetn) begin
			x <= 8'b0;
			y <= 7'b0;
			colour <= 3'b0;
		end
		else begin
			if (ld_x)
				x <= {1'b0, coord};
			if (ld_y)
				y <= coord;
			if (ld_colour)
				colour <= colour_in;
		end
	end

	// counter for x
	always @(posedge clk) begin
		if (!resetn)
			count_x <= 2'b00;
		else if (enable) begin
			if (count_x == 2'b11)
				count_x <= 2'b00;
			else begin
				count_x <= count_x + 1'b1;
			end
		end
	end

	assign y_enable = (count_x == 2'b11) ? 1 : 0;

	// counter for y
	always @(posedge clk) begin
		if (!resetn)
			count_y <= 2'b00;
		else if (enable && y_enable) begin
			if (count_y != 2'b11)
				count_y <= count_y + 1'b1;
			else
				count_y <= 2'b00;
		end
	end

	assign x_out = x + count_x;
	assign y_out = y + count_y;
	assign colour_out = colour;

endmodule

module control
	(
		clk,
		resetn,
		ld,
		fill,
		ld_x,
		ld_y,
		ld_colour,
		writeEn,
		enable
	);
	input clk;
	input resetn;
	input ld;
	input fill;

	output reg ld_x;
	output reg ld_y;
	output reg ld_colour;
	output reg writeEn;
	output reg enable;

	reg [2:0] current_state, next_state;

	// States
	localparam 	load_x = 3'd0,
				load_x_wait = 3'd1,
				load_y_colour = 3'd2,
				load_y_colour_wait = 3'd3,
				draw = 3'd4;

	// State Table
	always @(*) begin
		case (current_state)
			load_x: next_state = ld ? load_x_wait : load_x;
			load_x_wait: next_state = ld ? load_x_wait : load_y_colour;
			load_y_colour: next_state = fill ? load_y_colour : load_y_colour;
			load_y_colour_wait: next_state = fill ? load_y_colour_wait : draw;
			draw: next_state = ld ? load_x : draw;
		endcase
	end

	// Output Logic
	always @(*) begin
		ld_x = 1'b0;
		ld_y = 1'b0;
		ld_colour = 1'b0;
		writeEn = 1'b0;

		case (current_state)
			load_x: begin
				ld_x = 1;
				enable = 1;
			end
			load_x_wait: begin
				ld_x = 1;
				enable = 1;
			end
			load_y_colour: begin
				ld_y = 1;
				ld_colour = 1;
				enable = 1;
			end
			load_y_colour_wait: begin
				ld_y = 1;
				ld_colour = 1;
				enable = 1;
			end
			draw: begin
				writeEn = 1;
				enable = 1;
			end
		endcase
	end

	// Current State Register
	always @(posedge clk) begin
		if (!resetn)
			current_state <= load_x;
		else
			current_state <= next_state;
	end

endmodule

module question3(
		clk,
		resetn,
		ld,
		fill,
		colour_in,
		coord,
		x_out,
		y_out,
		colour_out
	);
	input clk;
	input resetn;
	input ld;
	input fill;
	input [2:0] colour_in;
	input [6:0] coord;
	output [7:0] x_out;
	output [6:0] y_out;
	output [2:0] colour_out;

	wire ld_x, ld_y, ld_colour, enable, writeEn;


	// Instantiate datapath
	// datapath d0(...);
	datapath d0(
		.clk(clk),
		.ld_x(ld_x),
		.ld_y(ld_y),
		.ld_colour(ld_colour),
		.resetn(resetn),
		.enable(enable),
		.colour_in(colour_in),
		.coord(coord),
		.x_out(x_out),
		.y_out(y_out),
		.colour_out(colour_out)
		);

	// Instantiate FSM control
	// control c0(...);
	control c0(
		.clk(clk),
		.resetn(resetn),
		.ld(ld),
		.fill(fill),
		.ld_x(ld_x),
		.ld_y(ld_y),
		.ld_colour(ld_colour),
		.writeEn(writeEn),
		.enable(enable)
		);
endmodule
