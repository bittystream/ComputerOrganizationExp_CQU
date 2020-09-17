`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/30 21:39:09
// Design Name: 
// Module Name: mux2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux2 #(parameter WIDTH = 32)
(
	input  [WIDTH-1:0] in1,
	input  [WIDTH-1:0] in2,
	input			  	 s,
	output [WIDTH-1:0] out
    );

	assign out = (s == 0) ? in1 : in2;


endmodule
