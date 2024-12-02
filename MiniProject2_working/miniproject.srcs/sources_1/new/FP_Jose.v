`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2024 03:35:13 PM
// Design Name: 
// Module Name: FP_Jose
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

//Issue with FSUB
//module fpu_32bit (
//    input clk,
//    input reset,
//    input [31:0] X [0:31],    // 32-length register set
//    input [31:0] scalar,       // Scalar FP register
//    input [31:0] instruction,  // FADD or FSUB instruction
//    output reg [31:0] result   // Result of operation
//);

//    reg [31:0] operand1, operand2;  // Operands for addition/subtraction
//    reg [31:0] mantissa1, mantissa2;
//    reg [7:0] exponent1, exponent2;
//    reg sign1, sign2;

//    // Define intermediate values
//    reg [31:0] intermediate_result;
//    reg overflow, underflow, is_nan;
    
//    // Define instruction opcodes
//    `define FADD 32'h00000001  // Opcode for FADD
//    `define FSUB 32'h00000002  // Opcode for FSUB
    
//    // Stage 1: Instruction Fetch
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            operand1 <= 0;
//            operand2 <= 0;
//            result <= 0;
//        end else begin
//            // Fetch operands based on instruction (simplified)
//            if (instruction == 32'hFADD) begin
//                operand1 <= X[0];  // Assuming operand1 is in X[0]
//                operand2 <= scalar; // Scalar for addition
//            end else if (instruction == 32'hFSUB) begin
//                operand1 <= X[1];  // Assuming operand2 is in X[1]
//                operand2 <= scalar; // Scalar for subtraction
//            end
//        end
//    end

//    // Stage 2: Operand Fetch
//    always @(posedge clk) begin
//        mantissa1 <= operand1[22:0];  // Extract mantissa (23 bits)
//        mantissa2 <= operand2[22:0];
//        exponent1 <= operand1[30:23]; // Extract exponent (8 bits)
//        exponent2 <= operand2[30:23];
//        sign1 <= operand1[31];        // Extract sign bit
//        sign2 <= operand2[31];
//    end

//    // Stage 3: Execution (FADD/FSUB)
//    always @(posedge clk) begin
//        if (instruction == 32'hFADD) begin
//            // Mantissa addition using a carry-lookahead adder
//            {intermediate_result[22:0], intermediate_result[23]} = mantissa1 + mantissa2;
//            intermediate_result[30:23] = exponent1; // Handle exponent addition/subtraction

//            // Check for NaN, overflow, and underflow
//            if (exponent1 == 8'b11111111 || exponent2 == 8'b11111111) begin
//                is_nan <= 1;
//            end else if (intermediate_result[30:23] == 8'b11111111) begin
//                overflow <= 1;
//            end else if (intermediate_result[30:23] == 0) begin
//                underflow <= 1;
//            end
//        end else if (instruction == 32'hFSUB) begin
//            // Mantissa subtraction using a carry-lookahead adder
//            {intermediate_result[22:0], intermediate_result[23]} = mantissa1 - mantissa2;
//            intermediate_result[30:23] = exponent1; // Handle exponent subtraction

//            // Check for NaN, overflow, and underflow
//            if (exponent1 == 8'b11111111 || exponent2 == 8'b11111111) begin
//                is_nan <= 1;
//            end else if (intermediate_result[30:23] == 8'b11111111) begin
//                overflow <= 1;
//            end else if (intermediate_result[30:23] == 0) begin
//                underflow <= 1;
//            end
//        end
//    end

//    // Stage 4: Write Back (Result)
//    always @(posedge clk) begin
//        if (is_nan) begin
//            result <= 32'b01111111111100000000000000000000;  // NaN (example encoding)
//        end else if (overflow) begin
//            result <= 32'b01111111100000000000000000000000;  // +Inf (example encoding)
//        end else if (underflow) begin
//            result <= 32'b00000000000000000000000000000000;  // 0 (example encoding)
//        end else begin
//            result <= intermediate_result;  // Normal result
//        end
//    end

