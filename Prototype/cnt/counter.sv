`timescale 1ns/1ps

module num_counter #(
    parameter NUM = 16
)(
    input clk,
    input rst,
    input valid,
    output logic [1:0] bfly_enable  // 2비트 출력
);

    logic [$clog2(NUM) - 1:0] cnt;
    logic [1:0] bfly_state;

    always_ff @(posedge clk or negedge rst) begin
        if (~rst) begin
            cnt <= 0;
            bfly_enable <= 0;
            bfly_state <= 0;
        end else if (valid) begin
            if (cnt == NUM - 1) begin
                cnt <= 0;
                bfly_state <= bfly_state + 1;  // 0→1→2→3→0...
                bfly_enable <= bfly_state + 1;
            end else begin
                cnt <= cnt + 1;
            end
        end
    end
endmodule
