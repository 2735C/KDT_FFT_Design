`timescale 1ns/1ps

module tb_top ();

    logic clk, rst, valid;
    logic step11_cnt_valid;
    logic step12_cnt_valid;
    logic signed [10:0] din_re [0:15];
    logic signed [10:0] din_im [0:15];

    logic signed [11:0] bfly10_re_p [0:15];
    logic signed [11:0] bfly10_re_n [0:15];
    logic signed [11:0] bfly10_im_p [0:15];
    logic signed [11:0] bfly10_im_n [0:15];

    logic signed [14:0] bfly11_re_p [0:15];
    logic signed [14:0] bfly11_re_n [0:15];
    logic signed [14:0] bfly11_im_p [0:15];
    logic signed [14:0] bfly11_im_n [0:15];
    
    /*logic signed [22:0] bfly02_re_p [0:15];
    logic signed [22:0] bfly02_re_n [0:15];
    logic signed [22:0] bfly02_im_p [0:15];
    logic signed [22:0] bfly02_im_n [0:15];*/

    // 내부 변수
    integer fd_re, fd_im;
    string line_re, line_im;
    integer val_re, val_im;
    integer i, j;


    step1_0 dut_00(
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .din_re(din_re),
        .din_im(din_im),
        .bfly10_re_p(bfly10_re_p),
        .bfly10_re_n(bfly10_re_n),
        .bfly10_im_p(bfly10_im_p),
        .bfly10_im_n(bfly10_im_n),
        .bfly10_mul_enable(step11_cnt_valid)
    );

    step1_1 dut_01(
        .clk(clk),
        .rst(rst),
        .valid(step11_cnt_valid),
        .bfly10_re_p(bfly10_re_p),
        .bfly10_re_n(bfly10_re_n),
        .bfly10_im_p(bfly10_im_p),
        .bfly10_im_n(bfly10_im_n),
        .bfly11_re_p(bfly11_re_p), // output <7.6>
        .bfly11_re_n(bfly11_re_n),
        .bfly11_im_p(bfly11_im_p),
        .bfly11_im_n(bfly11_im_n),
        .step1_mul_en(step12_cnt_valid)
    );
/*
    step0_2 dut_02(
        .clk(clk),
        .rst(rst),
        .valid(step02_cnt_valid),
        .bfly01_re_p(bfly01_re_p),
        .bfly01_re_n(bfly01_re_n),
        .bfly01_im_p(bfly01_im_p),
        .bfly01_im_n(bfly01_im_n),
        .bfly02_re_p(bfly02_re_p), // output <7.6>
        .bfly02_re_n(bfly02_re_n),
        .bfly02_im_p(bfly02_im_p),
        .bfly02_im_n(bfly02_im_n)
    );
*/
    // Clock generation (500MHz => 2ns period)
    always #1 clk = ~clk;

    always @(negedge clk) begin
        if (valid) begin
            for (i = 0; i < 16; i++) begin
                if (!$feof(fd_re)) begin
                    void'($fgets(line_re, fd_re));
                    void'($sscanf(line_re, "%d", val_re));
                    din_re[i] = val_re;
                end else din_re[i] = 0;

                if (!$feof(fd_im)) begin
                    void'($fgets(line_im, fd_im));
                    void'($sscanf(line_im, "%d", val_im));
                    din_im[i] = val_im;
                end else din_im[i] = 0;
            end
        end
    end

    initial begin
        clk = 0;
        rst = 1;
        valid = 0;
        for (i = 0; i < 16; i++) begin
            din_re[i] = 0;
            din_im[i] = 0;
        end

        // 파일 열기
        fd_re = $fopen("module1_in_re.txt", "r");
        fd_im = $fopen("module1_in_im.txt", "r");
        if (fd_re == 0 || fd_im == 0) $fatal("파일 열기 실패.");

        // 초기화 및 reset
        #5 rst = 0;
        #5 rst = 1;
        valid = 1;
        repeat (33) @(negedge clk);
        valid = 0;
    

        // 연산 마무리 대기
        #500;

        $display("Simulation finished.");
        $finish;
    end

endmodule
