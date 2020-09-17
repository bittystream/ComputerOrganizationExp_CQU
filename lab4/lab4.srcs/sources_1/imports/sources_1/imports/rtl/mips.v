`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/07 10:58:03
// Design Name: 
// Module Name: mips
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


module mips(
	input wire clk,rst,
	input wire[31:0] readdata,
	input wire[31:0] instr,
	output wire memwrite,
	output wire[31:0] aluout, writedata, pc
    );
	
	wire memtoregE,memtoregW,memtoregM,alusrc,regdst,regwriteE,regwriteW,regwriteM,pcsrc,equalD,branchD,flushE,jump;//zero,overflow;	
	wire[2:0] alucontrol;
	wire [31:0] instrD;

	controller c(
		.op(instrD[31:26]),
		.funct(instrD[5:0]),
//		.zero(zero),
		.equalD(equalD),
		.clk(clk),
		.rst(rst),
		.memtoregW(memtoregW),
		.memtoregM(memtoregM),
		.memtoregE(memtoregE),
		.memwrite(memwrite),
		.flushE(flushE),
		.branchD(branchD),
		.pcsrc(pcsrc),
		.alusrc(alusrc),
		.regdst(regdst),
		.regwriteW(regwriteW),
		.regwriteM(regwriteM),
		.regwriteE(regwriteE),
		.jump(jump),
		.alucontrol(alucontrol)
	);

	datapath dp(
		.clk(clk),
		.rst(rst),
		.pcsrc(pcsrc),
		.alusrc(alusrc),
		.regdst(regdst),
		.branchD(branchD),
		.regwriteW(regwriteW),
		.regwriteM(regwriteM),
		.regwriteE(regwriteE),
		.memtoregE(memtoregE),
		.memtoregM(memtoregM),
		.memtoregW(memtoregW),
		.jump(jump),
		.alucontrol(alucontrol),
		.equalD(equalD),
		.instr(instr),
		.aluoutM(aluout),
		.flushE(flushE),
		.writedataM(writedata),
		.readdata(readdata),
		.pc(pc),
		.instrD(instrD)
	);
	
endmodule
