`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 23:59:14
// Design Name: 
// Module Name: display
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


module display(
    input [31:0] x,
    input clk,
    input reset,
    output reg [7:0] ans,
    output reg [6:0] seg
    );
    
    reg [3:0] num;
    reg [19:0] cnt;

    
    always@(posedge clk) begin
        if (reset) begin
            cnt = 0;
            ans = 8'b1111_1111;
        end
        
        cnt = cnt + 1;
        if (cnt < 10000) begin
            ans = 8'b1111_1110;
            num = x[3:0];
        end
        else if (cnt < 20000) begin
            ans = 8'b1111_1101;
            num = x[7:4];
        end
        else if (cnt < 30000) begin
            ans = 8'b1111_1011;
            num = x[11:8];
        end
        else if (cnt < 40000) begin
            ans = 8'b1111_0111;
            num = x[15:12];
        end
        else if (cnt < 50000) begin
            ans = 8'b1110_1111;
            num = x[19:16];
        end
        else if (cnt < 60000) begin
            ans = 8'b1101_1111;
            num = x[23:20];
        end
        else if (cnt < 70000) begin
            ans = 8'b1011_1111;
            num = x[27:24];
        end
        else if (cnt < 80000) begin
            ans = 8'b0111_1111;
            num = x[31:28];
        end
        else if (cnt == 80000) begin
             cnt = 0;
         end
    end
    
    always@(num)   
        case(num)
            0 : seg = 7'b000_0001;
            1 : seg = 7'b100_1111;
            2 : seg = 7'b001_0010;
            3 : seg = 7'b000_0110;
            4 : seg = 7'b100_1100;
            5 : seg = 7'b010_0100;
            6 : seg = 7'b010_0000;
            7 : seg = 7'b000_1111;
            8 : seg = 7'b000_0000;
            9 : seg = 7'b000_0100;
            10: seg = 7'b000_1000;
            11: seg = 7'b110_0000;
            12: seg = 7'b011_0001;
            13: seg = 7'b100_0010;
            14: seg = 7'b011_0000;
            15: seg = 7'b011_1000;
            default: begin seg = 7'b111_1111; end
        endcase

endmodule
