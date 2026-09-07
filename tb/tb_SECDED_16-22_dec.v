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

    reg  [DATA_BIT-1:0] data;
    wire [CODE_BIT-1:0] encoded_data;
    wire [CODE_BIT-1:0] decoded_data;
    wire uncorrected;

    integer i;

    // ============================================================
    // Encoder
    // ============================================================
    SECDED_1622_enc #(
        .DATA_BIT(DATA_BIT),
        .CODE_BIT(CODE_BIT)
    ) encoder (
        .clk      (clk),
        .rst_n    (rst_n),
        .data_in  (data),
        .data_out (encoded_data)
    );

    // ============================================================
    // Decoder
    // ============================================================
    SECDED_1622_dec #(
        .DATA_BIT(DATA_BIT),
        .CODE_BIT(CODE_BIT)
    ) decoder (
        .clk        (clk),
        .rst_n      (rst_n),
        .data_in    (encoded_data),
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
    // Test
    // ============================================================
    initial begin

        // Initial condition
        rst_n = 1'b0;
        data  = '0;

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

        end

        // Hold last value
        @(negedge clk);

        $finish;
    end

endmodule