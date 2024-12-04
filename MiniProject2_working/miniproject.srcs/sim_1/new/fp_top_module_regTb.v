`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 01:18:25 PM
// Design Name: 
// Module Name: fp_top_module_regTb
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

//testbench without current state, opA, opB, result, and write enable
//module top_module_fpu_register_file_tb;
//    // Inputs
//    reg clk;
//    reg rst;
//    reg start;

//    // New signals for scalar register write
//    reg [31:0] scalar_write_data;
//    reg scalar_write_enable;

//    // Outputs
//    wire done;

//    // Instantiate the Top-Level Module
//    top_fpu_register_file uut (
//        .clk(clk),
//        .rst(rst),
//        .start(start),
//        .scalar_write_data(scalar_write_data), // Pass scalar write data to top-level module
//        .scalar_write_enable(scalar_write_enable), // Pass scalar write enable to top-level module
//        .done(done)
//    );

//    // Clock generation
//    initial begin
//        clk = 0;
//        forever #5 clk = ~clk; // 10ns clock period
//    end

//    // Test sequence
//    initial begin
//        // Initialize inputs
//        rst = 1;
//        start = 0;
//        scalar_write_data = 32'h0;
//        scalar_write_enable = 0;

//        // Apply reset
//        #10 rst = 0;

//        // Set scalar value to be written into scalar register
//        scalar_write_data = 32'h00000005; // Scalar value of 5.0
//        scalar_write_enable = 1;
//        #10;
//        scalar_write_enable = 0;

//        // Start vector-scalar addition
//        #10 start = 1;
//        #10 start = 0;

//        // Wait for operation to complete
//        wait(done);

//        // Display results
//        #10;
//        $display("Vector-scalar addition completed successfully.");

//        // Finish simulation
//        #20 $finish;
//    end

//endmodule

//Does not have clock counter or a way to input values into the register
//module top_module_fpu_register_file_tb;
//    // Inputs
//    reg clk;
//    reg rst;
//    reg start;

//    // New signals for scalar register write
//    reg [31:0] scalar_write_data;
//    reg scalar_write_enable;

//    // Outputs
//    wire done;

//    // Internal signals for debugging
//    wire [1:0] current_state;
//    wire [4:0] read_reg_index;
//    wire [4:0] write_reg_index;
//    wire [31:0] opA;
//    wire [31:0] opB;
//    wire [31:0] fpu_result;
//    wire write_enable;
//    wire fpu_valid;

//    // Instantiate the Top-Level Module
//    top_fpu_register_file uut (
//        .clk(clk),
//        .rst(rst),
//        .start(start),
//        .scalar_write_data(scalar_write_data), // Pass scalar write data to top-level module
//        .scalar_write_enable(scalar_write_enable), // Pass scalar write enable to top-level module
//        .done(done)
//    );

//    // Assign internal signals for debugging
//    assign current_state = uut.control_inst.current_state;
//    assign read_reg_index = uut.control_inst.read_reg_index;
//    assign write_reg_index = uut.control_inst.write_reg_index;
//    assign opA = uut.fpu_inst.opA;
//    assign opB = uut.fpu_inst.opB;
//    assign fpu_result = uut.fpu_inst.result;
//    assign write_enable = uut.control_inst.write_enable;
//    assign fpu_valid = uut.fpu_inst.valid;

//    // Clock generation
//    initial begin
//        clk = 0;
//        forever #5 clk = ~clk; // 10ns clock period
//    end

//    // Test sequence
//    initial begin
//        // Initialize inputs
//        rst = 1;
//        start = 0;
//        scalar_write_data = 32'h0;
//        scalar_write_enable = 0;

//        // Apply reset
//        #10 rst = 0;

//        // Set scalar value to be written into scalar register
//        scalar_write_data = 32'h00000005; // Scalar value of 5.0
//        scalar_write_enable = 1;
//        #10;
//        scalar_write_enable = 0;

//        // Start vector-scalar addition
//        #10 start = 1;
//        #10 start = 0;

//        // Wait for operation to complete
//        wait(done);

//        // Display results
//        #10;
//        $display("Vector-scalar addition completed successfully.");

//        // Finish simulation
//        #20 $finish;
//    end

//    // Monitor internal signals for debugging
//    initial begin
//        $monitor("Time: %0dns, State: %b, Read Reg Index: %d, Write Reg Index: %d, opA: %h, opB: %h, FPU Result: %h, Write Enable: %b, FPU Valid: %b", 
//                 $time, current_state, read_reg_index, write_reg_index, opA, opB, fpu_result, write_enable, fpu_valid);
//    end

//endmodule

//Has the clock counter, current states, read registers 
//module top_module_fpu_register_file_tb;
//    // Inputs
//    reg clk;
//    reg rst;
//    reg start;

//    // New signals for scalar register write
//    reg [31:0] scalar_write_data;
//    reg scalar_write_enable;

//    // Outputs
//    wire done;

//    // Internal signals for debugging
//    wire [1:0] current_state;
//    wire [4:0] read_reg_index;
//    wire [4:0] write_reg_index;
//    wire [31:0] opA;
//    wire [31:0] opB;
//    wire [31:0] fpu_result;
//    wire write_enable;
//    wire fpu_valid;

//    // Clock cycle counter
//    integer clock_cycles;

//    // Instantiate the Top-Level Module
//    top_fpu_register_file uut (
//        .clk(clk),
//        .rst(rst),
//        .start(start),
//        .scalar_write_data(scalar_write_data), // Pass scalar write data to top-level module
//        .scalar_write_enable(scalar_write_enable), // Pass scalar write enable to top-level module
//        .done(done)
//    );

//    // Assign internal signals for debugging
//    assign current_state = uut.control_inst.current_state;
//    assign read_reg_index = uut.control_inst.read_reg_index;
//    assign write_reg_index = uut.control_inst.write_reg_index;
//    assign opA = uut.fpu_inst.opA;
//    assign opB = uut.fpu_inst.opB;
//    assign fpu_result = uut.fpu_inst.result;
//    assign write_enable = uut.control_inst.write_enable;
//    assign fpu_valid = uut.fpu_inst.valid;

//    // Clock generation
//    initial begin
//        clk = 0;
//        forever #5 clk = ~clk; // 10ns clock period
//    end

//    // Test sequence
//    initial begin
//        // Initialize inputs
//        rst = 1;
//        start = 0;
//        scalar_write_data = 32'h0;
//        scalar_write_enable = 0;
//        clock_cycles = 0;

//        // Apply reset
//        #10 rst = 0;

//        // Set scalar value to be written into scalar register
//        scalar_write_data = 32'h00000005; // Scalar value of 5.0
//        scalar_write_enable = 1;
//        #10;
//        scalar_write_enable = 0;

//        // Start vector-scalar addition
//        #10 start = 1;
//        #10 start = 0;

//        // Wait for operation to complete
//        wait(done);

//        // Display results
//        #10;
//        $display("Vector-scalar addition completed successfully.");
//        $display("Total clock cycles taken: %d", clock_cycles);

//        // Finish simulation
//        #20 $finish;
//    end

//    // Count clock cycles
//    always @(posedge clk) begin
//        if (!rst && !done) begin
//            clock_cycles = clock_cycles + 1;
//        end
//    end

//    // Monitor internal signals for debugging
//    initial begin
//        $monitor("Time: %0dns, State: %b, Read Reg Index: %d, Write Reg Index: %d, opA: %h, opB: %h, FPU Result: %h, Write Enable: %b, FPU Valid: %b", 
//                 $time, current_state, read_reg_index, write_reg_index, opA, opB, fpu_result, write_enable, fpu_valid);
//    end

//endmodule

module top_module_fpu_register_file_tb;
    // Inputs
    reg clk;
    reg rst;
    reg start;

    // New signals for scalar register write
    reg [31:0] scalar_write_data;
    reg scalar_write_enable;
    reg opSelect; // New signal for operation select (0 for FADD, 1 for FSUB)

    // Outputs
    wire done;

    // Internal signals for debugging
    wire [1:0] current_state;
    wire [4:0] read_reg_index;
    wire [4:0] write_reg_index;
    wire [31:0] opA;
    wire [31:0] opB;
    wire [31:0] fpu_result;
    wire write_enable;
    wire fpu_valid;

    // Clock cycle counter
    integer clock_cycles;

    // Instantiate the Top-Level Module
    top_fpu_register_file uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .scalar_write_data(scalar_write_data), // Pass scalar write data to top-level module
        .scalar_write_enable(scalar_write_enable), // Pass scalar write enable to top-level module
        .opSelect(opSelect), // Pass opSelect to top-level module
        .done(done)
    );

    // Assign internal signals for debugging
    assign current_state = uut.control_inst.current_state;
    assign read_reg_index = uut.control_inst.read_reg_index;
    assign write_reg_index = uut.control_inst.write_reg_index;
    assign opA = uut.fpu_inst.opA;
    assign opB = uut.fpu_inst.opB;
    assign fpu_result = uut.fpu_inst.result;
    assign write_enable = uut.control_inst.write_enable;
    assign fpu_valid = uut.fpu_inst.valid;

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
        scalar_write_data = 32'h0;
        scalar_write_enable = 0;
        opSelect = 0; // Start with FADD operation
        clock_cycles = 0;

        // Apply reset
        #10 rst = 0;         /////////////////////////////////////////////////////////

        // Set scalar value to be written into scalar register
        scalar_write_data = 32'h40a00000; // Scalar value of 5.0
        scalar_write_enable = 1;
        #10;
        scalar_write_enable = 0;

        // Load vector register values
        uut.reg_file_inst.registers[0] = 32'h3F800000; // 1.0
        uut.reg_file_inst.registers[1] = 32'h40000000; // 2.0

        // Start vector-scalar addition
        #10 start = 1;
        #10 start = 0;

        // Wait for operation to complete
        wait(done);

        // Display results
        #10;
        $display("[FADD] Register 0 Result: %h", uut.reg_file_inst.registers[0]);
        $display("[FADD] Register 1 Result: %h", uut.reg_file_inst.registers[1]);

        // Apply reset before switching operation type
        #10 rst = 1;
        #10 rst = 0;

        // Set scalar value to be written into scalar register
        scalar_write_data = 32'h00000003; // Scalar value of 3.0
        scalar_write_enable = 1;
        #10;
        scalar_write_enable = 0;

        // Load vector register values
        uut.reg_file_inst.registers[0] = 32'h40400000; // 3.0
        uut.reg_file_inst.registers[1] = 32'h40800000; // 4.0

        // Switch to FSUB operation
        opSelect = 1;

        // Start vector-scalar subtraction
        #10 start = 1;
        #10 start = 0;

        // Wait for operation to complete
        wait(done);

        // Display results
        #10;
        $display("[FSUB] Register 0 Result: %h", uut.reg_file_inst.registers[0]);
        $display("[FSUB] Register 1 Result: %h", uut.reg_file_inst.registers[1]);

        // Finish simulation
        #20 $finish;                                                         //////////////////////////
    end
        // Count clock cycles
    always @(posedge clk) begin
        if (!rst && !done) begin
            clock_cycles = clock_cycles + 1;
        end
    end
endmodule