`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/29 19:20:32
// Design Name: 
// Module Name: top
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


module top(
	input clk, rst,
	output memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, branch, 
//	output [7:0] ans,
//	output [6:0] seg,
	output [31:0] inst, pc
//	output [2:0] alucontrol
    );
//	wire clk_1hz;
	wire [31:0] pc_in;
	wire [2:0] alucontrol;
//	wire [31:0] pc;
//	wire [31:0] inst;

//	clk_div cd(
//		.clk(clk),
//		.rst(rst),
//		.clk_1hz(clk_1hz)	
//	);

//	display dp(
//		.x(inst),
//		.clk(clk),
//		.reset(rst),
//		.ans(ans),
//		.seg(seg)
//	);


	PC progcnt(
//		.clk(clk_1hz),
		.clk(clk),
		.rst(rst),
		.pc(pc_in),//pc_in
		.inst_ce(pc)//pc_out
	);

	inst_rom rom(
		.addra(pc),
//		.clka(~clk_1hz),
		.clka(~clk),
		.douta(inst)
	);

	controller ctrl(
		.op(inst[31:26]),
		.funct(inst[5:0]),
		.memtoreg(memtoreg), 
		.memwrite(memwrite), 
		.pcsrc(pcsrc), 
		.alusrc(alusrc), 
		.regdst(regdst), 
		.regwrite(regwrite), 
		.jump(jump), 
		.branch(branch),
		.alucontrol(alucontrol)
	);

endmodule
