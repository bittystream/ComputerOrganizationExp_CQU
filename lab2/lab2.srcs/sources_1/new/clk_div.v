`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/22 01:04:34
// Design Name: 
// Module Name: clk_div
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


module clk_div(
    input clk,
    input rst,
    output reg clk_1hz
    );

	reg [23:0] cnt;

	always @(posedge clk) begin
		if (rst) begin
			cnt <= 0;
			clk_1hz <= 0;
		end
		else begin
			cnt <= cnt + 1;
		end
		if (cnt == 10000000) begin//100M(10E8)Hz --> 1Hz
			clk_1hz <= ~clk_1hz;
		end
	end

endmodule
