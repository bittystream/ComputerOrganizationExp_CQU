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
    input clk,
    input rst,
    output reg [31:0] pc,
    output [31:0] inst_ce
    );

	assign inst_ce = pc;
	always @(posedge clk) begin
		if (rst) begin
			pc <= 8'h0000;
		end
		else begin
			pc <= pc + 8'h0004;
		end
	end
endmodule
