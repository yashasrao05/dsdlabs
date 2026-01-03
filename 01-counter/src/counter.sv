    /**
    * updown_counter:
    * A simple up/down counter with load functionality.
    *
    * Features:
    * - 4-bit counter
    * - Asynchronous reset
    * - Load functionality: on load signal, the counter loads the input value
    * - Up/Down counting: controlled by the up_down signal (1 for up, 0 for down)
    * - Enable signal to control counting: when enabled, the counter counts; when disabled, it holds its value
    */

    `timescale 1ns / 1ps

    module updown_counter(
        input logic clk,       // Clock input
        input logic rst_n,     // Active-low reset
        input logic load,      // Load enable
        input logic up_down,   // Direction control (1 = up, 0 = down)
        input logic enable,    // Counter enable
        input logic [3:0] d_in,// Input data for loading
        output logic [3:0] count // Counter output
    );

        // Counter logic
        always_ff @(posedge clk or negedge rst_n) begin
            
            // Asynchronous reset (active LOW)
            if (!rst_n)
                count <= 4'b0000;

            // Load value when load = 1
            else if (load)
                count <= d_in;

            // Count only when enable = 1
            else if (enable) begin
                if (up_down)
                    count <= count + 1;   // Count up
                else
                    count <= count - 1;   // Count down
            end
            
            // Else: hold value
        end
    endmodule
