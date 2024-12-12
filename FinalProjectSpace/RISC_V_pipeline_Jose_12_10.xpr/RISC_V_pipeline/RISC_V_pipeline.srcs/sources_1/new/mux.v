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
    input wire [63:0] in1,           // Integer input 1
    input wire [63:0] in2,           // Integer input 2
    input wire [31:0] floatIn1,      // Floating-point input 1
    input wire [31:0] floatIn2,      // Floating-point input 2
    input wire sel,                  // Select signal
    input wire isFloat,              // Data type selector: 1 = Floating-point, 0 = Integer
    output reg [63:0] out            // Output
);
    always @(*) begin
        if (isFloat) begin
            // Handle floating-point data
            if (sel)
                out <= {32'b0, floatIn2}; // Zero-extend 32-bit floating-point input 2
            else
                out <= {32'b0, floatIn1}; // Zero-extend 32-bit floating-point input 1
        end else begin
            // Handle integer data
            if (sel)
                out <= in2;
            else
                out <= in1;
        end
    end
endmodule

//module mux(
//    input wire [63:0] in1, 
//    input wire [63:0] in2, 
//    input wire sel,
//    output reg [63:0] out
//);
//    always @(in1 or in2 or sel) begin
//        if (sel)
//            out <= in2;
//        else
//            out <= in1;
//    end
//endmodule

