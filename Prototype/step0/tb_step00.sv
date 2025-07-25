`timescale 1ns/1ps

module tb_step0_0;

    logic clk;
    logic rst;
    logic valid;
    logic signed [8:0] din_re [0:15];
    logic signed [8:0] din_im [0:15];
    logic signed [9:0] bfly00_re_p [0:15][0:15];
    logic signed [9:0] bfly00_re_n [0:15][0:15];
    logic signed [9:0] bfly00_im_p [0:15][0:15];
    logic signed [9:0] bfly00_im_n [0:15][0:15];

    integer fd_re, fd_im, fd_out;
    string line_re, line_im;
    integer val_re, val_im;
    integer i, j;

    // DUT instance
    step0_0 uut (
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .din_re(din_re),
        .din_im(din_im),
        .bfly00_re_p(bfly00_re_p),
        .bfly00_re_n(bfly00_re_n),
        .bfly00_im_p(bfly00_im_p),
        .bfly00_im_n(bfly00_im_n)
    );

    // Clock generation: 100MHz -> 10ns period
    always #5 clk = ~clk;

    initial begin
        // 초기화
        clk = 0;
        rst = 1;
        valid = 0;
        for (i = 0; i < 16; i++) begin
            din_re[i] = 0;
            din_im[i] = 0;
        end

        // 입력 파일 열기
        fd_re = $fopen("cos_i_dat.txt", "r");
        fd_im = $fopen("cos_q_dat.txt", "r");
        if (fd_re == 0 || fd_im == 0) $fatal("Failed to open input files.");

        // 출력 파일 열기
        fd_out = $fopen("output_step0.txt", "w");
        if (fd_out == 0) $fatal("Failed to open output file.");

        // 리셋
        #20; rst = 0;
        #20; rst = 1;

        // 입력 32클럭 적용
        valid = 1;
        repeat (32) begin
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
            #10;
        end
        valid = 0;

        // 모든 내부 연산이 완료될 때까지 기다림 (예: 200클럭)
        #50;

        // 연산이 끝난 후 결과 저장 (총 16x16 = 256개 p/n 각각)
        for (i = 0; i < 16; i++) begin
            for (j = 0; j < 16; j++) begin
                int idx_p = i * 16 + j;
                $fdisplay(fd_out, "%0d\t%0d\t%0d", idx_p, bfly00_re_p[i][j], bfly00_im_p[i][j]);
            end
        end
        for (i = 0; i < 16; i++) begin
            for (j = 0; j < 16; j++) begin
                int idx_n = 256 + i * 16 + j;
                $fdisplay(fd_out, "%0d\t%0d\t%0d", idx_n, bfly00_re_n[i][j], bfly00_im_n[i][j]);
            end
        end

        // 종료
        $fclose(fd_re);
        $fclose(fd_im);
        $fclose(fd_out);
        $finish;
    end

endmodule
