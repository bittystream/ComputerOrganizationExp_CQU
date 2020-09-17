`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/07 13:50:53
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
	input wire clk, rst,
	output wire[31:0] writedata, dataadr, pc,
	output wire memwrite
);
	// wire clk;
	wire[31:0] readdata, instr;


	//   clk_div instance_name(
 //    	// Clock out ports
	//     .clk_out1(hclk),     // output clk_out1
	//    // Clock in ports
	//     .clk_in1(clk)
 //    	); 
   	


 	mips mips_0(
 		.clk(clk),
 		.rst(rst),
 		.instr(instr),
 		.memwrite(memwrite),
 		.aluout(dataadr),
 		.writedata(writedata),
 		.readdata(readdata),
 		.pc(pc)
 	);

	inst_mem imem(
		.clka(~clk),
		.addra(pc),
		.douta(instr)
	);
	
	data_mem dmem(
		.clka(~clk),
		.wea({4{memwrite}}),
		.addra(dataadr),
		.dina(writedata),
		.douta(readdata)
	);

endmodule