//endmodule

//Used define `FADD and `FSUB to fix 
//But input X array gives a warning
//module fpu_32bit (
//    input clk,
//    input reset,
//   input [31:0] X [0:31],    // 32-length register set
//    input [31:0] scalar,       // Scalar FP register
//    input [31:0] instruction,  // FADD or FSUB instruction
//    output reg [31:0] result   // Result of operation
//);

//    //reg [31:0] X [0:31];
    
//    reg [31:0] operand1, operand2;  // Operands for addition/subtraction
//    reg [31:0] mantissa1, mantissa2;
//    reg [7:0] exponent1, exponent2;
//    reg sign1, sign2;

//    // Define intermediate values
//    reg [31:0] intermediate_result;
//    reg overflow, underflow, is_nan;
    
//    // Define instruction opcodes
//    `define FADD 32'h00000001  // Opcode for FADD
//    `define FSUB 32'h00000002  // Opcode for FSUB
    
//    // Stage 1: Instruction Fetch
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            operand1 <= 0;
//            operand2 <= 0;
//            result <= 0;
//        end 
//        else begin
//            // Fetch operands based on instruction (simplified)
//            if (instruction == `FADD) begin
//                operand1 <= X[0];  // Assuming operand1 is in X[0]
//                operand2 <= scalar; // Scalar for addition
//            end 
//            else if (instruction == `FSUB) begin
//                operand1 <= X[1];  // Assuming operand2 is in X[1]
//                operand2 <= scalar; // Scalar for subtraction
//            end
//        end
//    end

//    // Stage 2: Operand Fetch
//    always @(posedge clk) begin
//        mantissa1 <= operand1[22:0];  // Extract mantissa (23 bits)
//        mantissa2 <= operand2[22:0];
//        exponent1 <= operand1[30:23]; // Extract exponent (8 bits)
//        exponent2 <= operand2[30:23];
//        sign1 <= operand1[31];        // Extract sign bit
//        sign2 <= operand2[31];
//    end

//    // Stage 3: Execution (FADD/FSUB)
//    always @(posedge clk) begin
//        if (instruction == `FADD) begin
//            // Mantissa addition using a carry-lookahead adder
//            {intermediate_result[22:0], intermediate_result[23]} = mantissa1 + mantissa2;
//            intermediate_result[30:23] = exponent1; // Handle exponent addition/subtraction

//            // Check for NaN, overflow, and underflow
//            if (exponent1 == 8'b11111111 || exponent2 == 8'b11111111) begin
//                is_nan <= 1;
//            end 
//            else if (intermediate_result[30:23] == 8'b11111111) begin
//                overflow <= 1;
//            end 
//            else if (intermediate_result[30:23] == 0) begin
//                underflow <= 1;
//            end
//        end 
//        else if (instruction == `FSUB) begin
//            // Mantissa subtraction using a carry-lookahead adder
//            {intermediate_result[22:0], intermediate_result[23]} = mantissa1 - mantissa2;
//            intermediate_result[30:23] = exponent1; // Handle exponent subtraction

//            // Check for NaN, overflow, and underflow
//            if (exponent1 == 8'b11111111 || exponent2 == 8'b11111111) begin
//                is_nan <= 1;
//            end else if (intermediate_result[30:23] == 8'b11111111) begin
//                overflow <= 1;
//            end else if (intermediate_result[30:23] == 0) begin
//                underflow <= 1;
//            end
//        end
//    end

//    // Stage 4: Write Back (Result)
//    always @(posedge clk) begin
//        if (is_nan) begin
//            result <= 32'b01111111111100000000000000000000;  // NaN (example encoding)
//        end else if (overflow) begin
//            result <= 32'b01111111100000000000000000000000;  // +Inf (example encoding)
//        end else if (underflow) begin
//            result <= 32'b00000000000000000000000000000000;  // 0 (example encoding)
//        end else begin
//            result <= intermediate_result;  // Normal result
//        end
//    end

