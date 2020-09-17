`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/29 19:48:19
// Design Name: 
// Module Name: controller
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

//需要实现 add、and、sub、or、slt、beq、j、lw、sw、addi 
module controller(
	input [5:0]  op,
	input [5:0]  funct,
	input		 zero,
	output 		 memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, branch,
	output [2:0] alucontrol
    );

	wire [1:0] aluop;
	main_decoder maindec(.op(op),
						 .zero(zero),
						 .memtoreg(memtoreg), 
						 .memwrite(memwrite), 
						 .pcsrc(pcsrc), 
						 .alusrc(alusrc), 
						 .regdst(regdst), 
						 .regwrite(regwrite), 
						 .jump(jump), 
						 .branch(branch), 
						 .aluop(aluop)
						 );

	alu_decoder aludec(.funct(funct),
					   .aluop(aluop),
					   .alucontrol(alucontrol)
					   );

endmodule
