`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/11 19:14:36
// Design Name: 
// Module Name: eqcmp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: to compare if a is equal to b
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module eqcmp #(parameter WIDTH = 32)(
	input [WIDTH-1:0] a, b,
	output y
    );

	assign y = (a == b) ? 1'b1 : 1'b0;
endmodule
