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

module fpu_4stage_with_cla(
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

    // Intermediate signals
    reg signA, signB, signResult;
    reg [7:0] exponentA, exponentB, exponentResult;
    reg [23:0] mantissaA, mantissaB, mantissaResult;
    reg [7:0] exponentDiff;

    // CLA signals
    wire [23:0] cla_sum;
    wire carry_out;

    // Carry Lookahead Adder (24-bit)
    cla_24bit cla (
        .a(mantissaA),
        .b(mantissaB),
        .cin(1'b0), // No initial carry for addition
        .sum(cla_sum),
        .cout(carry_out)
    );

    // Reset and pipeline stages
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Stage 1
            stage1_opA <= 32'b0;
            stage1_opB <= 32'b0;
            stage1_opSelect <= 1'b0;

            // Stage 2
            stage2_opA <= 32'b0;
            stage2_opB <= 32'b0;
            stage2_opSelect <= 1'b0;

            // Stage 3
            stage3_result <= 32'b0;
            stage3_valid <= 1'b0;

            // Stage 4
            result <= 32'b0;
            valid <= 1'b0;
        end else begin
            // Stage 1: Fetch and Decode
            stage1_opA <= opA;
            stage1_opB <= opB;
            stage1_opSelect <= opSelect;

            // Stage 2: Alignment
            stage2_opA <= stage1_opA;
            stage2_opB <= stage1_opB;
            stage2_opSelect <= stage1_opSelect;

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

            // Stage 3: Execute with CLA
            if (stage2_opSelect == 1'b0) begin
                // FADD
                if (signA == signB) begin
                    mantissaResult = cla_sum;
                    signResult = signA;
                end else begin
                    if (mantissaA > mantissaB) begin
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
                    mantissaResult = cla_sum;
                    signResult = signA;
                end else begin
                    if (mantissaA > mantissaB) begin
                        mantissaResult = mantissaA - mantissaB;
                        signResult = signA;
                    end else begin
                        mantissaResult = mantissaB - mantissaA;
                        signResult = ~signA;
                    end
                end
            end

            // Normalize result
            if (mantissaResult[23] == 1'b0) begin
                mantissaResult = mantissaResult << 1;
                exponentResult = exponentResult - 1;
            end

            // Assemble the result
            stage3_result = {signResult, exponentResult, mantissaResult[22:0]};
            stage3_valid <= 1'b1;

            // Stage 4: Write-back
            result <= stage3_result;
            valid <= stage3_valid;
        end
    end
endmodule

// Carry Lookahead Adder (24-bit)
module cla_24bit(
    input [23:0] a,
    input [23:0] b,
    input cin,
    output [23:0] sum,
    output cout
);
    wire [23:0] p, g, c;

    // Generate and Propagate signals
    assign p = a ^ b; // Propagate
    assign g = a & b; // Generate

    // Carry signals
    assign c[0] = cin;
    genvar i;
    generate
        for (i = 1; i < 24; i = i + 1) begin
            assign c[i] = g[i-1] | (p[i-1] & c[i-1]);
        end
    endgenerate
    assign cout = g[23] | (p[23] & c[23]);

    // Sum computation
    assign sum = p ^ c;
endmodule

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

//    // Carry Look-Ahead Adder for Mantissa Addition/Subtraction
//    wire [23:0] cla_sum;
//    wire cla_carry_out;

//    carry_lookahead_adder_24bit cla (
//        .A(mantissaA),
//        .B(mantissaB),
//        .carry_in(stage2_opSelect ? 1'b1 : 1'b0), // Subtract if opSelect is 1
//        .sum(cla_sum),
//        .carry_out(cla_carry_out)
//    );

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

//            // Stage 2: Alignment (For simplicity, we assume alignment is not required)
//            stage2_opA <= stage1_opA;
//            stage2_opB <= stage1_opB;
//            stage2_opSelect <= stage1_opSelect;

//            // Stage 3: Execution (Perform addition or subtraction)
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

//            // Perform addition or subtraction using the CLA
//            mantissaResult = cla_sum;
//            signResult = (stage2_opSelect == 1'b1) ? signA ^ signB : signA;

//            // Normalize result
//            if (mantissaResult[23] == 1'b0) begin
//                mantissaResult = mantissaResult << 1;
//                exponentResult = exponentResult - 1;
//            end

//            // Assemble the result
//            stage3_result = {signResult, exponentResult, mantissaResult[22:0]};
//            stage3_valid <= 1'b1;

//            // Stage 4: Normalization and Write-Back
//            result <= stage3_result;
//            valid <= stage3_valid;
//        end
//    end

//endmodule

//module carry_lookahead_adder_24bit(
//    input [23:0] A,
//    input [23:0] B,
//    input carry_in,
//    output [23:0] sum,
//    output carry_out
//);
//    wire [23:0] G, P, C;

//    assign G = A & B; // Generate
//    assign P = A ^ B; // Propagate

//    assign C[0] = carry_in;
//    generate
//        genvar i;
//        for (i = 1; i < 24; i = i + 1) begin : generate_carry
//            assign C[i] = G[i-1] | (P[i-1] & C[i-1]);
//        end
//    endgenerate

//    assign sum = P ^ C;
//    assign carry_out = G[23] | (P[23] & C[23]);

//endmodule
