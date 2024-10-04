`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2024 03:29:08 PM
// Design Name: 
// Module Name: FullAddr_32
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


module fulladd32(
    output [31:0] sum, 
    output cout, 
    input [31:0] a, b, 
    input cin
);
    wire [31:0] carry;
    
    
    
    // 32 instances of 1-bit full adder
    fulladd fa0 (.sum(sum[0]), .cout(carry[0]), .a(a[0]), .b(b[0]), .cin(cin));
    genvar i;
    generate
        for (i = 1; i < 32; i = i + 1) begin : adder_loop
            fulladd fa (.sum(sum[i]), .cout(carry[i]), .a(a[i]), .b(b[i]), .cin(carry[i-1]));
        end
    endgenerate

    assign cout = carry[31];
endmodule
