module ALU_64_bit(
    input wire [63:0] a, b,        // Operands
    input wire [3:0] ALUOp,        // Control signals
    output wire [63:0] Result,     // Output result
    output wire zero               // Zero flag
);

    wire [63:0] sumOut;            // Sum for integer operations
    wire [31:0] fpuResult;         // Result from FPU (32-bit floating-point)
    wire fpuException;             // Exception flag from FPU

    // Integer addition/subtraction (bypassed for debugging)
    assign sumOut = (ALUOp == 4'b0110) ? (a - b) : (a + b);

    // FPU module instance
    FPU fpu (
        .opA(a[31:0]),             // Operand A (lower 32 bits)
        .opB(b[31:0]),             // Operand B (lower 32 bits)
        .FADD_FSUB(ALUOp[0]),      // Control signal: 1 = FADD, 0 = FSUB
        .result(fpuResult),        // FPU result
        .exception(fpuException)   // FPU exception flag
    );

    // Multiplexer to select between ALU and FPU results
    assign Result = (ALUOp[3]) ? {32'b0, fpuResult} : sumOut; // Select FPU for ALUOp[3] = 1

    // Zero flag
    assign zero = (Result == 64'b0);

endmodule

//module ALU_64_bit(
//  input wire [63:0] a, wire [63:0] b, wire [3:0] ALUOp,
//  output wire [63:0] Result, wire zero
//);
//  wire [63:0] abar, bbar, mux1out, mux2out;
//  wire [63:0] andOut, orOut, sumOut;
//  assign abar = ~a;
//  assign bbar = ~b;
//  mux m1 (.in1(a), .in2(abar), .sel(ALUOp[3]), .out(mux1out));
//  mux m2 (.in1(b), .in2(bbar), .sel(ALUOp[2]), .out(mux2out));
//  assign andOut = mux1out & mux2out;
//  assign orOut = mux1out | mux2out;
//  assign sumOut = mux1out + mux2out;
//  mux2 res (.in1(andOut), .in2(orOut), .in3(sumOut), .sel(ALUOp[1:0]), .out(Result));
//  assign zero = Result == 64'b0;
//endmodule