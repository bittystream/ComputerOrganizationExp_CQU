`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/10 22:51:43
// Design Name: 
// Module Name: hazard
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


module hazard(
	input [4:0] rsD, rtD, rsE, rtE, writeregM, writeregW, writeregE,
	input regdst,regwriteE, regwriteM, regwriteW, memtoregE, memtoregM, branchD,//ctrl signal
	output [1:0] forwardAE, forwardBE,
	output stallF, stallD, flushE, forwardAD, forwardBD
    );
	
	wire lwstall, branchstall;
	
	assign forwardAE = (regwriteM && (rsE != 5'b0) && (rsE == writeregM)) ? 2'b10 : 
					   (regwriteW && (rsE != 5'b0) && (rsE == writeregW)) ? 2'b01 : 2'b00;

	assign forwardBE = (regwriteM && (rtE != 5'b0) && (rtE == writeregM)) ? 2'b10 : 
					   (regwriteW && (rtE != 5'b0) && (rtE == writeregW)) ? 2'b01 : 2'b00;


	assign lwstall =  ((rsD == rtE) || (rtD == rtE)) && memtoregE;
	assign branchstall = branchD && regwriteE && (writeregE == rsD || writeregE == rtD) ||
						 branchD && memtoregM && (writeregM == rsD || writeregM == rtD) ;


	assign stallF = lwstall || branchstall;
	assign stallD = lwstall || branchstall;
	assign flushE = lwstall || branchstall;
	assign forwardAD = (rsD != 0) && (rsD == writeregM) && regwriteM;
	assign forwardBD = (rtD != 0) && (rtD == writeregM) && regwriteM;

endmodule
