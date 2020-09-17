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
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define R_type 6'b0
`define lw 6'b100011
`define sw 6'b101011
`define beq 6'b000100
`define addi 5'b001000
`define j 6'b000010

module main_decoder(
	input [5:0] op,
	output memtoreg, memwrite, alusrc, regdst, regwrite, jump, branch, 
	output [1:0] aluop
    );	

	assign {regwrite,regdst,alusrc,branch,memwrite,memtoreg,aluop,jump} = (op == `R_type) ? 9'b1_1_0_0_0_0_10_0 :
																		  (op == `lw)	  ? 9'b1_0_1_0_0_1_00_0 :
																		  (op == `sw)	  ? 9'b0_0_1_0_1_1_00_0 :
																		  (op == `beq)	  ? 9'b0_1_0_1_0_1_01_0 :
																	      (op == `addi)	  ? 9'b1_0_1_0_0_0_00_0 :
																	 	  (op == `j)	  ? 9'b0_0_0_0_0_0_11_1 : 
																	 	  					9'b0_0_0_0_0_0_11_0 ;


endmodule
