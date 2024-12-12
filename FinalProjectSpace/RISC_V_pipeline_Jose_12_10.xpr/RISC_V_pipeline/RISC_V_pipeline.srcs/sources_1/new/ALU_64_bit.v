`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 03:38:02 PM
// Design Name: 
// Module Name: ALU_64_bit
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
module ALU_64_bit(
    input wire [63:0] a, b,        // Operands
    input wire [3:0] ALUOp,        // Control signals
    input wire isFloat,            // Data type selector: 1 = Floating-point, 0 = Integer
    output wire [63:0] Result,     // Output result
    output wire zero,              // Zero flag
    output wire exception          // Exception flag (for FPU only)
);

    wire [63:0] sumOut;            // Sum for integer operations
    wire [31:0] fpuResult;         // Result from FPU (32-bit floating-point)
    wire fpuException;             // Exception flag from FPU

    // Integer addition/subtraction
    assign sumOut = (ALUOp == 4'b0110) ? (a - b) : (a + b);

    // FPU module instance
    FPU fpu (
        .opA(a[31:0]),             // Operand A (lower 32 bits)
        .opB(b[31:0]),             // Operand B (lower 32 bits)
        .FADD_FSUB(ALUOp[0]),      // Control signal: 1 = FADD, 0 = FSUB
        .result(fpuResult),        // FPU result
        .exception(fpuException)   // FPU exception flag
    );

    // Multiplexer to select between ALU and FPU results
    assign Result = isFloat ? {32'b0, fpuResult} : sumOut; // Select FPU for isFloat = 1

    // Exception flag (propagates FPU exception)
    assign exception = isFloat ? fpuException : 1'b0;

    // Zero flag
    assign zero = isFloat ? (fpuResult == 32'b0) : (Result == 64'b0);

endmodule

//module ALU_64_bit(
//    input wire [63:0] a, b,        // Operands
//    input wire [3:0] ALUOp,        // Control signals
//    output wire [63:0] Result,     // Output result
//    output wire zero               // Zero flag
//);

//    wire [63:0] sumOut;            // Sum for integer operations
//    wire [31:0] fpuResult;         // Result from FPU (32-bit floating-point)
//    wire fpuException;             // Exception flag from FPU

//    // Integer addition/subtraction (bypassed for debugging)
//    assign sumOut = (ALUOp == 4'b0110) ? (a - b) : (a + b);

//    // FPU module instance
//    FPU fpu (
//        .opA(a[31:0]),             // Operand A (lower 32 bits)
//        .opB(b[31:0]),             // Operand B (lower 32 bits)
//        .FADD_FSUB(ALUOp[0]),      // Control signal: 1 = FADD, 0 = FSUB
//        .result(fpuResult),        // FPU result
//        .exception(fpuException)   // FPU exception flag
//    );

//    // Multiplexer to select between ALU and FPU results
//    assign Result = (ALUOp[3]) ? {32'b0, fpuResult} : sumOut; // Select FPU for ALUOp[3] = 1

//    // Zero flag
//    assign zero = (Result == 64'b0);

//endmodule

