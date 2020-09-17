`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/29 19:58:43
// Design Name: 
// Module Name: ctrl_sim
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


module ctrl_sim(

    );

	reg clk = 1;
	reg rst = 1;
	wire memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, branch;
	wire [1:0] aluop;
	wire [2:0] alucontrol;
	wire [31:0] inst;

	controller ctrl(.clk(clk),
			 .rst(rst),
			 .instr(inst),
			 .zero(zero),
			 .memtoreg(memtoreg),
			 .memwrite(memwrite), 
			 .pcsrc(pcsrc), 
			 .alusrc(alusrc), 
			 .regdst(regdst), 
			 .regwrite(regwrite), 
			 .jump(jump), 
			 .branch(branch), 
//			 .aluop(aluop),
			 .alucontrol(alucontrol)
			 );

	always #10 clk = ~clk;

	always #20 $display("instruction: 32'b%b",inst);

	initial begin
		$display("simulation started.");
		#10 rst = ~rst;
	end

endmodule
