`timescale 1ns/1ps

module test_cbfp #(
    parameter array_size = 16,
    parameter array_num = 4,
    parameter din_size  = 23,
    parameter dout_size = 11,
    parameter buffer_depth  = 64

) (
    input logic clk,
    input logic rstn,
    input logic valid_in,

    input logic signed [din_size-1:0] din_re_p [0:array_size-1],

    output logic signed[din_size-1:0] dout_re_p [0:array_size-1],

    output logic [23-1:0] zero_cnt [0:array_num-1]      
);

    logic signed  [din_size-1:0] d_semi_re_p [0:array_size-1];
    logic valid_out;


cbfp_sr #(
    .array_size(16),
    .din_size(23),
    .buffer_depth(64), 
    .clk_cnt(3) 
) sample_sr (
    .clk(clk),
    .rstn(rstn),
    .valid_in(valid_in),

    .din(din_re_p),
    .dout(dout_re_p),
    .valid_out(valid_out)
);


fft_cbfp_cal_zero #(
    .array_size (16),
    .array_num (4),
    .din_size (23),
    .dout_size (11),
    .buffer_depth (64)

) sample_cal (
    .clk(clk),
    .rstn(rstn),
    .valid_in(valid_in),

    .din_re_p(din_re_p),    
    .cal_cnt (zero_cnt)
);




endmodule