//endmodule

//Have not tested yet. Trying to make two FPs as two separate inputs that are fed into register
//module fpu_32bit (
//    input clk,
//    input reset,
//   //input [31:0] X [0:31],    // 32-length register set
//    input [31:0] a,b,
//    input [31:0] scalar,       // Scalar FP register
//    input [31:0] instruction,  // FADD or FSUB instruction
//    output reg [31:0] result   // Result of operation
//);

//    reg [31:0] X [0:31];
    
//    reg [31:0] operand1, operand2;  // Operands for addition/subtraction
//    reg [31:0] mantissa1, mantissa2;
//    reg [7:0] exponent1, exponent2;
//    reg sign1, sign2;

//    // Define intermediate values
//    reg [31:0] intermediate_result;
//    reg overflow, underflow, is_nan;
    
//    // Define instruction opcodes
//    `define FADD 32'h00000001  // Opcode for FADD
//    `define FSUB 32'h00000002  // Opcode for FSUB
    
//    // Stage 1: Instruction Fetch
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            operand1 <= 0;
//            operand2 <= 0;
//            result <= 0;
//        end 
//        else begin
//            // Fetch operands based on instruction (simplified)
//            if (instruction == `FADD) begin
//                X[0] <= a;
//                operand1 <= X[0];  // Assuming operand1 is in X[0]
//                operand2 <= scalar; // Scalar for addition
//            end 
//            else if (instruction == `FSUB) begin
//                X[1] <= b;
//                operand1 <= X[1];  // Assuming operand2 is in X[1]
//                operand2 <= scalar; // Scalar for subtraction
//            end
//        end
//    end

//    // Stage 2: Operand Fetch
//    always @(posedge clk) begin
//        mantissa1 <= operand1[22:0];  // Extract mantissa (23 bits)
//        mantissa2 <= operand2[22:0];
//        exponent1 <= operand1[30:23]; // Extract exponent (8 bits)
//        exponent2 <= operand2[30:23];
//        sign1 <= operand1[31];        // Extract sign bit
//        sign2 <= operand2[31];
//    end

//    // Stage 3: Execution (FADD/FSUB)
//    always @(posedge clk) begin
//        if (instruction == `FADD) begin
//            // Mantissa addition using a carry-lookahead adder
//            {intermediate_result[22:0], intermediate_result[23]} = mantissa1 + mantissa2;
//            intermediate_result[30:23] = exponent1; // Handle exponent addition/subtraction

//            // Check for NaN, overflow, and underflow
//            if (exponent1 == 8'b11111111 || exponent2 == 8'b11111111) begin
//                is_nan <= 1;
//            end 
//            else if (intermediate_result[30:23] == 8'b11111111) begin
//                overflow <= 1;
//            end 
//            else if (intermediate_result[30:23] == 0) begin
//                underflow <= 1;
//            end
//        end 
//        else if (instruction == `FSUB) begin
//            // Mantissa subtraction using a carry-lookahead adder
//            {intermediate_result[22:0], intermediate_result[23]} = mantissa1 - mantissa2;
//            intermediate_result[30:23] = exponent1; // Handle exponent subtraction

//            // Check for NaN, overflow, and underflow
//            if (exponent1 == 8'b11111111 || exponent2 == 8'b11111111) begin
//                is_nan <= 1;
//            end else if (intermediate_result[30:23] == 8'b11111111) begin
//                overflow <= 1;
//            end else if (intermediate_result[30:23] == 0) begin
//                underflow <= 1;
//            end
//        end
//    end

//    // Stage 4: Write Back (Result)
//    always @(posedge clk) begin
//        if (is_nan) begin
//            result <= 32'b01111111111100000000000000000000;  // NaN (example encoding)
//        end else if (overflow) begin
//            result <= 32'b01111111100000000000000000000000;  // +Inf (example encoding)
//        end else if (underflow) begin
//            result <= 32'b00000000000000000000000000000000;  // 0 (example encoding)
//        end else begin
//            result <= intermediate_result;  // Normal result
//        end
//    end

