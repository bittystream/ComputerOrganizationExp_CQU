`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/31 19:37:46
// Design Name: 
// Module Name: top_sim
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


module top_sim(

    );
	
	reg clk = 1;
	reg rst = 1;
	wire [31:0] writedata, instr, dataadr;
	wire memwrite;
	wire [4:0] rs, rt, rd;

	top topmudule(
		.clk(clk),
		.rst(rst),
		.writedata(writedata),
		.memwrite(memwrite),
		.instr(instr),
		.dataadr(dataadr)
	);

	assign rs = instr[25:21];
	assign rt = instr[20:16];
	assign rd = instr[15:11];
	always #10 clk = ~clk;

	initial begin
		#200 rst = ~rst;
	end

endmodule
