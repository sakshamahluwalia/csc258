//SW[2:0] data inputs
//SW[9] select signal

//LEDR[0] output display

module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
  
    assign m = s & y | ~s & x;
    // OR
    // assign m = s ? y : x;
endmodule

module mux4to1(SW, LEDR);
    input [9:0] SW;
    output [9:0] LEDR;

    wire connection_0; //connect from mux0 to mux2
    wire connection_1; //connect from mux1 to mux2

    mux2to1 mux0(
	.x(SW[0]), // SW[0] represents u
	.y(SW[1]), // SW[1] represents v
	.s(SW[9]), // SW[9] represents s_0
	.m(connector_0)
    );

    mux2to1 mux1(
	.x(SW[2]), // SW[2] represents w
	.y(SW[3]), // SW[3] represents x
	.s(SW[9]), // SW[9] represents s_0
	.m(connector_1)
    );

    mux2to1 mux2(
	.x(connector_0), // output from mux0
	.y(connector_1), // output from mux1
	.s(SW[8]), // SW[8] represents s_1
	.m(LEDR[0])
    );
endmodule
    
