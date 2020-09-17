`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/10 18:18:21
// Design Name: 
// Module Name: flopenrc
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


module flopenrc #(parameter WIDTH = 32)(
	input wire clk, rst, en, clr,
	input wire [WIDTH-1:0] d,
	output reg [WIDTH-1:0] q
    );

	always @(posedge clk) begin
		if (rst) begin
			q <= 0;			
		end
		else if (clr) begin
			q <= 0;
		end
		else if (en) begin
			q <= d;
		end
	end
endmodule
