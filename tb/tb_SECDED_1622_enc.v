`timescale 1ns/1ps

module tb_SECDED_1622_enc;

    parameter DATA_BIT = 16;
    parameter CODE_BIT = 22;

    // ============================================================
    // Simulation parameters
    // ============================================================
    parameter CLOCK_PERIOD = 10;       // ns, 100 MHz
    parameter NUM_CYCLES   = 100000;   // number of input words

    reg clk;
    reg rst_n;

    reg  [DATA_BIT-1:0] data_in;
    wire [CODE_BIT-1:0] data_out;

    integer i;

    // ============================================================
    // DUT
    // ============================================================
    SECDED_1622_enc #(
        .DATA_BIT(DATA_BIT),
        .CODE_BIT(CODE_BIT)
    ) dut (
        .data_in  (data_in),
        .data_out (data_out)
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
        rst_n   = 1'b0;
        data_in = '0;

        // Reset
        #(2 * CLOCK_PERIOD);
        rst_n = 1'b1;

        // --------------------------------------------------------
        // Random input: one new word every clock cycle
        // --------------------------------------------------------
        for (i = 0; i < NUM_CYCLES; i = i + 1) begin

            @(negedge clk);

            data_in = $urandom;

        end

        // Hold last value for one more cycle
        @(negedge clk);

        $finish;
    end

endmodule