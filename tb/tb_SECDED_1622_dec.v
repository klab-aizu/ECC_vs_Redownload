`timescale 1ns/1ps

module tb_SECDED_1622_dec;

    parameter DATA_BIT = 16;
    parameter CODE_BIT = 22;

    // ============================================================
    // Simulation parameters
    // ============================================================
    parameter CLOCK_PERIOD = 10;       // ns, 100 MHz
    parameter NUM_CYCLES   = 100000;   // number of codewords

    reg clk;
    reg rst_n;

    reg [CODE_BIT-1:0] error_mask;

    reg  [DATA_BIT-1:0] data;
    wire [CODE_BIT-1:0] encoded_data;
    wire [CODE_BIT-1:0] decoded_data;
    wire uncorrected;

    integer i;

    integer num_errors;
    integer pos1, pos2;

    // ============================================================
    // Encoder
    // ============================================================
    SECDED_1622_enc 
    //#(
    //    .DATA_BIT(DATA_BIT),
    //    .CODE_BIT(CODE_BIT)
    //) 
    encoder (
        .data_in  (data),
        .data_out (encoded_data)
    );

    // ============================================================
    // Decoder
    // ============================================================
    SECDED_1622_dec 
    //#(
    //    .DATA_BIT(DATA_BIT),
    //    .CODE_BIT(CODE_BIT)
    //) 
    decoder (
        .data_in    (encoded_data ^ error_mask),
        .uncorrected(uncorrected),
        .data_out   (decoded_data)
    );

    // ============================================================
    // Clock
    // ============================================================
    initial begin
        clk = 1'b0;

        forever #(CLOCK_PERIOD/2) clk = ~clk;
    end



    // ============================================================
    // Error Mask
    // ============================================================
    always @(*) begin
        error_mask = 'b0;

        //num_errors = $urandom_range(0, 2);

        if (num_errors == 1) begin
            pos1 = $urandom_range(0, CODE_BIT-1);
            error_mask[pos1] = 1'b1;
        end

        else if (num_errors == 2) begin
            pos1 = $urandom_range(0, CODE_BIT-1);
            pos2 = $urandom_range(0, CODE_BIT-1);

            while (pos2 == pos1) begin
                pos2 = $urandom_range(0, CODE_BIT-1);
            end 

            error_mask[pos1] = 1'b1;
            error_mask[pos2] = 1'b1;
        end
    end

    // ============================================================
    // Test
    // ============================================================
    initial begin

        // Initial condition
        rst_n = 1'b0;
        data  = '0;
        num_errors = 0;

        // Reset
        #(2 * CLOCK_PERIOD);
        rst_n = 1'b1;

        // --------------------------------------------------------
        // Random data
        // One new 16-bit word every clock cycle
        // --------------------------------------------------------
        for (i = 0; i < NUM_CYCLES; i = i + 1) begin

            @(negedge clk);

            data = $urandom;

            if (i>NUM_CYCLES/3) begin
                num_errors = 1;
            end if  (i>NUM_CYCLES*2/3) begin
                num_errors = 2;
            end
        end

        // Hold last value
        @(negedge clk);

        $finish;
    end


always @(posedge clk) begin
    if (rst_n) begin
        if ((decoded_data !== encoded_data) && uncorrected == 1'b0) begin
            $display("ERROR: Silent errors (%d)!", i);
            $display("Encoded : %b", encoded_data);
            $display("Decoded : %b", decoded_data);
            $display("Uncorrected : %b", uncorrected);
        end
    end
end

endmodule