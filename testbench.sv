`timescale 1ns/1ps
module tb_digital_calculator;

    // Input signals
    logic [7:0] A, B;
    logic [3:0] opcode;

    // Output signals
    logic [15:0] result;
    logic ADD, SUB, MUL, DIV;
    logic AND_op, OR_op, XOR_op, NOT_op;

    // DUT Instantiation
    digital_calculator DUT (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(result),
        .ADD(ADD),
        .SUB(SUB),
        .MUL(MUL),
        .DIV(DIV),
        .AND_op(AND_op),
        .OR_op(OR_op),
        .XOR_op(XOR_op),
        .NOT_op(NOT_op)
    );
  //Waveform
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars(0,
                A,
                B,
                opcode,ADD,SUB,MUL,DIV,AND_op,OR_op,XOR_op,NOT_op,result
               );

        // ADD: 20 + 10 = 30
        A = 8'd20;
        B = 8'd10;
        opcode = 4'b0000;
        #10;

        // SUB: 50 - 20 = 30
        A = 8'd50;
        B = 8'd20;
        opcode = 4'b0001;
        #10;

        // MUL: 10 * 5 = 50
        A = 8'd10;
        B = 8'd5;
        opcode = 4'b0010;
        #10;

        // DIV: 100 / 10 = 10
        A = 8'd100;
        B = 8'd10;
        opcode = 4'b0011;
        #10;

        // AND: 204 & 170 = 136
        A = 8'd204;
        B = 8'd170;
        opcode = 4'b0100;
        #10;

        // OR: 204 | 170 = 238
        A = 8'd204;
        B = 8'd170;
        opcode = 4'b0101;
        #10;

        // XOR: 204 ^ 170 = 102
        A = 8'd204;
        B = 8'd170;
        opcode = 4'b0110;
        #10;

        // NOT: ~204 = 51
        A = 8'd204;
        B = 8'd0;
        opcode = 4'b0111;
        #10;

        $display("SIMULATION COMPLETED");
        $finish;

    end

endmodule
