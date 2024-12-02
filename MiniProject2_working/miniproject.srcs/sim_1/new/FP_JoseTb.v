`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2024 04:28:18 PM
// Design Name: 
// Module Name: FP_JoseTb
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

//Testbench for the design without array as input
//module fpu_32bit_tb;
//    // Inputs
//    reg clk;
//    reg reset;
//    //reg [31:0] X [0:31];    // 32-length register set
//    reg [31:0] a, b;
//    reg [31:0] scalar;       // Scalar FP register
//    reg [31:0] instruction;  // FADD or FSUB instruction

//    // Output
//    wire [31:0] result;      // Result of operation

//    // Instantiate the Unit Under Test (UUT)
////    fpu_32bit uut (
////        .clk(clk),
////        .reset(reset),
////        .X(X),
////        .scalar(scalar),
////        .instruction(instruction),
////        .result(result)
////    );
//      fpu_32bit uut (
//        .clk(clk),
//        .reset(reset),
// //       .X(X),
//        .a(a),
//        .b(b),
//        .scalar(scalar),
//        .instruction(instruction),
//        .result(result)
//    );

//    // Clock generation
//    always #5 clk = ~clk;  // 10ns clock period

//    initial begin
//        // Initialize Inputs
//        clk = 0;
//        reset = 1;
//        scalar = 0;
//        instruction = 0;

//        // Initialize register set X
////        X[0] = 32'h3F800000;  // 1.0 in IEEE 754 floating point format
////        X[1] = 32'h40000000;  // 2.0 in IEEE 754 floating point format
////        X[2] = 32'h40400000;  // 3.0 in IEEE 754 floating point format
//        a = 32'h40000000;
//        b = 32'h40400000;
//        // You can initialize other values of X if needed

//        // Wait for global reset to finish
//        #10;
//        reset = 0;

//        // Test Case 1: FADD (1.0 + 2.0)
//        instruction = `FADD;
//        scalar = 32'h40000000;  // Scalar value = 2.0
//        #10;
        
//        // Test Case 2: FSUB (2.0 - 3.0)
//        instruction = `FSUB;
//        scalar = 32'h40400000;  // Scalar value = 3.0
//        #10;

//        // Test Case 3: FADD (1.0 + 3.0)
//        instruction = `FADD;
//        scalar = 32'h40400000;  // Scalar value = 3.0
//        #10;
        
//        // Test Case 4: FSUB (1.0 - 2.0)
//        instruction = `FSUB;
//        scalar = 32'h40000000;  // Scalar value = 2.0
//        #10;

//        // Add more test cases if needed

//        // Finish simulation
//        $finish;
//    end

//    // Monitor output
//    initial begin
//        $monitor("Time = %0t, instruction = %h, scalar = %h, result = %h", $time, instruction, scalar, result);
//    end

//endmodule


