`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/10 18:18:00
// Design Name: 
// Module Name: floprc
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


module floprc #(parameter WIDTH = 32)(
	input wire clk, rst, clr,
	input wire [WIDTH-1:0] d,
	output reg [WIDTH-1:0] q
    );

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			q <= 0;			
		end
		else if (clr) begin
			q <= 0;
		end
		else begin
			q <= d;
		end
	end
endmodule
