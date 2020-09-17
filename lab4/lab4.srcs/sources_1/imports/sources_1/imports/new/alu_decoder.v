`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 14:34:56
// Design Name: 
// Module Name: alu_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: 暂时只包含了R型指令、lw、sw、beq、addi的alu有关decode。此模块如果用always进行赋值，会引起0.1ns的延时
// 
//////////////////////////////////////////////////////////////////////////////////

module alu_decoder(
	input  [5:0] funct,
	input  [1:0] aluop,
	output [2:0] alucontrol
    );
	
	assign alucontrol = (aluop == 2'b00)	  ? 3'b010 ://lw/sw/addi
						(aluop == 2'b01) 	  ? 3'b110 ://beq
						(aluop == 2'b11) 	  ? 3'b101 ://an anonymous signal
						(funct == 6'b10_0000) ? 3'b010 ://add
						(funct == 6'b10_0010) ? 3'b110 ://sub
						(funct == 6'b10_0100) ? 3'b000 ://and
						(funct == 6'b10_0101) ? 3'b001 ://or
						(funct == 6'b10_1010) ? 3'b111 : 3'b101;//slt and an anonymous signal

endmodule
