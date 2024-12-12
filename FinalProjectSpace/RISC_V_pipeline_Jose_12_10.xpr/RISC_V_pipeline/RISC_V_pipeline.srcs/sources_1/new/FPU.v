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
///update for NaN
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
//    assign mantA = (expA == 0) ? {1'b0, opA[22:0]} : {1'b1, opA[22:0]}; // Denormal handling
//    assign mantB = (expB == 0) ? {1'b0, opB[22:0]} : {1'b1, opB[22:0]}; // Denormal handling

//    always @(*) begin
//        // Initialize outputs
//        result = 0;
//        exception = 0;

//        // Handle Special Cases
//        if (expA == 8'b11111111) begin
//            // Operand A is NaN or Infinity
//            if (mantA != 0) begin
//                result = {1'b1, 8'b11111111, 23'b1}; // NaN
//                exception = 1;
//                $display("DEBUG: Operand A is NaN");
//                return;
//            end else begin
//                result = {signA, 8'b11111111, 23'b0}; // Infinity
//                $display("DEBUG: Operand A is Infinity");
//                return;
//            end
//        end

//        if (expB == 8'b11111111) begin
//            // Operand B is NaN or Infinity
//            if (mantB != 0) begin
//                result = {1'b1, 8'b11111111, 23'b1}; // NaN
//                exception = 1;
//                $display("DEBUG: Operand B is NaN");
//                return;
//            end else begin
//                result = {signB, 8'b11111111, 23'b0}; // Infinity
//                $display("DEBUG: Operand B is Infinity");
//                return;
//            end
//        end

//        if ((expA == 0 && mantA == 0) && (expB == 0 && mantB == 0)) begin
//            // Both operands are zero
//            result = {signA ^ signB, 31'b0}; // Handle signed zero
//            $display("DEBUG: Both operands are zero");
//            return;
//        end

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
//            // Same sign: Perform addition
//            sumMant = alignedMantA + alignedMantB;

//            // Handle carry for addition
//            if (sumMant[24] == 1) begin
//                sumMant = sumMant >> 1;
//                finalExp = finalExp + 1;
//            end
//            signResult = signA;
//        end else begin
//            // Different signs: Perform subtraction
//            if (alignedMantA >= alignedMantB) begin
//                sumMant = alignedMantA - alignedMantB;
//                signResult = signA;
//            end else begin
//                sumMant = alignedMantB - alignedMantA;
//                signResult = signB;
//            end
//        end

//        // Step 3: Normalize the mantissa
//        while (sumMant[23] == 0 && finalExp > 0) begin
//            sumMant = sumMant << 1;
//            finalExp = finalExp - 1;
//        end

//        // Step 4: Check for overflow or underflow
//        if (finalExp >= 8'b11111111) begin
//            exception = 1;
//            result = {signResult, 8'b11111111, 23'b0}; // Infinity
//        end else if (finalExp == 0) begin
//            exception = 1;
//            result = {signResult, 31'b0}; // Zero
//        end else begin
//            result = {signResult, finalExp, sumMant[22:0]};
//        end

//        // Debugging: Log values
//        $display("DEBUG: SumMant=%h, FinalExp=%d", sumMant, finalExp);
//    end
//endmodule


//Commented Dec 11, 2024 because exception does not work
//module FPU(
//    input wire [31:0] opA,          // Operand A (32-bit IEEE 754)
//    input wire [31:0] opB,          // Operand B (32-bit IEEE 754)
//    input wire FADD_FSUB,           // Control signal (0: FADD, 1: FSUB)
//    output reg [31:0] result,       // Result (32-bit IEEE 754)
//    output reg [1:0] exception            // Exception flag (e.g., overflow/underflow)
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
//            // Same sign: Perform addition
//            sumMant = alignedMantA + alignedMantB;

//            // Handle carry for addition
//            if (sumMant[24] == 1) begin
//                sumMant = sumMant >> 1;
//                finalExp = finalExp + 1;
//            end
//            signResult = signA;
//        end else begin
//            // Different signs: Perform subtraction
//            if (alignedMantA >= alignedMantB) begin
//                sumMant = alignedMantA - alignedMantB;
//                signResult = signA;
//            end else begin
//                sumMant = alignedMantB - alignedMantA;
//                signResult = signB;
//            end
//        end