//endmodule

//Code from November 29. Does not use an array
module fp_unit(
    input clk,
    input rst,
    input [31:0] scalar,            // Scalar floating-point input
    input [31:0] vector_in_0,       // Vector of 32 32-bit FP values (split into individual inputs)
    input [31:0] vector_in_1,
    input [31:0] vector_in_2,
    input [31:0] vector_in_3,
    input [31:0] vector_in_4,
    input [31:0] vector_in_5,
    input [31:0] vector_in_6,
    input [31:0] vector_in_7,
    input [31:0] vector_in_8,
    input [31:0] vector_in_9,
    input [31:0] vector_in_10,
    input [31:0] vector_in_11,
    input [31:0] vector_in_12,
    input [31:0] vector_in_13,
    input [31:0] vector_in_14,
    input [31:0] vector_in_15,
    input [31:0] vector_in_16,
    input [31:0] vector_in_17,
    input [31:0] vector_in_18,
    input [31:0] vector_in_19,
    input [31:0] vector_in_20,
    input [31:0] vector_in_21,
    input [31:0] vector_in_22,
    input [31:0] vector_in_23,
    input [31:0] vector_in_24,
    input [31:0] vector_in_25,
    input [31:0] vector_in_26,
    input [31:0] vector_in_27,
    input [31:0] vector_in_28,
    input [31:0] vector_in_29,
    input [31:0] vector_in_30,
    input [31:0] vector_in_31,
    input start,                    // Start signal for vector-scalar addition
    output reg [31:0] vector_out_0, // Vector of 32 32-bit FP output values (split into individual outputs)
    output reg [31:0] vector_out_1,
    output reg [31:0] vector_out_2,
    output reg [31:0] vector_out_3,
    output reg [31:0] vector_out_4,
    output reg [31:0] vector_out_5,
    output reg [31:0] vector_out_6,
    output reg [31:0] vector_out_7,
    output reg [31:0] vector_out_8,
    output reg [31:0] vector_out_9,
    output reg [31:0] vector_out_10,
    output reg [31:0] vector_out_11,
    output reg [31:0] vector_out_12,
    output reg [31:0] vector_out_13,
    output reg [31:0] vector_out_14,
    output reg [31:0] vector_out_15,
    output reg [31:0] vector_out_16,
    output reg [31:0] vector_out_17,
    output reg [31:0] vector_out_18,
    output reg [31:0] vector_out_19,
    output reg [31:0] vector_out_20,
    output reg [31:0] vector_out_21,
    output reg [31:0] vector_out_22,
    output reg [31:0] vector_out_23,
    output reg [31:0] vector_out_24,
    output reg [31:0] vector_out_25,
    output reg [31:0] vector_out_26,
    output reg [31:0] vector_out_27,
    output reg [31:0] vector_out_28,
    output reg [31:0] vector_out_29,
    output reg [31:0] vector_out_30,
    output reg [31:0] vector_out_31,
    output reg done                 // Done signal
);

    // Pipeline Registers
    reg [31:0] stage1_reg [0:31];
    reg [31:0] stage2_reg [0:31];
    reg [31:0] stage3_reg [0:31];
    reg [31:0] result [0:31];
    reg [4:0] counter;

    // FSM States
    parameter IDLE = 2'b00, LOAD = 2'b01, EXECUTE = 2'b10, WRITE_BACK = 2'b11;
    reg [1:0] state, next_state;

    // State Machine
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @* begin
        case (state)
            IDLE: begin
                done = 0;
                if (start)
                    next_state = LOAD;
                else
                    next_state = IDLE;
            end

            LOAD: begin
                next_state = EXECUTE;
            end

            EXECUTE: begin
                if (counter < 32)
                    next_state = EXECUTE;
                else
                    next_state = WRITE_BACK;
            end

            WRITE_BACK: begin
                next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

    // Pipeline Stages
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
        end
        else begin
            case (state)
                LOAD: begin
                    stage1_reg[0] <= vector_in_0;
                    stage1_reg[1] <= vector_in_1;
                    stage1_reg[2] <= vector_in_2;
                    stage1_reg[3] <= vector_in_3;
                    stage1_reg[4] <= vector_in_4;
                    stage1_reg[5] <= vector_in_5;
                    stage1_reg[6] <= vector_in_6;
                    stage1_reg[7] <= vector_in_7;
                    stage1_reg[8] <= vector_in_8;
                    stage1_reg[9] <= vector_in_9;
                    stage1_reg[10] <= vector_in_10;
                    stage1_reg[11] <= vector_in_11;
                    stage1_reg[12] <= vector_in_12;
                    stage1_reg[13] <= vector_in_13;
                    stage1_reg[14] <= vector_in_14;
                    stage1_reg[15] <= vector_in_15;
                    stage1_reg[16] <= vector_in_16;
                    stage1_reg[17] <= vector_in_17;
                    stage1_reg[18] <= vector_in_18;
                    stage1_reg[19] <= vector_in_19;
                    stage1_reg[20] <= vector_in_20;
                    stage1_reg[21] <= vector_in_21;
                    stage1_reg[22] <= vector_in_22;
                    stage1_reg[23] <= vector_in_23;
                    stage1_reg[24] <= vector_in_24;
                    stage1_reg[25] <= vector_in_25;
                    stage1_reg[26] <= vector_in_26;
                    stage1_reg[27] <= vector_in_27;
                    stage1_reg[28] <= vector_in_28;
                    stage1_reg[29] <= vector_in_29;
                    stage1_reg[30] <= vector_in_30;
                    stage1_reg[31] <= vector_in_31;
                    counter <= 0;
                end

                EXECUTE: begin
                    if (counter < 32) begin
                        // Stage 1: Exponent Alignment (Placeholder)
                        stage2_reg[counter] <= stage1_reg[counter] + scalar; // For now, a simple add operation
                        counter <= counter + 1;
                    end
                end

                WRITE_BACK: begin
                    vector_out_0 <= stage2_reg[0];
                    vector_out_1 <= stage2_reg[1];
                    vector_out_2 <= stage2_reg[2];
                    vector_out_3 <= stage2_reg[3];
                    vector_out_4 <= stage2_reg[4];
                    vector_out_5 <= stage2_reg[5];
                    vector_out_6 <= stage2_reg[6];
                    vector_out_7 <= stage2_reg[7];
                    vector_out_8 <= stage2_reg[8];
                    vector_out_9 <= stage2_reg[9];
                    vector_out_10 <= stage2_reg[10];
                    vector_out_11 <= stage2_reg[11];
                    vector_out_12 <= stage2_reg[12];
                    vector_out_13 <= stage2_reg[13];
                    vector_out_14 <= stage2_reg[14];
                    vector_out_15 <= stage2_reg[15];
                    vector_out_16 <= stage2_reg[16];
                    vector_out_17 <= stage2_reg[17];
                    vector_out_18 <= stage2_reg[18];
                    vector_out_19 <= stage2_reg[19];
                    vector_out_20 <= stage2_reg[20];
                    vector_out_21 <= stage2_reg[21];
                    vector_out_22 <= stage2_reg[22];
                    vector_out_23 <= stage2_reg[23];
                    vector_out_24 <= stage2_reg[24];
                    vector_out_25 <= stage2_reg[25];
                    vector_out_26 <= stage2_reg[26];
                    vector_out_27 <= stage2_reg[27];
                    vector_out_28 <= stage2_reg[28];
                    vector_out_29 <= stage2_reg[29];
                    vector_out_30 <= stage2_reg[30];
                    vector_out_31 <= stage2_reg[31];
                    done <= 1;
                end
            endcase
        end
    end

endmodule