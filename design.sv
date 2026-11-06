module digital_calculator (
    input logic [7:0] A,
    input logic [7:0] B,
    input logic [3:0] opcode,

    output logic [15:0] result,

    output logic ADD,
    output logic SUB,
    output logic MUL,
    output logic DIV,
    output logic AND_op,
    output logic OR_op,
    output logic XOR_op,
    output logic NOT_op
);
    // Internal status flags
    logic zero_flag;
    logic carry_flag;
    logic borrow_flag;
    logic div_by_zero;

    always_comb begin
        // Default values
        result      = 16'b0;
        zero_flag   = 1'b0;
        carry_flag  = 1'b0;
        borrow_flag = 1'b0;
        div_by_zero = 1'b0;

        ADD    = 1'b0;
        SUB    = 1'b0;
        MUL    = 1'b0;
        DIV    = 1'b0;
        AND_op = 1'b0;
        OR_op  = 1'b0;
        XOR_op = 1'b0;
        NOT_op = 1'b0;
        case (opcode)

            // ADD
            4'b0000: begin
                ADD = 1'b1;
                result = {8'b0,A} + {8'b0,B};
                carry_flag = ({1'b0,A} + {1'b0,B}) > 9'd255;
            end

            // SUB
            4'b0001: begin
                SUB = 1'b1;
                result = {8'b0,(A-B)};
                borrow_flag = (A < B);
            end

            // MUL
            4'b0010: begin
                MUL = 1'b1;
                result = A * B;
            end

            // DIV
            4'b0011: begin
                DIV = 1'b1;
                if (B != 0)
                    result = A / B;
                else begin
                    result = 16'b0;
                    div_by_zero = 1'b1;
                end
            end

            // AND
            4'b0100: begin
                AND_op = 1'b1;
                result = A & B;
            end

            // OR
            4'b0101: begin
                OR_op = 1'b1;
                result = A | B;
            end

            // XOR
            4'b0110: begin
                XOR_op = 1'b1;
                result = A ^ B;
            end

            // NOT
            4'b0111: begin
                NOT_op = 1'b1;
                result = {8'b0,~A};
            end

            default: begin
                result = 16'b0;
            end

        endcase

        zero_flag = (result == 16'b0);

    end

endmodule
