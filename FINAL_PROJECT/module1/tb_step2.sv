`timescale 1ns/1ps

module tb_step1_2;

    // 파라미터 정의
    parameter CLK_PERIOD      = 10;  // 클럭 주기 (10ns)
    parameter DATA_CHUNK_SIZE = 16;  // 한 번에 처리하는 데이터 개수
    parameter TOTAL_DATA_SIZE = 512; // 전체 데이터 개수
    parameter CYCLE_COUNT     = TOTAL_DATA_SIZE / DATA_CHUNK_SIZE; // 총 사이클 수 (32)

    // 테스트벤치 신호 선언
    logic                       clk;
    logic                       rst;
    logic                       valid;
    // signed 키워드 위치를 다시 변경: logic signed [비트폭] [배열크기]
    logic signed [14:0]         bfly01_re_p [0:DATA_CHUNK_SIZE-1];
    logic signed [14:0]         bfly01_re_n [0:DATA_CHUNK_SIZE-1];
    logic signed [14:0]         bfly01_im_p [0:DATA_CHUNK_SIZE-1];
    logic signed [14:0]         bfly01_im_n [0:DATA_CHUNK_SIZE-1];

    logic signed [24:0]         bfly12_re [0:DATA_CHUNK_SIZE-1];
    logic signed [24:0]         bfly12_im [0:DATA_CHUNK_SIZE-1];
    logic cbfp_valid;
    // 입력 데이터를 저장할 메모리 선언
    logic signed [14:0] mem_re [0:TOTAL_DATA_SIZE-1];
    logic signed [14:0] mem_im [0:TOTAL_DATA_SIZE-1];

    // DUT (Device Under Test) 인스턴스화
    step1_2 dut (
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .bfly01_re_p(bfly01_re_p),
        .bfly01_re_n(bfly01_re_n),
        .bfly01_im_p(bfly01_im_p),
        .bfly01_im_n(bfly01_im_n),
        .bfly12_re(bfly12_re),
        .bfly12_im(bfly12_im),
	.cbfp_valid(cbfp_valid)
    );

    // 1. 클럭 생성
    always #((CLK_PERIOD)/2) clk = ~clk;

    // 2. 메인 테스트 시나리오
    initial begin
        integer file_re, file_im;
        string line;
        int value;
        integer data_read_idx; // 현재 읽을 데이터의 시작 인덱스

        // 2.1. 파일에서 데이터 읽기 (10진수 signed 값)
        // $fopen, $fgets, $sscanf를 사용하여 10진수 signed 값을 읽습니다.
        file_re = $fopen("step12_in_re.txt", "r");
        file_im = $fopen("step12_in_im.txt", "r");

        if (file_re == 0 || file_im == 0) begin
            $error("Error: Could not open input files.");
            $finish;
        end

        for (integer i = 0; i < TOTAL_DATA_SIZE; i++) begin
            if (!$fgets(line, file_re)) begin
                $error("Error: Not enough data in step12_in_re.txt at index %0d", i);
                $finish;
            end
            if ($sscanf(line, "%d", value) == 1) begin
                mem_re[i] = value;
            end else begin
                $error("Error: Failed to parse decimal value from step12_in_re.txt at index %0d", i);
                $finish;
            end

            if (!$fgets(line, file_im)) begin
                $error("Error: Not enough data in step12_in_im.txt at index %0d", i);
                $finish;
            end
            if ($sscanf(line, "%d", value) == 1) begin
                mem_im[i] = value;
            end else begin
                $error("Error: Failed to parse decimal value from step12_in_im.txt at index %0d", i);
                $finish;
            end
        end

        $fclose(file_re);
        $fclose(file_im);
        $display("Input data loaded successfully from decimal files.");

        // 2.2. 초기화 및 리셋
        clk <= 0;
        rst <= 0; // Active-low reset
        valid <= 0;
        for (integer i = 0; i < DATA_CHUNK_SIZE; i++) begin
            bfly01_re_p[i] <= 0;
            bfly01_re_n[i] <= 0;
            bfly01_im_p[i] <= 0;
            bfly01_im_n[i] <= 0;
        end
        # (CLK_PERIOD * 2);
        rst <= 1; // 리셋 해제
        # (CLK_PERIOD);

        // 2.3. 데이터 주입 및 valid 신호 제어
        // 총 32 사이클 동안 데이터 주입 (valid는 16번 High)
        data_read_idx = 0; // 데이터 메모리에서 읽을 시작 인덱스
        for (integer i = 0; i < CYCLE_COUNT; i++) begin
            @(posedge clk);
            valid <= ~valid; // 매 클럭마다 valid 신호 토글

            if (~valid) begin // valid가 1일 때만 데이터 주입
                // _p와 _n 포트에 동시에 데이터 주입
                for (integer j = 0; j < DATA_CHUNK_SIZE; j++) begin
                    bfly01_re_p[j] <= mem_re[data_read_idx + j];
                    bfly01_im_p[j] <= mem_im[data_read_idx + j];
                    bfly01_re_n[j] <= mem_re[data_read_idx + DATA_CHUNK_SIZE + j];
                    bfly01_im_n[j] <= mem_im[data_read_idx + DATA_CHUNK_SIZE + j];
                end
                $display("Cycle %0d (Valid=1): Loading data into re_p, im_p, re_n, im_n from index %0d", i, data_read_idx);
                data_read_idx = data_read_idx + (2 * DATA_CHUNK_SIZE); // 다음 valid 사이클을 위해 인덱스 업데이트
            end else begin
                $display("Cycle %0d (Valid=0): Holding inputs.", i);
            end
        end

        // 2.4. 시뮬레이션 종료
        @(posedge clk);
        valid <= 0; // 데이터 주입 완료 후 valid를 0으로 유지
        # (CLK_PERIOD * 10);
        $display("Test finished.");
        $finish;
    end

endmodule

