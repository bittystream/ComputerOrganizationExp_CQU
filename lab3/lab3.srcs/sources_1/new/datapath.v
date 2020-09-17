`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/30 21:12:35
// Design Name: 
// Module Name: datapath
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


module datapath(
	input clk, rst, memtoreg, pcsrc, alusrc, regdst, regwrite, jump,
	input  [2:0] 										 alucontrol,
    input  [31:0] 										   readdata,
    input  [31:0] 											  instr,
    output 													   zero,
//  output 												   overflow,
    output [31:0] 							  aluout, writedata, pc
    );

	wire [4:0] wa3;
	wire [31:0] pc_in, pcjump, pcnojump, pcplus4, pcbranch, rd1, rd2, wd3, num2, signimm, signimmsl2;

	assign writedata = rd2;

	//PC
	PC pc_0(
		.pc_in(pc_in),
		.clk(clk),
		.rst(rst),
		.pc_out(pc)
	);

	//获取PC+4的加法器
	adder adder_pc_plus4(
		.a(pc),
		.b(32'b100),
		.y(pcplus4)
	);

	//获取下一个PC的值的多选器
	mux2 get_pcjump_mux(
		.in1(pcnojump),
		.in2({pc[31:28],pcjump[27:0]}),
		.s(jump),
		.out(pc_in)
	);

	//寄存器堆
	regfile regi(
		.clk(clk),
		.we3(regwrite),
		.ra1(instr[25:21]),
		.ra2(instr[20:16]),
		.wa3(wa3),
		.wd3(wd3),
		.rd1(rd1),
		.rd2(rd2)
	);

	//ALU
	ALU alu_1(
		.op(alucontrol),
		.num1(rd1),
		.num2(num2),
		.zero(zero),
//		.overflow(overflow),
		.result(aluout)
	);

	//符号扩展
	signext se(
		.a(instr[15:0]),
		.y(signimm)
	);

	//符号扩展后左移两位
	sl2 sl_pcbranch(
		.a(signimm),
		.y(signimmsl2)
	);

	//获取分支地址的加法器(针对addi、sw、lw等指令)
	adder adder_pc_branch(
		.a(signimmsl2),
		.b(pcplus4),
		.y(pcbranch)
	);

	//获取跳转地址(j)
	sl2 sl_pcjump(
		.a({6'b0,instr[25:0]}),
		.y(pcjump)
	);

	//分支、PC+4多选器
	mux2 get_pcnojump_mux(
		.in1(pcplus4),
		.in2(pcbranch),
		.s(pcsrc),
		.out(pcnojump)
	);

	//获取写入寄存器堆的地址的多选器
	mux2 #(.WIDTH(5)) get_wa3_mux(
		.in1(instr[20:16]),
		.in2(instr[15:11]),
		.s(regdst),
		.out(wa3)
	);

	//获取ALU的另一个输入的多选器,对于add、sub等R-type指令,ALU的另一个输入是从寄存器堆里读出的数
	//对于addi、lw、sw等指令,ALU的另一个输入是符号扩展(在lw、sw下表示偏移量,addi下表示立即数)
	mux2 get_aluin_mux(
		.in1(rd2),
		.in2(signimm),
		.s(alusrc),
		.out(num2)
	);
	
	//获取写入寄存器堆数据的多选器
	mux2 get_wd3_mux(
		.in1(aluout),
		.in2(readdata),
		.s(memtoreg),
		.out(wd3)
	);	

	

endmodule
