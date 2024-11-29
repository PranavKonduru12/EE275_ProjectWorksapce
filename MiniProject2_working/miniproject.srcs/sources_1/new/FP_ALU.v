`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2024 01:44:44 PM
// Design Name: 
// Module Name: FP_ALU
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


module FP_ALU (
    input [31:0] a, b,         // 32-bit inputs a and b
    input [3:0] operation,     // 4-bit opcode for selecting operation
    input cin,                 // Carry in for add/sub
    output reg [31:0] result,      // 32-bit result
    output overflow, underflow, // Overflow and underflow flags
    output carry_out           // Carry out for add/sub
);
    wire [31:0] sum, diff;
    //wire [31:0] and_res, or_res, xor_res, not_res;
    wire [31:0] cmp_res;
    wire cout_add, cout_sub;      
    wire diff_sign;               
    
    // Add (using full adder structure)
    fulladd32 add32(.sum(sum), .cout(cout_add), .a(a), .b(b), .cin(cin));

    // Subtract (using full adder structure with 2's complement)
    fulladd32 sub32(.sum(diff), .cout(cout_sub), .a(a), .b(~b), .cin(1'b1));  // For subtract, invert b and add 1

    // Multiply (using iterative addition or similar method)
    //multiplier32 mult32(.product(mult), .a(a), .b(b));


    // Comparators
    // Equal
   assign equal = ~|(a ^ b); // XOR each bit and then NOR the result
   // Less than
   assign diff_sign = diff[31];  // The sign bit of the difference
   assign less_than = diff_sign; // If the result is negative, a < b
   // Less than or equal
   assign less_than_equal = less_than | equal;

    // Overflow/Underflow detection
    assign overflow = (a[31] == b[31]) && (sum[31] != a[31]);  // Detect overflow in addition
    assign underflow = (a[31] != b[31]) && (diff[31] != a[31]); // Detect underflow in subtraction

    // Select result based on operation code
    always @(*) begin
        case (operation)
            4'b0000: result = sum;              // Add
            4'b0001: result = diff;             // Subtract
            default: result = 32'b0;
        endcase
    end

    assign carry_out = cout_add;

endmodule
