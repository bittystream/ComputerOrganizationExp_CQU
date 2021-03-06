`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/02 14:20:09
// Design Name: 
// Module Name: regfile
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


module regfile(
	input wire clk,
	input wire we3,//写使能信号
	input wire[4:0] ra1,ra2,//读地址
	input wire[4:0] wa3,//写地址
	input wire[31:0] wd3,//写数据
	output wire[31:0] rd1,rd2//读数据
    );

	reg [31:0] rf[31:0];

	always @(posedge clk) begin
		if(we3) begin
			 rf[wa3] <= wd3;
		end
	end

	assign rd1 = (ra1 != 5'b0) ? rf[ra1] : 32'b0;
	assign rd2 = (ra2 != 5'b0) ? rf[ra2] : 32'b0;
endmodule
