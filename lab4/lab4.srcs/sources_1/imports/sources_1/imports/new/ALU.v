`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 23:57:04
// Design Name: 
// Module Name: ALU
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

/*添加分支指令，即通过条件判断是否需要跳转。
 *此处以beq指令为例。
 *其定义为：BEQ rs, rt, oﬀset。如果寄存器 rs 的值等于寄存器 rt 的值则转移，否则顺序执行
 */


module ALU(
    input 	signed [31:0] num1,
    input 	signed [31:0] num2,
    input  			  [2:0] op,
    output			  overflow,
    output 		 [31:0] result
    );
	
	assign result = (op == 3'b010) ? num1 + num2 :
					(op == 3'b110) ? num1 - num2 :
					(op == 3'b000) ? num1 & num2 :
					(op == 3'b001) ? num1 | num2 :
					(op == 3'b111) ? ((num1 < num2) ? 32'b1 : 32'b0) : 32'b0;
endmodule