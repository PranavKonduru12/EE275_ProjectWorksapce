`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2024 07:13:13 PM
// Design Name: 
// Module Name: FP_FourStage
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

//Stage 3 with the execution is incorrect due to misalignment
//module fpu_4stage(
//    input wire clk,
//    input wire rst,
//    input wire [31:0] opA,
//    input wire [31:0] opB,
//    input wire opSelect, // 0 for FADD, 1 for FSUB
//    output reg [31:0] result,
//    output reg valid
//);

//    // Pipeline registers
//    reg [31:0] stage1_opA, stage1_opB;
//    reg stage1_opSelect;

//    reg [31:0] stage2_opA, stage2_opB;
//    reg stage2_opSelect;

//    reg [31:0] stage3_result;
//    reg stage3_valid;
    

//    // Stage 1: Fetch and Decode
//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            stage1_opA <= 32'b0;
//            stage1_opB <= 32'b0;
//            stage1_opSelect <= 1'b0;
//        end else begin
//            stage1_opA <= opA;
//            stage1_opB <= opB;
//            stage1_opSelect <= opSelect;
//        end
//    end

//    // Stage 2: Alignment (For simplicity, we assume alignment is not required)
//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            stage2_opA <= 32'b0;
//            stage2_opB <= 32'b0;
//            stage2_opSelect <= 1'b0;
//        end else begin
//            stage2_opA <= stage1_opA;
//            stage2_opB <= stage1_opB;
//            stage2_opSelect <= stage1_opSelect;
//        end
//    end

//    // Stage 3: Execution (Perform addition or subtraction)
//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            stage3_result <= 32'b0;
//            stage3_valid <= 1'b0;
//        end else begin
//            if (stage2_opSelect == 1'b0) begin
//                stage3_result <= stage2_opA + stage2_opB; // FADD
//            end else begin
//                stage3_result <= stage2_opA - stage2_opB; // FSUB
//            end
//            stage3_valid <= 1'b1;
//        end
//    end

//    // Stage 4: Normalization and Write-Back
//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            result <= 32'b0;
//            valid <= 1'b0;
//        end else begin
//            result <= stage3_result; // Normalization (if needed) would go here
//            valid <= stage3_valid;
//        end
//    end

//endmodule

//Included registers for mantissa, exponent, and sign bit but does not work correctly
//module fpu_4stage(
//    input wire clk,
//    input wire rst,
//    input wire [31:0] opA,
//    input wire [31:0] opB,
//    input wire opSelect, // 0 for FADD, 1 for FSUB
//    output reg [31:0] result,
//    output reg valid
//);

//    // Pipeline registers
//    reg [31:0] stage1_opA, stage1_opB;
//    reg stage1_opSelect;

//    reg [31:0] stage2_opA, stage2_opB;
//    reg stage2_opSelect;

//    reg [31:0] stage3_result;
//    reg stage3_valid;
    
//    // Debugging signals
//    reg [31:0] debug_stage1_opA, debug_stage1_opB;
//    reg [31:0] debug_stage2_opA, debug_stage2_opB;
//    reg [31:0] debug_stage3_result;
//    reg [31:0] debug_stage4_result;

//    // Stage 1: Fetch and Decode
//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            stage1_opA <= 32'b0;
//            stage1_opB <= 32'b0;
//            stage1_opSelect <= 1'b0;
//        end else begin
//            stage1_opA <= opA;
//            stage1_opB <= opB;
//            stage1_opSelect <= opSelect;
//        end

//        // Debugging information for Stage 1
//        debug_stage1_opA <= stage1_opA;
//        debug_stage1_opB <= stage1_opB;
//        $display("[Stage 1] opA: %h, opB: %h, opSelect: %b", stage1_opA, stage1_opB, stage1_opSelect);
//    end

//    // Stage 2: Alignment (For simplicity, we assume alignment is not required)
//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            stage2_opA <= 32'b0;
//            stage2_opB <= 32'b0;
//            stage2_opSelect <= 1'b0;
//        end else begin
//            stage2_opA <= stage1_opA;
//            stage2_opB <= stage1_opB;
//            stage2_opSelect <= stage1_opSelect;
//        end

//        // Debugging information for Stage 2
//        debug_stage2_opA <= stage2_opA;
//        debug_stage2_opB <= stage2_opB;
//        $display("[Stage 2] opA: %h, opB: %h, opSelect: %b", stage2_opA, stage2_opB, stage2_opSelect);
//    end

//    // Stage 3: Execution (Perform addition or subtraction)
//    // Declare the variables outside the always block
//    reg signA, signB;                   // Change to 1-bit registers
//    reg [7:0] exponentA, exponentB;     // 8-bit registers for the exponent
//    reg [23:0] mantissaA, mantissaB;    // 24-bit registers for the mantissa
    
//    // Stage 3: Execution (Perform addition or subtraction)
//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            stage3_result <= 32'b0;
//            stage3_valid <= 1'b0;
//        end else begin
//            // Extract components of floating-point numbers
//            signA = stage2_opA[31];
//            signB = stage2_opB[31];
//            exponentA = stage2_opA[30:23];
//            exponentB = stage2_opB[30:23];
//            mantissaA = {1'b1, stage2_opA[22:0]}; // Implicit leading 1 for normalized numbers
//            mantissaB = {1'b1, stage2_opB[22:0]}; // Implicit leading 1 for normalized numbers
    
//            $display("[Stage 3] Before Execution - signA: %b, exponentA: %h, mantissaA: %h", signA, exponentA, mantissaA);
//            $display("[Stage 3] Before Execution - signB: %b, exponentB: %h, mantissaB: %h", signB, exponentB, mantissaB);
    
//            if (stage2_opSelect == 1'b0) begin
//                stage3_result <= stage2_opA + stage2_opB; // FADD
//            end else begin
//                stage3_result <= stage2_opA - stage2_opB; // FSUB
//            end
//            stage3_valid <= 1'b1;
    
//            $display("[Stage 3] Result After Execution: %h", stage3_result);
//        end
    
//        // Debugging information for Stage 3
//        debug_stage3_result <= stage3_result;
//        $display("[Stage 3] Result: %h, Valid: %b", stage3_result, stage3_valid);
//    end
    
//    // Stage 4: Normalization and Write-Back
//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            result <= 32'b0;
//            valid <= 1'b0;
//        end else begin
//            result <= stage3_result; // Normalization (if needed) would go here
//            valid <= stage3_valid;
//        end

//        // Debugging information for Stage 4
//        debug_stage4_result <= result;
//        $display("[Stage 4] Final Result: %h, Valid: %b", result, valid);
//    end

//endmodule

//Submitted December 3, 2024
//module fpu_4stage(
//    input wire clk,
//    input wire rst,
//    input wire [31:0] opA,
//    input wire [31:0] opB,
//    input wire opSelect, // 0 for FADD, 1 for FSUB
//    output reg [31:0] result,
//    output reg valid
//);

//    // Pipeline registers
//    reg [31:0] stage1_opA, stage1_opB;
//    reg stage1_opSelect;

//    reg [31:0] stage2_opA, stage2_opB;
//    reg stage2_opSelect;

//    reg [31:0] stage3_result;
//    reg stage3_valid;

//    // Debugging signals
//    reg [31:0] debug_stage1_opA, debug_stage1_opB;
//    reg [31:0] debug_stage2_opA, debug_stage2_opB;
//    reg [31:0] debug_stage3_result;
//    reg [31:0] debug_stage4_result;

//    // Stage 1: Fetch and Decode
//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            stage1_opA <= 32'b0;
//            stage1_opB <= 32'b0;
//            stage1_opSelect <= 1'b0;
//        end else begin
//            stage1_opA <= opA;
//            stage1_opB <= opB;
//            stage1_opSelect <= opSelect;
//        end

//        // Debugging information for Stage 1
//        debug_stage1_opA <= stage1_opA;
//        debug_stage1_opB <= stage1_opB;
//        $display("[Stage 1] opA: %h, opB: %h, opSelect: %b", stage1_opA, stage1_opB, stage1_opSelect);
//    end

//    // Stage 2: Alignment (For simplicity, we assume alignment is not required)
//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            stage2_opA <= 32'b0;
//            stage2_opB <= 32'b0;
//            stage2_opSelect <= 1'b0;
//        end else begin
//            stage2_opA <= stage1_opA;
//            stage2_opB <= stage1_opB;
//            stage2_opSelect <= stage1_opSelect;
//        end

//        // Debugging information for Stage 2
//        debug_stage2_opA <= stage2_opA;
//        debug_stage2_opB <= stage2_opB;
//        $display("[Stage 2] opA: %h, opB: %h, opSelect: %b", stage2_opA, stage2_opB, stage2_opSelect);
//    end

//    // Stage 3: Execution (Perform addition or subtraction)
//            reg signA, signB, signResult;
//            reg [7:0] exponentA, exponentB, exponentResult;
//            reg [23:0] mantissaA, mantissaB, mantissaResult;
//            reg [7:0] exponentDiff;
//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            stage3_result <= 32'b0;
//            stage3_valid <= 1'b0;
//        end else begin
//            // Extract components of floating-point numbers
//            signA = stage2_opA[31];
//            signB = stage2_opB[31];
//            exponentA = stage2_opA[30:23];
//            exponentB = stage2_opB[30:23];
//            mantissaA = {1'b1, stage2_opA[22:0]}; // Implicit leading 1
//            mantissaB = {1'b1, stage2_opB[22:0]}; // Implicit leading 1

//            // Align exponents
//            if (exponentA > exponentB) begin
//                exponentDiff = exponentA - exponentB;
//                mantissaB = mantissaB >> exponentDiff;
//                exponentResult = exponentA;
//            end else begin
//                exponentDiff = exponentB - exponentA;
//                mantissaA = mantissaA >> exponentDiff;
//                exponentResult = exponentB;
//            end

//            // Perform addition or subtraction on mantissas
//            if (stage2_opSelect == 1'b0) begin
//                // FADD
//                if (signA == signB) begin
//                    mantissaResult = mantissaA + mantissaB;
//                    signResult = signA;
//                end else begin
//                    if (mantissaA > mantissaB) begin
//                        mantissaResult = mantissaA - mantissaB;
//                        signResult = signA;
//                    end else begin
//                        mantissaResult = mantissaB - mantissaA;
//                        signResult = signB;
//                    end
//                end
//            end else begin
//                // FSUB
//                if (signA != signB) begin
//                    mantissaResult = mantissaA + mantissaB;
//                    signResult = signA;
//                end else begin
//                    if (mantissaA > mantissaB) begin
//                        mantissaResult = mantissaA - mantissaB;
//                        signResult = signA;
//                    end else begin
//                        mantissaResult = mantissaB - mantissaA;
//                        signResult = ~signA;
//                    end
//                end
//            end

//            // Normalize result
//            if (mantissaResult[23] == 1'b0) begin
//                mantissaResult = mantissaResult << 1;
//                exponentResult = exponentResult - 1;
//            end

//            // Assemble the result
//            stage3_result = {signResult, exponentResult, mantissaResult[22:0]};
//            stage3_valid <= 1'b1;

//            // Debugging information for Stage 3
//            $display("[Stage 3] Before Execution - signA: %b, exponentA: %h, mantissaA: %h", signA, exponentA, mantissaA);
//            $display("[Stage 3] Before Execution - signB: %b, exponentB: %h, mantissaB: %h", signB, exponentB, mantissaB);
//            $display("[Stage 3] Result After Execution: %h", stage3_result);
//        end

//        debug_stage3_result <= stage3_result;
//        $display("[Stage 3] Result: %h, Valid: %b", stage3_result, stage3_valid);
//    end

//    // Stage 4: Normalization and Write-Back
//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            result <= 32'b0;
//            valid <= 1'b0;
//        end else begin
//            result <= stage3_result; // Normalization (if needed) would go here
//            valid <= stage3_valid;
//        end

//        // Debugging information for Stage 4
//        debug_stage4_result <= result;
//        $display("[Stage 4] Final Result: %h, Valid: %b", result, valid);
//    end

//endmodule

module fpu_4stage(
    input wire clk,
    input wire rst,
    input wire [31:0] opA,
    input wire [31:0] opB,
    input wire opSelect, // 0 for FADD, 1 for FSUB
    output reg [31:0] result,
    output reg valid
);

    // Pipeline registers
    reg [31:0] stage1_opA, stage1_opB;
    reg stage1_opSelect;

    reg [31:0] stage2_opA, stage2_opB;
    reg stage2_opSelect;

    reg [31:0] stage3_result;
    reg stage3_valid;

    // Debugging signals
    reg [31:0] debug_stage1_opA, debug_stage1_opB;
    reg [31:0] debug_stage2_opA, debug_stage2_opB;
    reg [31:0] debug_stage3_result;
    reg [31:0] debug_stage4_result;

    // Stage 1: Fetch and Decode
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            stage1_opA <= 32'b0;
            stage1_opB <= 32'b0;
            stage1_opSelect <= 1'b0;
        end else begin
            stage1_opA <= opA;
            stage1_opB <= opB;
            stage1_opSelect <= opSelect;
        end

        // Debugging information for Stage 1
        debug_stage1_opA <= stage1_opA;
        debug_stage1_opB <= stage1_opB;
        $display("[Stage 1] opA: %h, opB: %h, opSelect: %b", stage1_opA, stage1_opB, stage1_opSelect);
    end

    // Stage 2: Alignment (For simplicity, we assume alignment is not required)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            stage2_opA <= 32'b0;
            stage2_opB <= 32'b0;
            stage2_opSelect <= 1'b0;
        end else begin
            stage2_opA <= stage1_opA;
            stage2_opB <= stage1_opB;
            stage2_opSelect <= stage1_opSelect;
        end

        // Debugging information for Stage 2
        debug_stage2_opA <= stage2_opA;
        debug_stage2_opB <= stage2_opB;
        $display("[Stage 2] opA: %h, opB: %h, opSelect: %b", stage2_opA, stage2_opB, stage2_opSelect);
    end

    // Stage 3: Execution (Perform addition or subtraction)
            reg signA, signB, signResult;
            reg [7:0] exponentA, exponentB, exponentResult;
            reg [23:0] mantissaA, mantissaB, mantissaResult;
            reg [7:0] exponentDiff;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            stage3_result <= 32'b0;
            stage3_valid <= 1'b0;
        end else begin
            // Extract components of floating-point numbers
            signA = stage2_opA[31];
            signB = stage2_opB[31];
            exponentA = stage2_opA[30:23];
            exponentB = stage2_opB[30:23];
            mantissaA = {1'b1, stage2_opA[22:0]}; // Implicit leading 1
            mantissaB = {1'b1, stage2_opB[22:0]}; // Implicit leading 1

            // Align exponents
            if (exponentA > exponentB) begin
                exponentDiff = exponentA - exponentB;
                mantissaB = mantissaB >> exponentDiff;
                exponentResult = exponentA;
            end else begin
                exponentDiff = exponentB - exponentA;
                mantissaA = mantissaA >> exponentDiff;
                exponentResult = exponentB;
            end

            // Perform addition or subtraction on mantissas
            if (stage2_opSelect == 1'b0) begin
                // FADD
//                if (signA == signB) begin
//                    mantissaResult = mantissaA + mantissaB;
//                    signResult = signA;
//                end else begin
//                    if (mantissaA > mantissaB) begin
//                        mantissaResult = mantissaA - mantissaB;
//                        signResult = signA;
//                    end else begin
//                        mantissaResult = mantissaB - mantissaA;
//                        signResult = signB;
//                    end
//                end
//            end else begin
//                // FSUB
//                if (signA != signB) begin
//                    mantissaResult = mantissaA + mantissaB;
//                    signResult = signA;
//                end else begin
//                    if (mantissaA > mantissaB) begin
//                        mantissaResult = mantissaA - mantissaB;
//                        signResult = signA;
//                    end else begin
//                        mantissaResult = mantissaB - mantissaA;
//                        signResult = ~signA;
//                    end
//                end
              if (signA == signB) begin
                // Same sign: Perform addition
                //sumMant = alignedMantA + alignedMantB;
                mantissaResult = mantissaA + mantissaB;
                signResult = signA;
             end else begin
                // Different signs: Perform subtraction
                if (mantissaA >= mantissaB) begin
                    //sumMant = alignedMantA - alignedMantB;
                    mantissaResult = mantissaA - mantissaB;
                    signResult = signA;
                end else begin
                    //sumMant = alignedMantB - alignedMantA;
                    mantissaResult = mantissaB - mantissaA;
                    signResult = signB;
                end
            end
            end

            // Normalize result
//            if (mantissaResult[23] == 1'b0) begin
//                mantissaResult = mantissaResult << 1;
//                exponentResult = exponentResult - 1;
//            end
            if (mantissaResult[24] == 1) begin
                // Leading bit is 1: Right-shift mantissa
                    mantissaResult = mantissaResult >> 1;
                    exponentResult = exponentResult + 1;
            end else begin
                // Normalize mantissa by left-shifting
                while (mantissaResult[23] == 0 && exponentResult > 0) begin
                    mantissaResult = mantissaResult << 1;
                    exponentResult = exponentResult - 1;
                end
            end

            // Assemble the result
            stage3_result = {signResult, exponentResult, mantissaResult[22:0]};
            stage3_valid <= 1'b1;

            // Debugging information for Stage 3
            $display("[Stage 3] Before Execution - signA: %b, exponentA: %h, mantissaA: %h", signA, exponentA, mantissaA);
            $display("[Stage 3] Before Execution - signB: %b, exponentB: %h, mantissaB: %h", signB, exponentB, mantissaB);
            $display("[Stage 3] Result After Execution: %h", stage3_result);
        end

        debug_stage3_result <= stage3_result;
        $display("[Stage 3] Result: %h, Valid: %b", stage3_result, stage3_valid);
    end

    // Stage 4: Normalization and Write-Back
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            result <= 32'b0;
            valid <= 1'b0;
        end else begin
            result <= stage3_result; // Normalization (if needed) would go here
            valid <= stage3_valid;
        end

        // Debugging information for Stage 4
        debug_stage4_result <= result;
        $display("[Stage 4] Final Result: %h, Valid: %b", result, valid);
    end

endmodule
