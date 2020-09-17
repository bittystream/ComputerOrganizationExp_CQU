`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/10 22:38:40
// Design Name: 
// Module Name: mux3
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


module mux3 #(parameter WIDTH = 32)(
	input [WIDTH-1:0] d0, d1, d2,
	input [1:0] s,
	output [WIDTH-1:0] y
    );

	assign y = (s == 2'b00) ? d0 :
			   (s == 2'b01) ? d1 :
			   (s == 2'b10) ? d2 : d0;

endmodule