module fp_unit_tb;
    // Inputs to DUT
    reg clk;
    reg rst;
    reg start;
    reg [31:0] scalar;
    reg [31:0] vector_in_0;
    reg [31:0] vector_in_1;
    reg [31:0] vector_in_2;
    reg [31:0] vector_in_3;
    reg [31:0] vector_in_4;
    reg [31:0] vector_in_5;
    reg [31:0] vector_in_6;
    reg [31:0] vector_in_7;
    reg [31:0] vector_in_8;
    reg [31:0] vector_in_9;
    reg [31:0] vector_in_10;
    reg [31:0] vector_in_11;
    reg [31:0] vector_in_12;
    reg [31:0] vector_in_13;
    reg [31:0] vector_in_14;
    reg [31:0] vector_in_15;
    reg [31:0] vector_in_16;
    reg [31:0] vector_in_17;
    reg [31:0] vector_in_18;
    reg [31:0] vector_in_19;
    reg [31:0] vector_in_20;
    reg [31:0] vector_in_21;
    reg [31:0] vector_in_22;
    reg [31:0] vector_in_23;
    reg [31:0] vector_in_24;
    reg [31:0] vector_in_25;
    reg [31:0] vector_in_26;
    reg [31:0] vector_in_27;
    reg [31:0] vector_in_28;
    reg [31:0] vector_in_29;
    reg [31:0] vector_in_30;
    reg [31:0] vector_in_31;

    // Outputs from DUT
    wire [31:0] vector_out_0;
    wire [31:0] vector_out_1;
    wire [31:0] vector_out_2;
    wire [31:0] vector_out_3;
    wire [31:0] vector_out_4;
    wire [31:0] vector_out_5;
    wire [31:0] vector_out_6;
    wire [31:0] vector_out_7;
    wire [31:0] vector_out_8;
    wire [31:0] vector_out_9;
    wire [31:0] vector_out_10;
    wire [31:0] vector_out_11;
    wire [31:0] vector_out_12;
    wire [31:0] vector_out_13;
    wire [31:0] vector_out_14;
    wire [31:0] vector_out_15;
    wire [31:0] vector_out_16;
    wire [31:0] vector_out_17;
    wire [31:0] vector_out_18;
    wire [31:0] vector_out_19;
    wire [31:0] vector_out_20;
    wire [31:0] vector_out_21;
    wire [31:0] vector_out_22;
    wire [31:0] vector_out_23;
    wire [31:0] vector_out_24;
    wire [31:0] vector_out_25;
    wire [31:0] vector_out_26;
    wire [31:0] vector_out_27;
    wire [31:0] vector_out_28;
    wire [31:0] vector_out_29;
    wire [31:0] vector_out_30;
    wire [31:0] vector_out_31;
    wire done;

    // Instantiate the DUT
    fp_unit dut (
        .clk(clk),
        .rst(rst),
        .scalar(scalar),
        .vector_in_0(vector_in_0),
        .vector_in_1(vector_in_1),
        .vector_in_2(vector_in_2),
        .vector_in_3(vector_in_3),
        .vector_in_4(vector_in_4),
        .vector_in_5(vector_in_5),
        .vector_in_6(vector_in_6),
        .vector_in_7(vector_in_7),
        .vector_in_8(vector_in_8),
        .vector_in_9(vector_in_9),
        .vector_in_10(vector_in_10),
        .vector_in_11(vector_in_11),
        .vector_in_12(vector_in_12),
        .vector_in_13(vector_in_13),
        .vector_in_14(vector_in_14),
        .vector_in_15(vector_in_15),
        .vector_in_16(vector_in_16),
        .vector_in_17(vector_in_17),
        .vector_in_18(vector_in_18),
        .vector_in_19(vector_in_19),
        .vector_in_20(vector_in_20),
        .vector_in_21(vector_in_21),
        .vector_in_22(vector_in_22),
        .vector_in_23(vector_in_23),
        .vector_in_24(vector_in_24),
        .vector_in_25(vector_in_25),
        .vector_in_26(vector_in_26),
        .vector_in_27(vector_in_27),
        .vector_in_28(vector_in_28),
        .vector_in_29(vector_in_29),
        .vector_in_30(vector_in_30),
        .vector_in_31(vector_in_31),
        .start(start),
        .vector_out_0(vector_out_0),
        .vector_out_1(vector_out_1),
        .vector_out_2(vector_out_2),
        .vector_out_3(vector_out_3),
        .vector_out_4(vector_out_4),
        .vector_out_5(vector_out_5),
        .vector_out_6(vector_out_6),
        .vector_out_7(vector_out_7),
        .vector_out_8(vector_out_8),
        .vector_out_9(vector_out_9),
        .vector_out_10(vector_out_10),
        .vector_out_11(vector_out_11),
        .vector_out_12(vector_out_12),
        .vector_out_13(vector_out_13),
        .vector_out_14(vector_out_14),
        .vector_out_15(vector_out_15),
        .vector_out_16(vector_out_16),
        .vector_out_17(vector_out_17),
        .vector_out_18(vector_out_18),
        .vector_out_19(vector_out_19),
        .vector_out_20(vector_out_20),
        .vector_out_21(vector_out_21),
        .vector_out_22(vector_out_22),
        .vector_out_23(vector_out_23),
        .vector_out_24(vector_out_24),
        .vector_out_25(vector_out_25),
        .vector_out_26(vector_out_26),
        .vector_out_27(vector_out_27),
        .vector_out_28(vector_out_28),
        .vector_out_29(vector_out_29),
        .vector_out_30(vector_out_30),
        .vector_out_31(vector_out_31),
        .done(done)
    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        start = 0;
        scalar = 32'h3f800000; // Example scalar value (1.0 in IEEE 754 format)
        vector_in_0 = 32'h40000000; // Example vector values (2.0 in IEEE 754 format)
        vector_in_1 = 32'h40400000; // 3.0
        vector_in_2 = 32'h40800000; // 4.0
        vector_in_3 = 32'h40a00000; // 5.0
        vector_in_4 = 32'h40c00000; // 6.0
        vector_in_5 = 32'h40e00000; // 7.0
        vector_in_6 = 32'h41000000; // 8.0
        vector_in_7 = 32'h41100000; // 9.0
        vector_in_8 = 32'h41200000; // 10.0
        vector_in_9 = 32'h41300000; // 11.0
        vector_in_10 = 32'h41400000; // 12.0
        vector_in_11 = 32'h41500000; // 13.0
        vector_in_12 = 32'h41600000; // 14.0
        vector_in_13 = 32'h41700000; // 15.0
        vector_in_14 = 32'h41800000; // 16.0
        vector_in_15 = 32'h41900000; // 17.0
        vector_in_16 = 32'h41a00000; // 18.0
        vector_in_17 = 32'h41b00000; // 19.0
        vector_in_18 = 32'h41c00000; // 20.0
        vector_in_19 = 32'h41d00000; // 21.0
        vector_in_20 = 32'h41e00000; // 22.0
        vector_in_21 = 32'h41f00000; // 23.0
        vector_in_22 = 32'h42000000; // 24.0
        vector_in_23 = 32'h42100000; // 25.0
        vector_in_24 = 32'h42200000; // 26.0
        vector_in_25 = 32'h42300000; // 27.0
        vector_in_26 = 32'h42400000; // 28.0
        vector_in_27 = 32'h42500000; // 29.0
        vector_in_28 = 32'h42600000; // 30.0
        vector_in_29 = 32'h42700000; // 31.0
        vector_in_30 = 32'h42800000; // 32.0
        vector_in_31 = 32'h42900000; // 33.0

        // Apply Reset
        #10 rst = 0;

        // Start the vector-scalar addition
        #10 start = 1;
        #10 start = 0;

        // Wait for the operation to complete
        wait(done);

        // Observe outputs
        #10;
        $display("Vector Output 0: %h", vector_out_0);
        $display("Vector Output 1: %h", vector_out_1);
        // Add more $display statements as needed to check all outputs

        // Finish Simulation
        #100;
        $finish;
    end

endmodule
