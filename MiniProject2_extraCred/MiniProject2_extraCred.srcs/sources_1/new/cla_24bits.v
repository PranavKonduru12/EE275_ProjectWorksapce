`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 05:10:13 PM
// Design Name: 
// Module Name: cla_24bits
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

// Carry Look-Ahead Adder Module\
module cla_24bit(
    input wire [23:0] a,
    input wire [23:0] b,
    input wire cin,
    output wire [23:0] sum,
    output wire carry_out
);
    wire [23:0] g, p, c;

    // Generate and Propagate
    assign g = a & b;
    assign p = a ^ b;

    // Carry Generation
    assign c[0] = cin;
    generate
        genvar i;
        for (i = 1; i < 24; i = i + 1) begin : carry_gen
            assign c[i] = g[i-1] | (p[i-1] & c[i-1]);
        end
    endgenerate

    // Sum Calculation
    assign sum = p ^ c;
    assign carry_out = g[23] | (p[23] & c[23]);

endmodule
