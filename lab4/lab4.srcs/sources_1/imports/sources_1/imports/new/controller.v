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
	input		 equalD,clk,rst,flushE,
	output 		 branchD, memtoregE, memtoregM, memtoregW, memwrite, pcsrc, alusrc, regdst, regwriteW, regwriteM, regwriteE, jump,
	output [2:0] alucontrol
    );
	
	wire [1:0] aluop;
	wire [2:0] alucontrolD, alucontrolE;

	wire regwriteD, memtoregD, memwriteD, alusrcD, regdstD, branchD;
	wire regwriteE, memtoregE, memwriteE, alusrcE, regdstE;
	wire regwriteM, memtoregM, memwriteM;
	wire regwriteW, memtoregW;

	assign pcsrc = branchD & equalD;
	assign alusrc = alusrcE;
	assign regdst = regdstE;
	assign alucontrol = alucontrolE;
	assign memwrite = memwriteM;

	main_decoder maindec(.op(op),
						 .regwrite(regwriteD),
						 .memtoreg(memtoregD),
						 .memwrite(memwriteD),
						 .alusrc(alusrcD),
						 .regdst(regdstD),
						 .branch(branchD),
						 .aluop(aluop),
						 .jump(jump)
						 );

	alu_decoder aludec(.funct(funct),
					   .aluop(aluop),
					   .alucontrol(alucontrolD)
					   );

	floprc #(.WIDTH(5)) D2E_sigs(.clk(clk),.rst(rst),.clr(flushE),
								 .d({regwriteD,memtoregD,memwriteD,alusrcD,regdstD}),
								 .q({regwriteE,memtoregE,memwriteE,alusrcE,regdstE})
								 );

	floprc #(.WIDTH(3)) D2E_aluctrl(.clk(clk),.rst(rst),.clr(flushE),.d(alucontrolD),.q(alucontrolE));

	flopr #(.WIDTH(3)) E2M_sigs(.clk(clk),.rst(rst),
								.d({regwriteE,memtoregE,memwriteE}),
								.q({regwriteM,memtoregM,memwriteM})
								);

	flopr #(.WIDTH(2)) M2W_sigs(.clk(clk),.rst(rst),
								.d({regwriteM,memtoregM}),
								.q({regwriteW,memtoregW})
								);
endmodule
