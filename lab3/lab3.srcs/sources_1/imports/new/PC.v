`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 14:28:30
// Design Name: 
// Module Name: PC
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


module PC(
	input [31:0] pc_in,
    input clk,
    input rst,
    output reg [31:0] pc_out
    );

	always @(posedge clk) begin
		if (rst) begin
			pc_out <= 32'b0;
		end
		else begin
			pc_out <= pc_in;
		end
	end
endmodule
