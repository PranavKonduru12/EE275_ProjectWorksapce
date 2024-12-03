`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2024 09:43:31 PM
// Design Name: 
// Module Name: fpu_4stage
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

//Carry lookahead without overflow, underflow, and NaN Handling
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
//    reg signA, signB, signResult;
//    reg [7:0] exponentA, exponentB, exponentResult;
//    reg [23:0] mantissaA, mantissaB, mantissaResult;
//    reg [7:0] exponentDiff;
//    // Combined Reset Block
//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            // Stage 1
//            stage1_opA <= 32'b0;
//            stage1_opB <= 32'b0;
//            stage1_opSelect <= 1'b0;

//            // Stage 2
//            stage2_opA <= 32'b0;
//            stage2_opB <= 32'b0;
//            stage2_opSelect <= 1'b0;

//            // Stage 3
//            stage3_result <= 32'b0;
//            stage3_valid <= 1'b0;

//            // Stage 4
//            result <= 32'b0;
//            valid <= 1'b0;
//        end else begin
//            // Normal operation for each pipeline stage
            
//            // Stage 1: Fetch and Decode
//            stage1_opA <= opA;
//            stage1_opB <= opB;
//            stage1_opSelect <= opSelect;

//            // Debugging information for Stage 1
//            debug_stage1_opA <= stage1_opA;
//            debug_stage1_opB <= stage1_opB;
//            $display("[Stage 1] opA: %h, opB: %h, opSelect: %b", stage1_opA, stage1_opB, stage1_opSelect);

//            // Stage 2: Alignment (For simplicity, we assume alignment is not required)
//            stage2_opA <= stage1_opA;
//            stage2_opB <= stage1_opB;
//            stage2_opSelect <= stage1_opSelect;

//            // Debugging information for Stage 2
//            debug_stage2_opA <= stage2_opA;
//            debug_stage2_opB <= stage2_opB;
//            $display("[Stage 2] opA: %h, opB: %h, opSelect: %b", stage2_opA, stage2_opB, stage2_opSelect);

//            // Stage 3: Execution (Perform addition or subtraction)
////            reg signA, signB, signResult;
////            reg [7:0] exponentA, exponentB, exponentResult;
////            reg [23:0] mantissaA, mantissaB, mantissaResult;
////            reg [7:0] exponentDiff;

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

//            debug_stage3_result <= stage3_result;
//            $display("[Stage 3] Result: %h, Valid: %b", stage3_result, stage3_valid);

//            // Stage 4: Normalization and Write-Back
//            result <= stage3_result; // Normalization (if needed) would go here
//            valid <= stage3_valid;

//            // Debugging information for Stage 4
//            debug_stage4_result <= result;
//            $display("[Stage 4] Final Result: %h, Valid: %b", result, valid);
//        end
//    end
//endmodule

module fpu_4stage(
    input wire clk,
    input wire rst,
    input wire [31:0] opA,
    input wire [31:0] opB,
    input wire opSelect, // 0 for FADD, 1 for FSUB
    output reg [31:0] result,
    output reg valid,
    output reg overflow_flag, underflow_flag, nan_flag
);

    // Pipeline registers
    reg [31:0] stage1_opA, stage1_opB;
    reg stage1_opSelect;

    reg [31:0] stage2_opA, stage2_opB;
    reg stage2_opSelect;

    reg [31:0] stage3_result;
    reg stage3_valid;

    reg signA, signB, signResult;
    reg [7:0] exponentA, exponentB, exponentResult;
    reg [23:0] mantissaA, mantissaB, mantissaResult;
    reg [7:0] exponentDiff;

    // Flags for special cases
//    reg overflow_flag, underflow_flag, nan_flag;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset pipeline
            stage1_opA <= 32'b0;
            stage1_opB <= 32'b0;
            stage1_opSelect <= 1'b0;

            stage2_opA <= 32'b0;
            stage2_opB <= 32'b0;
            stage2_opSelect <= 1'b0;

            stage3_result <= 32'b0;
            stage3_valid <= 1'b0;

            result <= 32'b0;
            valid <= 1'b0;
            overflow_flag <= 1'b0;
            underflow_flag <= 1'b0;
            nan_flag <= 1'b0;
        end else begin
            // Stage 1: Fetch and Decode
            stage1_opA <= opA;
            stage1_opB <= opB;
            stage1_opSelect <= opSelect;

            // Stage 2: Alignment
            stage2_opA <= stage1_opA;
            stage2_opB <= stage1_opB;
            stage2_opSelect <= stage1_opSelect;

            // Extract FP components
            signA = stage2_opA[31];
            signB = stage2_opB[31] ^ stage2_opSelect; // Flip sign for FSUB
            exponentA = stage2_opA[30:23];
            exponentB = stage2_opB[30:23];
            mantissaA = {1'b1, stage2_opA[22:0]};
            mantissaB = {1'b1, stage2_opB[22:0]};

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

            // Stage 3: Execution
            if (stage2_opSelect == 0) begin
                // FADD
                if (signA == signB) begin
                    mantissaResult = mantissaA + mantissaB;
                    signResult = signA;
                end else begin
                    if (mantissaA >= mantissaB) begin
                        mantissaResult = mantissaA - mantissaB;
                        signResult = signA;
                    end else begin
                        mantissaResult = mantissaB - mantissaA;
                        signResult = signB;
                    end
                end
            end else begin
                // FSUB
                if (signA != signB) begin
                    mantissaResult = mantissaA + mantissaB;
                    signResult = signA;
                end else begin
                    if (mantissaA >= mantissaB) begin
                        mantissaResult = mantissaA - mantissaB;
                        signResult = signA;
                    end else begin
                        mantissaResult = mantissaB - mantissaA;
                        signResult = ~signA;
                    end
                end
            end

            // Normalize result
            if (mantissaResult[23] == 0) begin
                mantissaResult = mantissaResult << 1;
                exponentResult = exponentResult - 1;
            end

            // Check for special conditions
            nan_flag <= (exponentA == 8'd255 && mantissaA != 0) || 
                        (exponentB == 8'd255 && mantissaB != 0);
            overflow_flag <= (exponentResult > 8'd254);
            underflow_flag <= (exponentResult < 8'd1);

            // Stage 4: Write-Back
            if (nan_flag) begin
                result <= 32'h7FC00000; // NaN
            end else if (overflow_flag) begin
                result <= {signResult, 8'd255, 23'b0}; // Infinity
            end else if (underflow_flag) begin
                result <= 32'b0; // Zero
            end else begin
                result <= {signResult, exponentResult, mantissaResult[22:0]};
            end

            valid <= 1'b1;
        end
    end

endmodule



