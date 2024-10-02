`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2024 01:04:06 PM
// Design Name: 
// Module Name: Half_Adder
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


module Half_Adder(
    input a, b,
    output sum, carry
    );
    //wire a_carry, b_carry;
    xor(sum, a, b);
    
//    assign c = a;
//    assign d = b;
    
    and(carry, c, d);
endmodule
