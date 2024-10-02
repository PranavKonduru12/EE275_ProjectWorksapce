`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2024 02:07:21 PM
// Design Name: 
// Module Name: HalfAdder_tb
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


module HalfAdder_tb();
    reg a, b;
    wire sum, carry;
    
    Half_Adder myHalf_tb(.a(a), .b(b), .sum(sum), .carry(carry));
    
    initial
        begin
            a = 1'b1;
            b = 1'b1;
            #50;
            a = 1'b1;
            b = 1'b0;
            #50;
            $stop;
        end
    
endmodule
