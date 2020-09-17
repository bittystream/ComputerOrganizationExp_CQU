`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 14:34:42
// Design Name: 
// Module Name: main_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: 暂时只包含了R型指令、lw、sw、beq、addi的alu有关decode
// 
//////////////////////////////////////////////////////////////////////////////////

`define R_type 6'b0
`define lw 6'b100011
`define sw 6'b101011
`define beq 6'b000100
`define addi 5'b001000
`define j 6'b000010

module main_decoder(
	input [5:0]  op,
	output regwrite,memtoreg,memwrite,alusrc,regdst,branch,
	output [1:0] aluop,
	output jump
    );

	assign {regwrite,memtoreg,memwrite,alusrc,regdst,branch,aluop} = (op == `R_type) 	? 8'b1_0_0_0_1_0_10 :
															  		 (op == `lw)		? 8'b1_1_0_1_0_0_00 :
				  		  											 (op == `sw)	 	? 8'b0_0_1_1_0_0_00 :
				  		  											 (op == `beq)		? 8'b0_0_0_0_0_1_01 :
				  		  											 (op == `addi)		? 8'b1_0_0_1_0_0_00 : 
											  											  8'b0_0_0_0_0_0_11 ;//aluop being 11 is meaningless
	assign jump = (op == `j) ? 1'b1 : 1'b0;
	
endmodule
