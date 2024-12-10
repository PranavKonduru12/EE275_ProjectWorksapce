`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 03:44:12 PM
// Design Name: 
// Module Name: mux
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

module mux(
    input wire [63:0] in1, 
    input wire [63:0] in2, 
    input wire sel,
//    output reg [63:0] out
    output wire [63:0] out
);
//    always @(in1 or in2 or sel) begin
//        if (sel)
//            out <= in2;
//        else
//            out <= in1;
//    end
    // Use continuous assignment for simplicity
    //reduces the potential for unintended latch synthesis.
    assign out = sel ? in2 : in1;
endmodule

