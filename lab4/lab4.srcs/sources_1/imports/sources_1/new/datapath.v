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
// Description: 5-stage pipelined processor
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: stage 1: Fetch(取址)
//						stage 2: Decode(译码)
//						stage 3: Execute(执行)
//						stage 4: Memory(访存)
//						stage 5: Writeback(回写)
//						按照各级从左向右排列各模块
//////////////////////////////////////////////////////////////////////////////////


module datapath(
	input clk, rst,
	input pcsrc, branchD, regwriteE, regwriteW, regwriteM, memtoregE, memtoregM, memtoregW, regdst, alusrc,jump,
	input  [2:0] alucontrol,
    input [31:0] readdata,
    input [31:0] instr,
    output equalD, flushE,
    output [31:0] aluoutM, writedataM, pc, instrD
    );

	//wires for stage Fetch
	wire [31:0] pc_in, pcplus4F, pcjump, pcnojump, pcbranch;
	wire stallF;

	//wires for stage Decode
	wire [31:0] pcplus4D, rd1D, rd2D, e1, e2, num1, num2, signimmD, signimmsl2;
	wire [4:0] rtD, rsD, rdD;
	wire stallD, forwardAD, forwardBD;

	//wires for stage Execute
	wire [31:0] rd1E, rd2E, signimmE, pcplus4E, aluoutE, writedataE;
	wire [4:0] rtE, rdE, rsE, writeregE;
	wire [1:0] forwardAE, forwardBE;

	//wires for stage Memory
	wire [31:0] pcbranchM;
	wire [4:0] writeregM;

	//wires for stage Writeback
	wire [31:0] aluoutW, readdataW, resultW;
	wire [4:0] writeregW;



	assign rsD = instrD[25:21];
	assign rtD = instrD[20:16];
	assign rdD = instrD[15:11];
	
	hazard haz(
		//stage Fetch
		.stallF(stallF),

		//stage Decode
		.rsD(rsD),
		.rtD(rtD),
		.branchD(branchD),
		.stallD(stallD),
		.forwardAD(forwardAD),
		.forwardBD(forwardBD),
		.regdst(regdst),

		//stage Execute
		.rsE(rsE),
		.rtE(rtE),
		.memtoregE(memtoregE),
		.regwriteE(regwriteE),
		.writeregE(writeregE),
		.forwardBE(forwardBE),
		.forwardAE(forwardAE),
		.flushE(flushE),

		//stage Memory
		.regwriteM(regwriteM),
		.memtoregM(memtoregM),
		.writeregM(writeregM),

		//stage Writeback
		.regwriteW(regwriteW),
		.writeregW(writeregW)
	);

	//分支、PC+4多选器
	mux2 mux2_pcin(
		.in1(pcplus4F),
		.in2(pcbranch),
		.s(pcsrc),
		.out(pcnojump)
	);

	//获取下一个PC的值的多选器
	mux2 mux2_pcjump(
		.in1(pcnojump),
		.in2({pcplus4D[31:28],pcjump[27:0]}),
		.s(jump),
		.out(pc_in)
	);

	//PC
	PC pc_0(
		.pc_in(pc_in),
		.clk(clk),
		.rst(rst),
		.en(~stallF),
		.pc_out(pc)
	);

	//获取PC+4的加法器
	adder adder_pc_plus4(
		.a(pc),
		.b(32'b100),
		.y(pcplus4F)
	);
	//instruction memory

	//Fetch -> Decode 触发器
	flopenrc F2D_pcplus4(.clk(clk),.rst(rst),.en(~stallD),.clr(pcsrc),.d(pcplus4F),.q(pcplus4D));
	flopenrc F2D_instr(.clk(clk),.rst(rst),.en(~stallD),.clr(pcsrc),.d(instr),.q(instrD));
	//assign instrD = instr;
	
	//寄存器堆
	regfile regi(
		.clk(~clk),
		.we3(regwriteW),
		.ra1(rsD),
		.ra2(rtD),
		.wa3(writeregW),
		.wd3(resultW),
		.rd1(rd1D),
		.rd2(rd2D)
	);
	//符号扩展
	signext se(
		.a(instrD[15:0]),
		.y(signimmD)
	);

	//获取跳转地址(j)
	sl2 sl_pcjump(
		.a({6'b0,instrD[25:0]}),
		.y(pcjump)
	);
	
	//符号扩展后左移两位
	sl2 sl_pcbranch(
		.a(signimmD),
		.y(signimmsl2)
	);
	//获取分支地址的加法器(针对addi、sw、lw等指令)
	adder adder_pc_branch(
		.a(signimmsl2),
		.b(pcplus4D),
		.y(pcbranch)
	);


	mux2 mux2_e1(
		.in1(rd1D),
		.in2(aluoutM),
		.s(forwardAD),
		.out(e1)
	);

	mux2 mux2_e2(
		.in1(rd2D),
		.in2(aluoutM),
		.s(forwardBD),
		.out(e2)
	);

	eqcmp cmp(.a(e1),.b(e2),.y(equalD));//初始化的时候regfile里取出来的数为x,运算后导致equalD也为x
	
	//Decode -> Execute
	floprc 				D2E_rd1(.clk(clk),.rst(rst),.clr(flushE),.d(rd1D),.q(rd1E));
	floprc 				D2E_rd2(.clk(clk),.rst(rst),.clr(flushE),.d(rd2D),.q(rd2E));
	floprc #(.WIDTH(5)) D2E_rs(.clk(clk),.rst(rst),.clr(flushE),.d(rsD),.q(rsE));
	floprc #(.WIDTH(5)) D2E_rt(.clk(clk),.rst(rst),.clr(flushE),.d(rtD),.q(rtE));
	floprc #(.WIDTH(5)) D2E_rd(.clk(clk),.rst(rst),.clr(flushE),.d(rdD),.q(rdE));
	floprc 				D2E_signimm(.clk(clk),.rst(rst),.clr(flushE),.d(signimmD),.q(signimmE));

	//获取写入寄存器堆的地址的多选器
	mux2 #(.WIDTH(5)) mux2_writeaddr(
		.in1(rtE),
		.in2(rdE),
		.s(regdst),
		.out(writeregE)
	);

	mux3 mux3_alu1(
		.d0(rd1E),
		.d1(resultW),
		.d2(aluoutM),
		.s(forwardAE),
		.y(num1)
	);

	mux3 mux3_alu2(
		.d0(rd2E),
		.d1(resultW),
		.d2(aluoutM),
		.s(forwardBE),
		.y(writedataE)
	);

	//获取ALU的另一个输入的多选器,对于add、sub等R-type指令,ALU的另一个输入是从寄存器堆里读出的数
	//对于addi、lw、sw等指令,ALU的另一个输入是符号扩展(在lw、sw下表示偏移量,addi下表示立即数)
	mux2 mux2_aluin(
		.in1(writedataE),
		.in2(signimmE),
		.s(alusrc),
		.out(num2)
	);
	//ALU
	ALU alu_1(
		.op(alucontrol),
		.num1(num1),
		.num2(num2),
//		.overflow(overflow),
		.result(aluoutE)
	);
	
	//Execute -> Memory
	flopr 			   E2M_aluout(.clk(clk),.rst(rst),.d(aluoutE),.q(aluoutM));
	flopr 			   E2M_writedata(.clk(clk),.rst(rst),.d(writedataE),.q(writedataM));
	flopr #(.WIDTH(5)) E2M_writereg(.clk(clk),.rst(rst),.d(writeregE),.q(writeregM));
//	floprc E2M_pcbranch(.clk(clk),.rst(rst),.clr(1'b0),.d(pcbranch),.q(pcbranchM));
//	floprc #(.WIDTH(1)) E2M_zero(.clk(clk),.rst(rst),.clr(1'b0),.d(zero),.q(zeroM));


	//Memory -> Writeback
	flopr 			   M2W_aluout(.clk(clk),.rst(rst),.d(aluoutM),.q(aluoutW));
	flopr 			   M2W_readdata(.clk(clk),.rst(rst),.d(readdata),.q(readdataW));
	flopr #(.WIDTH(5)) M2W_writereg(.clk(clk),.rst(rst),.d(writeregM),.q(writeregW));
	
	
	//获取写入寄存器堆数据的多选器
	mux2 mux2_writereg(
		.in1(aluoutW),
		.in2(readdataW),
		.s(memtoregW),
		.out(resultW)
	);	

	

endmodule
