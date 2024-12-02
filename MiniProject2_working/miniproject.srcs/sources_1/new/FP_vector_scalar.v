`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 01:09:35 PM
// Design Name: 
// Module Name: FP_vector_scalar
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

module vector_scalar_control(
    input wire clk,
    input wire rst,
    input wire start, // Signal to start vector-scalar addition
    output reg done,  // Signal to indicate completion
    
    // Register File Interface
    output reg [4:0] read_reg_index, // Register address to read
    output reg [4:0] write_reg_index, // Register address to write back
    output reg write_enable, // Write enable signal for register file
    
    // FPU Interface
    input wire fpu_valid, // FPU valid signal to indicate result is ready
    output reg opSelect, // Operation select (0 for FADD)
    input wire [31:0] scalar_data, // Scalar value to be added to vector
    input wire [31:0] fpu_result, // Result from FPU
    
    // Register File Data
    output reg [31:0] opA, // Operand A for FPU
    input wire [31:0] reg_data // Data read from register file
);

// State machine states using parameters for Verilog
parameter IDLE = 2'b00;
parameter LOAD = 2'b01;
parameter EXECUTE = 2'b10;
parameter WRITE_BACK = 2'b11;

reg [1:0] current_state, next_state; // State registers
reg [4:0] vector_index; // Index for iterating over vector registers (0 to 31)

// State transition logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        current_state <= IDLE;
        vector_index <= 5'b0;
    end else begin
        current_state <= next_state;
    end
end

// Next state and output logic
always @(*) begin
    // Default values
    next_state = current_state;
    done = 1'b0;
    write_enable = 1'b0;
    opSelect = 1'b0; // Always FADD for vector-scalar addition
    read_reg_index = vector_index;
    write_reg_index = vector_index;
    opA = reg_data;

    case (current_state)
        IDLE: begin
            if (start) begin
                next_state = LOAD;
            end
        end

        LOAD: begin
            // Load the scalar value and register data to FPU
            opA = reg_data;
            next_state = EXECUTE;
        end

        EXECUTE: begin
            // Wait for FPU to complete the operation
            if (fpu_valid) begin
                next_state = WRITE_BACK;
            end
        end

        WRITE_BACK: begin
            // Write back the result to the register file
            write_enable = 1'b1;
            write_reg_index = vector_index;
            if (vector_index == 5'd31) begin
                next_state = IDLE;
                done = 1'b1;
            end else begin
                next_state = LOAD;
                vector_index = vector_index + 1;
            end
        end
    endcase
end

endmodule


