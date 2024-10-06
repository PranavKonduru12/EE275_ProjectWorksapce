`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2024 10:04:16 PM
// Design Name: 
// Module Name: FullAddr64
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


module fulladd64(
    output [63:0] sum, 
    output cout, 
    input [63:0] a, b, 
    input cin
);
    wire [63:0] carry;
    
    
    
    // 64 instances of 1-bit full adder
    fulladd fa0 (.sum(sum[0]), .cout(carry[0]), .a(a[0]), .b(b[0]), .cin(cin));
    genvar i;
    generate
        for (i = 1; i < 64; i = i + 1) begin : adder_loop
            fulladd fa (.sum(sum[i]), .cout(carry[i]), .a(a[i]), .b(b[i]), .cin(carry[i-1]));
        end
    endgenerate

    assign cout = carry[63];
endmodule
