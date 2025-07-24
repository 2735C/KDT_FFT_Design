`timescale 1ns/1ps

module num_counter #(
    parameter NUM = 16
)  (
    input clk,
    input rst,
    input valid,
    output logic bfly_enable
);

    logic [$clog2(NUM) - 1:0] cnt;

    always @(posedge clk or negedge rst) begin
        if(~rst) begin
            cnt <= 0;
            bfly_enable <= 0;
        end else if (valid) begin
            if(cnt == NUM - 1) begin
                cnt <= 0;
                bfly_enable <= 1;
            end else begin
                cnt <= cnt + 1;
            end
        end
    end
endmodule