//        // Step 3: Normalize the mantissa
//        while (sumMant[23] == 0 && finalExp > 0) begin
//            sumMant = sumMant << 1;
//            finalExp = finalExp - 1;
//        end

//        // Debugging: Log values
//        $display("DEBUG: SumMant=%h, FinalExp=%d", sumMant, finalExp);

//        // Step 4: Pack result
//        if (finalExp >= 8'b11111111) begin
//            exception = 2'b01;
//            result = {signResult, 8'b11111111, 23'b0}; // Infinity
//        end else if (finalExp == 0) begin
//            exception = 2'b10;
//            result = {signResult, 31'b0}; // Zero
//        end else begin
//            result = {signResult, finalExp, sumMant[22:0]};
//        end
//    end
//endmodule

module FPU(
    input wire [31:0] opA,          // Operand A (32-bit IEEE 754)
    input wire [31:0] opB,          // Operand B (32-bit IEEE 754)
    input wire FADD_FSUB,           // Control signal (0: FADD, 1: FSUB)
    output reg [31:0] result,       // Result (32-bit IEEE 754)
    output reg [1:0] exception            // Exception flag (e.g., overflow[1] / underflow[0])
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
    assign mantA = (expA == 0) ? {1'b0, opA[22:0]} : {1'b1, opA[22:0]}; // Denormal handling
    assign mantB = (expB == 0) ? {1'b0, opB[22:0]} : {1'b1, opB[22:0]}; // Denormal handling

    always @(*) begin
        // Initialize outputs
        result = 0;
        exception = 0;

        // Handle Special Cases
//        if (expA == 8'b11111111) begin
//            // Operand A is NaN or Infinity
//            if (mantA != 0) begin
//                result = {1'b1, 8'b11111111, 23'b1}; // NaN
//                exception = 2'b01;
//                $display("DEBUG: Operand A is NaN");
//                //return;
//            end else begin
//                result = {signA, 8'b11111111, 23'b0}; // Infinity
//                $display("DEBUG: Operand A is Infinity");
//                //return;
//            end
//        end

//        if (expB == 8'b11111111) begin
//            // Operand B is NaN or Infinity
//            if (mantB != 0) begin
//                result = {1'b1, 8'b11111111, 23'b1}; // NaN
//                exception = 2'b01;
//                $display("DEBUG: Operand B is NaN");
//                //return;
//            end else begin
//                result = {signB, 8'b11111111, 23'b0}; // Infinity
//                $display("DEBUG: Operand B is Infinity");
//                //return;
//            end
//        end

        if ((expA == 0 && mantA == 0) && (expB == 0 && mantB == 0)) begin
            // Both operands are zero
            result = {signA ^ signB, 31'b0}; // Handle signed zero
            $display("DEBUG: Both operands are zero");
            //return;
        end

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
//        while (sumMant[23] == 0 && finalExp > 0) begin
//            sumMant = sumMant << 1;
//            finalExp = finalExp - 1;
//        end
        if (sumMant[24]) begin      //more efficient
            sumMant = sumMant >> 1;
            finalExp = finalExp + 1;
        end else while (sumMant[23] == 0 && finalExp > 0) begin
            sumMant = sumMant << 1;
            finalExp = finalExp - 1;
        end

        // Step 4: Check for overflow or underflow
        if (finalExp >= 8'b11111111) begin
            exception = 2'b10;   //overflow
            result = {signResult, 8'b11111111, 23'b0}; // Infinity
        end else if (finalExp == 0) begin
            exception = 2'b11;   //underflow
            result = {signResult, 31'b0}; // Zero
        end else begin
            result = {signResult, finalExp, sumMant[22:0]};
        end
        
        // Step 5: Handle special cases (NaN, infinity)
        if ((expA == 8'b11111111 && mantA != 0) || (expB == 8'b11111111 && mantB != 0)) begin
            exception = 2'b01;
            result = 32'h7FC00000; // NaN
        end

        // Debugging: Log values
        $display("DEBUG: SumMant=%h, FinalExp=%d", sumMant, finalExp);
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