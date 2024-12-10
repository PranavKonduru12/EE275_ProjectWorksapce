`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 03:39:24 PM
// Design Name: 
// Module Name: FPU
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
module FPU(
    input wire [31:0] opA,          // Operand A (32-bit IEEE 754)
    input wire [31:0] opB,          // Operand B (32-bit IEEE 754)
    input wire FADD_FSUB,           // Control signal (1: FADD, 0: FSUB)
    output reg [31:0] result,       // Result (32-bit IEEE 754)
    output reg exception            // Exception flag (e.g., overflow/underflow)
);

    // Extract fields of IEEE 754 operands
    wire signA, signB;
    wire [7:0] expA, expB;
    wire [23:0] mantA, mantB;
    reg [24:0] alignedMantA, alignedMantB;
    reg [7:0] expDiff;
    reg [24:0] sumMant;
    reg [7:0] finalExp;
    reg signResult;

    assign signA = opA[31];
    assign signB = opB[31] ^ FADD_FSUB; // XOR with FADD_FSUB for subtraction
    assign expA = opA[30:23];
    assign expB = opB[30:23];
    assign mantA = {1'b1, opA[22:0]}; // Add implicit leading 1
    assign mantB = {1'b1, opB[22:0]}; // Add implicit leading 1

    always @(*) begin
        // Initialize outputs
        result = 0;
        exception = 0;

        // Step 1: Align exponents
        if (expA > expB) begin
            expDiff = expA - expB;
            alignedMantA = mantA;
            alignedMantB = mantB >> expDiff; // Right-shift mantissa B
            finalExp = expA;
        end else begin
            expDiff = expB - expA;
            alignedMantA = mantA >> expDiff; // Right-shift mantissa A
            alignedMantB = mantB;
            finalExp = expB;
        end

        // Step 2: Perform addition or subtraction
        if (signA == signB) begin
            // Same sign: Perform addition
            sumMant = alignedMantA + alignedMantB;

            // Handle carry for addition
            if (sumMant[24] == 1) begin
                sumMant = sumMant >> 1;
                finalExp = finalExp + 1;
            end
            signResult = signA;
        end else begin
            // Different signs: Perform subtraction
            if (alignedMantA >= alignedMantB) begin
                sumMant = alignedMantA - alignedMantB;
                signResult = signA;
            end else begin
                sumMant = alignedMantB - alignedMantA;
                signResult = signB;
            end
        end

        // Step 3: Normalize the mantissa
        while (sumMant[23] == 0 && finalExp > 0) begin
            sumMant = sumMant << 1;
            finalExp = finalExp - 1;
        end

        // Debugging: Log values
        $display("DEBUG: SumMant=%h, FinalExp=%d", sumMant, finalExp);

        // Step 4: Pack result
        if (finalExp >= 8'b11111111) begin
            exception = 1;
            result = {signResult, 8'b11111111, 23'b0}; // Infinity
        end else if (finalExp == 0) begin
            exception = 1;
            result = {signResult, 31'b0}; // Zero
        end else begin
            result = {signResult, finalExp, sumMant[22:0]};
        end
    end
endmodule

//module FPU(
//    input wire [31:0] opA,          // Operand A (32-bit IEEE 754)
//    input wire [31:0] opB,          // Operand B (32-bit IEEE 754)
//    input wire FADD_FSUB,           // Control signal (1: FADD, 0: FSUB)
//    output reg [31:0] result,       // Result (32-bit IEEE 754)
//    output reg exception            // Exception flag (e.g., overflow/underflow)
//);

//    // Extract fields of IEEE 754 operands
//    wire signA, signB;
//    wire [7:0] expA, expB;
//    wire [23:0] mantA, mantB;
//    reg [24:0] alignedMantA, alignedMantB;
//    reg [7:0] expDiff;
//    reg [24:0] sumMant;
//    reg [7:0] finalExp;
//    reg signResult;

//    assign signA = opA[31];
//    assign signB = opB[31] ^ FADD_FSUB; // XOR with FADD_FSUB for subtraction
//    assign expA = opA[30:23];
//    assign expB = opB[30:23];
//    assign mantA = {1'b1, opA[22:0]}; // Add implicit leading 1
//    assign mantB = {1'b1, opB[22:0]}; // Add implicit leading 1

//    always @(*) begin
//        // Initialize outputs
//        result = 0;
//        exception = 0;

//        // Step 1: Align exponents
//        if (expA > expB) begin
//            expDiff = expA - expB;
//            alignedMantA = mantA;
//            alignedMantB = mantB >> expDiff; // Right-shift mantissa B
//            finalExp = expA;
//        end else begin
//            expDiff = expB - expA;
//            alignedMantA = mantA >> expDiff; // Right-shift mantissa A
//            alignedMantB = mantB;
//            finalExp = expB;
//        end

//        // Step 2: Perform addition or subtraction
//        if (signA == signB) begin
//            sumMant = alignedMantA + alignedMantB;
//            signResult = signA;
//        end else begin
//            if (alignedMantA >= alignedMantB) begin
//                sumMant = alignedMantA - alignedMantB;
//                signResult = signA;
//            end else begin
//                sumMant = alignedMantB - alignedMantA;
//                signResult = signB;
//            end
//        end

//        // Handle carry for addition
//        if (sumMant[24] == 1) begin
//            sumMant = sumMant >> 1;
//            finalExp = finalExp + 1;
//        end

//        // Step 3: Normalize the mantissa
//        while (sumMant[23] == 0 && finalExp > 0) begin
//            sumMant = sumMant << 1;
//            finalExp = finalExp - 1;
//        end

//        // Step 4: Pack result
//        if (finalExp >= 8'b11111111) begin
//            exception = 1;
//            result = {signResult, 8'b11111111, 23'b0}; // Infinity
//        end else if (finalExp == 0) begin
//            exception = 1;
//            result = {signResult, 31'b0}; // Zero
//        end else begin
//            result = {signResult, finalExp, sumMant[22:0]};
//        end
//    end
//endmodule