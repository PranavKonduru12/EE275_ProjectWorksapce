`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 01:12:39 PM
// Design Name: 
// Module Name: fp_vector_scalar_controlTb
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


module vector_scalar_control_tb;
    // Inputs
    reg clk;
    reg rst;
    reg start;
    reg fpu_valid;
    reg [31:0] reg_data;
    reg [31:0] scalar_data;
    reg [31:0] fpu_result;

    // Outputs
    wire done;
    wire [4:0] read_reg_index;
    wire [4:0] write_reg_index;
    wire write_enable;
    wire opSelect;
    wire [31:0] opA;

    // Instantiate the vector-scalar control module
    vector_scalar_control uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .done(done),
        .read_reg_index(read_reg_index),
        .write_reg_index(write_reg_index),
        .write_enable(write_enable),
        .fpu_valid(fpu_valid),
        .opSelect(opSelect),
        .scalar_data(scalar_data),
        .fpu_result(fpu_result),
        .opA(opA),
        .reg_data(reg_data)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        start = 0;
        fpu_valid = 0;
        reg_data = 32'h0;
        scalar_data = 32'h0;
        fpu_result = 32'h0;

        // Apply reset
        #10 rst = 0;

        // Set scalar value
        scalar_data = 32'h00000005; // Scalar value of 5.0

        // Start vector-scalar addition
        #10 start = 1;

        // Wait for the LOAD state to complete
        #10;
        start = 0;
        reg_data = 32'h0000000A; // Register value of 10.0

        // Wait for EXECUTE state and simulate FPU valid signal
        #20;
        fpu_valid = 1;
        fpu_result = 32'h0000000F; // Result of 10.0 + 5.0 = 15.0

        // Wait for WRITE_BACK state
        #10;
        fpu_valid = 0;

        // Iterate over all registers (loop simulation)
        repeat(31) begin
            #20;
            reg_data = reg_data + 32'h00000001; // Increment register value for testing
            fpu_valid = 1;
            fpu_result = reg_data + scalar_data;
            #10 fpu_valid = 0;
        end

        // Wait for done signal
        #20;
        if (done) begin
            $display("Vector-scalar addition completed successfully.");
        end

        // Finish simulation
        #20 $finish;
    end

endmodule
