module add16se_EMB(input logic [15:0] A, B, output logic [15:0] O);

    always_comb begin
        O[7:0] = A[7:0] & B[7:0];
        O[15:8] = A[15:8] + B[15:8] + (A[7] | B[7]);
    end

endmodule