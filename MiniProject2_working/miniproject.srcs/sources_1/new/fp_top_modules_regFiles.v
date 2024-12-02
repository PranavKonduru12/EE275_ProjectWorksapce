`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 01:17:01 PM
// Design Name: 
// Module Name: fp_top_modules_regFiles
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

//does not have opSelect as input
//module top_fpu_register_file(
//    input wire clk,
//    input wire rst,
//    input wire start, // Signal to start vector-scalar addition
//    input wire [31:0] scalar_write_data,
//    input wire scalar_write_enable,
//    output wire done  // Signal to indicate completion
//);

//    // Internal Signals
//    wire [4:0] read_reg1, read_reg2, write_reg;
//    wire [31:0] read_data1, read_data2, write_data;
//    wire write_enable;
//    wire fpu_valid;
//    wire [31:0] fpu_result;
//    wire [31:0] scalar_data;
//    wire [31:0] opA, opB;
//    wire opSelect;

//    // Instantiate the Register File
//    fp_register_file reg_file_inst (
//        .clk(clk),
//        .rst(rst),
//        .read_reg1(read_reg1),
//        .read_reg2(read_reg2),
//        .write_reg(write_reg),
//        .write_data(fpu_result), // Write back the result from FPU
//        .write_enable(write_enable),
//        .read_data1(read_data1),
//        .read_data2(read_data2),
//        .scalar_write_data(scalar_write_data), // Scalar register input from the top module
//        .scalar_write_enable(scalar_write_enable), // Scalar write enable from the top module
//        .scalar_data(scalar_data)
//    );

//    // Instantiate the FPU
//    fpu_4stage fpu_inst (
//        .clk(clk),
//        .rst(rst),
//        .opA(opA), // Operand A from register file
//        .opB(opB), // Operand B from register file or scalar register
//        .opSelect(opSelect), // Operation select (0 for FADD, 1 for FSUB)
//        .result(fpu_result), // Result of the operation
//        .valid(fpu_valid) // Valid signal to indicate result is ready
//    );

//    // Instantiate Vector-Scalar Control Logic
//    vector_scalar_control control_inst (
//        .clk(clk),
//        .rst(rst),
//        .start(start),
//        .done(done),
//        .read_reg_index(read_reg1), // Reading vector register index
//        .write_reg_index(write_reg), // Writing result back
//        .write_enable(write_enable),
//        .fpu_valid(fpu_valid),
//        .opSelect(opSelect),
//        .scalar_data(scalar_data),
//        .fpu_result(fpu_result),
//        .opA(opA),
//        .reg_data(read_data1)
//    );

//    // Assign Operand B to the Scalar Data
//    assign opB = scalar_data;

//endmodule

module top_fpu_register_file(
    input wire clk,
    input wire rst,
    input wire start, // Signal to start vector-scalar addition
    input wire [31:0] scalar_write_data,
    input wire scalar_write_enable,
    output wire done, // Signal to indicate completion
    input wire opSelect   ////added
);

    // Internal Signals
    wire [4:0] read_reg1, read_reg2, write_reg;
    wire [31:0] read_data1, read_data2, write_data;
    wire write_enable;
    wire fpu_valid;
    wire [31:0] fpu_result;
    wire [31:0] scalar_data;
    wire [31:0] opA, opB;
    //wire opSelect;                ///commented

    // Instantiate the Register File
    fp_register_file reg_file_inst (
        .clk(clk),
        .rst(rst),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(fpu_result), // Write back the result from FPU
        .write_enable(write_enable),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .scalar_write_data(scalar_write_data), // Scalar register input from the top module
        .scalar_write_enable(scalar_write_enable), // Scalar write enable from the top module
        .scalar_data(scalar_data)
    );

    // Instantiate the FPU
    fpu_4stage fpu_inst (
        .clk(clk),
        .rst(rst),
        .opA(opA), // Operand A from register file
        .opB(opB), // Operand B from register file or scalar register
        .opSelect(opSelect), // Operation select (0 for FADD, 1 for FSUB)
        .result(fpu_result), // Result of the operation
        .valid(fpu_valid) // Valid signal to indicate result is ready
    );

    // Instantiate Vector-Scalar Control Logic
    vector_scalar_control control_inst (
        .clk(clk),
        .rst(rst),
        .start(start),
        .done(done),
        .read_reg_index(read_reg1), // Reading vector register index
        .write_reg_index(write_reg), // Writing result back
        .write_enable(write_enable),
        .fpu_valid(fpu_valid),
        .opSelect(opSelect),
        .scalar_data(scalar_data),
        .fpu_result(fpu_result),
        .opA(opA),
        .reg_data(read_data1)
    );

    // Assign Operand B to the Scalar Data
    assign opB = scalar_data;

endmodule
