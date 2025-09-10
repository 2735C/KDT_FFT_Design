# 👑TEAM: AI 반도체 설계 2기 4번째 수업 2조


## 🙋‍♂️팀원

|                                                 **최윤석**                                                 |                                                                                                                             **배상원**                                                                                                                              |                                                                        **윤의빈**                                                                        |                                                                                                                             **정은지**                                                                                                                              |
| :--------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                                Team Leader                                                 |                                                                                                                            Team member 1                                                                                                                             |                                                                  Team member 2                                                                   |                                                                                                                         Team member 3                                                                                                                        |
| [<img src="/History/img/profile_1.png" width=150 height=150> </br> @최윤석](https://github.com/stockfail) | [<img src="/History/img/profile_2.jpg" width=150 height=150> </br> @Bae Sangwon](https://github.com/BAESANGWON1) | [<img src="/History/img/profile_3.jpg" width=150 height=150> </br> @윤의빈](https://github.com/demic2da) | [<img src="/History/img/profile_4.jpg" width=150 height=150> </br> @Jung Eunji](https://github.com/2735C) |

## 🖊️Role

### 🐶최윤석
- Team leader
- BFP-based FFT Fixed point modeling
- Butterfly Calculation Module RTL Desgin 
- Gate simulation testbench design & Gate simulation


### 🐧배상원
- BFP-based FFT Fixed point modeling
- Butterfly Calculation Module RTL Desgin 
- Gate simulation & Debugging


### 🐻윤의빈
- BFP-based FFT Fixed point modeling
- Butterfly Calculation Module & Bit reverse RTL Desgin 
- Gate simulation & Debugging
- FPGA targeting



### 🐤정은지 
- BFP-based FFT Fixed point modeling
- CBFP Module RTL Desgin 
- Gate simulation & Debugging
- FPGA targeting


## 🚀프로젝트 개요[[연구 배경]](/History/Progress_report/overview.md)

본 프로젝트에서는 **BFP(Block Floating Point) 기반 Radix-2² 구조의 FFT**를 대상으로 MATLAB 환경에서 Floating 모델을 **Q-format 기반 Fixed-point 모델로 변환**하여 **알고리즘 수준의 사전 검증(High-level verification)** 을 수행하였다. 이어서 CBFP(Combined Block Floating Point) 모델의 Fixed-point 구현을 적용하여 **BFP와 CBFP 알고리즘 간 성능을 비교**하였다.

CBFP 모델을 기반으로 **RTL 설계 및 합성**을 진행하고, 이를 통해 **setup time violation, Area, Latency** 등의 특성을 분석하였다. 마지막으로 **게이트 레벨 시뮬레이션**과 **FPGA Targeting**을 수행하여 RTL 설계의 기능적 타당성을 검증하였다.

## 💻개발 환경 <br>

- **모델링 및 알고리즘 설계**
  - MATLAB (Floating/Fixed-point 모델링 및 High-level verification)

- **시뮬레이션 및 검증**
  - Synopsys VCS (RTL 및 게이트 레벨 논리 시뮬레이션)
  - Synopsys Verdi (파형 분석 및 디버깅)

- **개발 툴 및 편집기**
  - MobaXterm (원격 개발 환경)
  - Visual Studio Code (RTL 및 스크립트 편집)

- **합성 및 게이트 시뮬레이션**
  - Synopsys Design Compiler (합성)
  - Synopsys VCS/Verdi (게이트 레벨 시뮬레이션)

- **FPGA 타겟팅**
  - Xilinx Vivado (Bitstream 생성 및 FPGA 구현)

- **하드웨어 플랫폼**
  - Avnet UltraZed-7EV Carrier Card


## 🗓️개발 일정 [[상세 일정]](/History/Progress_report/schedule.md)

### <개발일정 기재 - Gantt Chart>

|                            |  7/18  |  7/19  |  7/20  |  7/21  |  7/22  |  7/23  |  7/24~7/30  |  7/31~8/3  | 8/4  | 
| :---------------------      | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| BFP 논문 분석                |   O   |   O   |       |       |       |       |       |       |       |       
| BFP base fixed point 설계   |       |   O   |   O   |   O   |       |       |       |       |       |       
| CBFP 논문 분석               |       |       |       |       |   O   |       |       |       |       |       
| CBFP base fixed point 분석  |       |       |       |       |    O  |   O   |       |       |       |      
| CBFP base 8-point RTL 설계  |       |       |       |       |       |       |   O   |       |       |       
| Gate simulation & Debugging|       |       |       |       |       |       |      |   O    |       |       
| FPGA targeting             |       |       |       |       |       |       |       |        |  O    |       
| 발표 자료 제작               |       |       |       |       |       |       |       |     O  |   O   |  



## 🔖개발 과정
> 빠른 요약을 원한다면 --> [[발표 자료]](/History/PPT/Team2_발표자료.pdf)

## (1) Fixed point modeling [[결과 분석]](/History/Progress_report/matlab.md)

### ➤ BFP vs CBFP

|<img src="/History/img/img74.png" width=300>|<img src="/History/img/img75.png" width=300>
--|--

### 📉 기존 기법: BFP (Block Floating Point)

🍬  <u>**FFT 출력 데이터**를 메모리에 저장하기 전에, 그 블록의 최대 진폭을 기준으로 **공통 지수(exponent)** 를 정하고, 해당 지수에 따라 모든 데이터를 **스케일링**.</u>

🍬 **장점:** 지수를 하나만 저장하면 되므로 **메모리 절약 가능**.

🍬 **단점:** 각 스테이지의 모든 연산 결과가 나와야 지수를 정할 수 있으므로 **파이프라인 구조에서는 사용이 불가능**.

## 

### 📈 제안된 기법: CBFP (Convergent Block Floating Point)

#### ➤ 핵심 아이디어:

🍫 **지수를** 한 블록 전체가 아닌 **하위 블록 (N/4, N/16 등)** 에 대해 나눠서 적용.

🍫 **파이프라인 구조와 호환 가능**.

🍫 이전 스테이지의 일부 출력값만으로 다음 스테이지 지수를 결정할 수 있음.

##

#### 📝 참고 문헌

[1] S. He and M. Torkelson, "A new approach to pipeline FFT processor," in Proc. IEEE International Parallel Processing Symposium (IPPS), Honolulu, HI, USA, Apr. 1996, pp. 766–770, doi: 10.1109/IPPS.1996.508098.

[2] Y. W. Lee, J. H. Lee, S. W. Kim, and C. Weems, "A fast single-chip implementation of 8192 complex point FFT," IEEE Journal of Solid-State Circuits, vol. 30, no. 4, pp. 413–422, Apr. 1995, doi: 10.1109/4.364645.

##

### ✳️ 성능 향상

<table style="border-collapse: collapse; border: 3px solid black;" cellpadding="5">
  <!-- SQNR 헤더 -->
  <tr style="height:40px;">
    <th rowspan="3" style="background-color:white;"> </th>
    <th colspan="4" style="background-color:#2e5902; color:white; text-align:center;">SQNR(dB)</th>
  </tr>
  <tr style="height:40px;">
    <th colspan="2" style="background-color:#8fcf6d; text-align:center;">FFT</th>
    <th colspan="2" style="background-color:#8fcf6d; text-align:center;">IFFT</th>
  </tr>
  <tr style="height:40px;">
    <th style="text-align:center;">No CBFP</th>
    <th style="text-align:center;">CBFP</th>
    <th style="text-align:center;">No CBFP</th>
    <th style="text-align:center;">CBFP</th>
  </tr>
  <!-- 데이터 행 -->
  <tr style="height:40px;">
    <td style="text-align:center;"><b>Random</b></td>
    <td style="text-align:center;">26.46 dB</td>
    <td style="text-align:center;">40.84 dB</td>
    <td style="text-align:center;">0.024 dB</td>
    <td style="text-align:center;">44.2 dB</td>
  </tr>
  <tr style="height:40px;">
    <td style="text-align:center;"><b>Cosine</b></td>
    <td style="text-align:center;">41.03 dB</td>
    <td style="text-align:center;">40.83 dB</td>
    <td style="text-align:center;">0.034 dB</td>
    <td style="text-align:center;">41.2 dB</td>
  </tr>
</table>

## (2) RTL Simulation [[코드 분석]](/History/Progress_report/rtl.md)

### 🧐 **사용된 하드웨어 기법**

> ### :one: **파이프라인 구조**  

: FFT의 각 스테이지를 클럭마다 연속적으로 처리 가능

> ### :two: **Cooley-Tukey 구조 최적화**

: Radix-2² 구조 사용

➡️ **Radix-2² FFT**는 **Radix-2의 단순 구조**(덧셈/뺄셈 기반)를 유지하면서, 두 단계의 연산을 묶어 **Radix-4**처럼 4개씩 처리하여 **연산량**을 줄이고 일부 Twiddle factor 곱셈을 단순화하여 하드웨어 효율을 높이는 구조

<img src="/History/img/img77.png" width=600>|<div align = "left">✅BF I: 덧셈/뺄셈 중심 + 단순 Twiddle factor (1, -1) <br> → 곱셈기가 거의 필요 없음 <br><br> ☑️BF II: 덧셈/뺄셈 + 일반 Twiddle factor 곱 <br> → 곱셈기가 필요한 연산만 집중 <br><br> ➡️ 즉, 복잡한 곱셈을 최소화하고, 단순 연산만 따로 처리 가능
--|--

- **BF I와 BF II를 블록 단위로 나누면 HW 효율을 높일 수 있다.**

  - 멀티플라이어 사용량을 줄일 수 있음

  - 연산 파이프라인 설계가 용이

  - 클럭 사이클을 절약 가능

- **디버깅과 검증 용이하다.**

  - BF I / BF II 블록 구분 → 연산 단계를 명확히 확인 가능

  - Fixed-point 변환 후 정확도 확인이 쉬움


🎉 즉, **BF I / BF II 블록 구분** = **연산 단순화 + 하드웨어 최적화 + 병렬화 용이 + 검증 편리성**을 동시에 얻는 구조
<br>

> **BF I Matlab(add/sub)**

```matlab
% M0 step1 
for kk=1:2
  for nn=1:128
    bfly01_tmp((kk-1)*256+nn) = bfly00((kk-1)*256+nn) + bfly00((kk-1)*256+128+nn);
    bfly01_tmp((kk-1)*256+128+nn) = bfly00((kk-1)*256+nn) - bfly00((kk-1)*256+128+nn);
  end
end
```

> **BF I RTL(add/sub)**

```systemverilog
// M0 step1 
if((step1_shift_type == 1) && step1_add_sub_en) begin
    for(j = 0; j < 16; j++) begin
        add_step01_re_pp_np[j] <= sr128_re_out[j] + bfly00_re_p[j];
        sub_step01_re_pn_nn[j] <= sr128_re_out[j] - bfly00_re_p[j];
        add_step01_im_pp_np[j] <= sr128_im_out[j] + bfly00_im_p[j];
        sub_step01_im_pn_nn[j] <= sr128_im_out[j] - bfly00_im_p[j];
    end
end else if ((step1_shift_type == 3) && step1_add_sub_en) begin
    for (j = 0; j < 16; j++) begin
        add_step01_re_pp_np[j] <= sr128_re_out[j] + sr256_re_out[j];
        sub_step01_re_pn_nn[j] <= sr128_re_out[j] - sr256_re_out[j];
        add_step01_im_pp_np[j] <= sr128_im_out[j] + sr256_im_out[j];
        sub_step01_im_pn_nn[j] <= sr128_im_out[j] - sr256_im_out[j];
    end                
end
```

- Radix-2 단계 2개를 한 블록에서 연속 계산
- 즉, 덧셈/뺄셈을 한 블록 안에서 한 번에 처리함으로써 stage가 줄고, 일부 twiddle factor는 단순 곱셈으로 처리 가능 → 하드웨어 효율 ↑ 

> **BF II Matlab(multiplication)** 

```matlab
% M0 step1 
 fac8_2 = [1, 1, 1, -j, 1, 0.7071-0.7071j, 1, -0.7071-0.7071j]; % floating 
 fac8_1 = round(fac8_2 * 256); % fixed <2.8>

 for nn=1:512
	temp_bfly01(nn) = bfly01_tmp(nn)*fac8_1(ceil(nn/64));  %INPUT <5.6> X <2.8> -> OUTPUT <7.14>
	bfly01(nn) = round(temp_bfly01(nn)/256); % <7.6>
 end
```

| nn 범위           | 1\~64 | 65\~128 | 129\~192 | 193\~256 | 257\~320 | 321\~384       | 385\~448 | 449\~512        |
| ---------------- | ----- | ------- | -------- | -------- | -------- | -------------- | -------- | --------------- |
| ceil(nn/64)      | 1     | 2       | 3        | 4        | 5        | 6              | 7        | 8               |
| factor (fac8\_1) | 1     | 1       | 1        | -j       | 1        | 0.7071-0.7071j | 1        | -0.7071-0.7071j |



> **BF II RTL(multiplication)**

```systemverilog
// M0 step1 
if(step1_mul_en) begin // twf factor multiply <5.6> * <1.8> = <6.14>
  index_cnt <= index_cnt + 1;
  if(index_cnt < 4) begin
      for(j = 0; j < 16; j++) begin
          bfly01_re_p[j] <= ((add_step01_re_pp_np[j] <<< 8) + 128) >>> 8;
          bfly01_re_n[j] <= ((sub_step01_re_pn_nn[j] <<< 8) + 128) >>> 8;
          bfly01_im_p[j] <= ((add_step01_im_pp_np[j] <<< 8) + 128) >>> 8;
          bfly01_im_n[j] <= ((sub_step01_im_pn_nn[j] <<< 8) + 128) >>> 8;
      end
  end else if(index_cnt < 8) begin
      for(j = 0; j < 16; j++) begin
          bfly01_re_p[j] <= ((add_step01_re_pp_np[j] <<< 8) + 128) >>> 8;
          bfly01_re_n[j] <= ((sub_step01_im_pn_nn[j] <<< 8) + 128) >>> 8;
          bfly01_im_p[j] <= ((add_step01_im_pp_np[j] <<< 8) + 128) >>> 8;
          bfly01_im_n[j] <= (-(sub_step01_re_pn_nn[j] <<< 8) + 128) >>> 8;
      end
  end else if(index_cnt < 12) begin
      for(j = 0; j < 16; j++) begin
          bfly01_re_p[j] <= ((add_step01_re_pp_np[j] <<< 8) + 128) >>> 8;
          bfly01_re_n[j] <= ((sub_step01_re_pn_nn[j] <<< 8) + 128) >>> 8;
          bfly01_im_p[j] <= ((add_step01_im_pp_np[j] <<< 8) + 128) >>> 8;
          bfly01_im_n[j] <= ((sub_step01_im_pn_nn[j] <<< 8) + 128) >>> 8;
      end
  end else if(index_cnt < 16) begin
      for(j = 0; j < 16; j++) begin
          bfly01_re_p[j] <= (mul181(add_step01_re_pp_np[j]) + mul181(add_step01_im_pp_np[j]) + 128) >>> 8;
          bfly01_re_n[j] <= (mul_neg181(sub_step01_re_pn_nn[j]) + mul181(sub_step01_im_pn_nn[j]) + 128) >>> 8;
          bfly01_im_p[j] <= (mul181(add_step01_im_pp_np[j]) - mul181(add_step01_re_pp_np[j]) + 128) >>> 8;
          bfly01_im_n[j] <= (mul_neg181(sub_step01_im_pn_nn[j]) - mul181(sub_step01_re_pn_nn[j]) + 128) >>> 8;
      end
  end
end
```

- BF II 연산을 index_cnt 기준 블록화 → 곱셈 최적화

- re_p/im_p, re_n/im_n 블록 구분 → 병렬화 용이



| nn 범위         | 1\~64                      | 65\~128                    | 129\~192                   | 193\~256                   | 257\~320                   | 321\~384                   | 385\~448                   | 449\~512                   |
| ------------- | -------------------------- | -------------------------- | -------------------------- | -------------------------- | -------------------------- | -------------------------- | -------------------------- | -------------------------- |
| **index\_cnt 범위** | 0\~3                       | 4\~7                       | 0\~3                       | 4\~7                       | 8\~11                      | 12\~15                     | 8\~11                      | 12\~15                     |
| **데이터 <br>그룹**    | re\_p\[0:63], im\_p\[0:63] | re\_p\[0:63], im\_p\[0:63] | re\_n\[0:63], im\_n\[0:63] | re\_n\[0:63], im\_n\[0:63] | re\_p\[0:63], im\_p\[0:63] | re\_p\[0:63], im\_p\[0:63] | re\_n\[0:63], im\_n\[0:63] | re\_n\[0:63], im\_n\[0:63] |



|<img src="/History/img/img86.png" width=1000>|
|--|


> ### :three: **고정 소수점 사용**  

: 부동소수점 대비 면적/전력 절감 + Precision trade-off 가능

➡️ **BFP**는 블록 단위로 **공통 스케일**을 사용하는 반면, **CBFP**는 **블록** 내 작은 값들의 여유 비트를 활용해 **Q-format을 조정**함으로써 **라운딩 오차를 줄이고 정밀도 향상**이 가능

> **CBFP Matlab(일부)**

```matlab
% M0 CBFP
for ii=1:8
  for jj=1:64
	tmp1_re = mag_detect(real(pre_bfly02(64*(ii-1)+jj)), 23);
	tmp1_im = mag_detect(imag(pre_bfly02(64*(ii-1)+jj)), 23);
```

* mag_detect: Twiddle factor 곱 이후의 복소수 FFT 결과를 이진수로 변환해 각 데이터가 MSB부터 부호 비트(0 or 1)가 얼마나 연속되는지 계산
* 정규화 오버플로우 가능성을 고려해 CBFP 연산 직전에 부호 비트 추가

```matlab
% MO CBFP
	temp1_re = min_detect(jj, tmp1_re, cnt1_re(ii));
	temp1_im = min_detect(jj, tmp1_im, cnt1_im(ii));
```
* min_detect: 64개의 데이터 중 mag_detect 결과가 가장 작은 값 선택
* 각 블록(64개 단위)마다 최대한 안전하게 Shift 할 수 있는 폭을 계산해, 해당 비트 수만큼 전부 정규화(bit shift)한다.

> **CBFP RTL(일부)**


```systemverilog
// M0 CBFP 
always_comb begin
    lzc_re = count_min_lzc_23bit(din_re);
    lzc_im = count_min_lzc_23bit(din_im);
end
always_ff @( posedge clk or negedge rstn ) begin
    if (!rstn) begin
        for (int i = 0; i < array_num; i=i+1) begin
            cal_cnt[i] <= '0;
        end
    end else if (valid_in) begin
        for (int i = array_num - 1; i > 0; i=i-1) begin
            cal_cnt[i] <= cal_cnt[i-1];
        end 
        
        cal_cnt[0] <= (lzc_re > lzc_im) ? lzc_im : lzc_re;
    end else begin
        for (int i = 0; i < array_num; i=i+1) begin
            cal_cnt[i] <= cal_cnt[i];
        end
    end
end
```

* **count_min_lzc_23bit** 함수로 16개 데이터의 **mag_detect를 계산**하며 **실시간**으로 **최솟값**을 구함 <br>→ 연산 모듈 완료 후 다음 clk에서의 비교 대상 데이터를 **64개에서 4개로** 줄여 Timing Margin 확보 <br>→ 비교 연산 모듈의 재활용 :arrow_right: 면적 감소 및 자원 절약

|<img src="/History/img/img101.png" width=1000>|
|--|


> ### :four: **LUT 사용**  

: twiddle factor를 ROM에 미리 저장하여 곱셈 비용 절감

### 😎 RTL Simulation

### ✅ Cosine_Input

|<img src="/History/img/img88.png" width=1000>|
|--|

#### ➡️ [Matlab] First 32 Input Data Points


| Real | 63 | 64 | 64 | 64 | 64 | 64 | 64 | 64 | 64 | 64 | 64 | 63 | 63 | 63 | 63 | 63 | 63 | 63 | 62 | 62 | 62 | 62 | 62 | 61 | 61 | 61 | 61 | 61 | 60 | 60 | 60 | 59 | ··· |
|------|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
| **IMG** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **···** |


|<img src="/History/img/img89.png" width=1000>|
|--|

#### ➡️[Matlab] Last 32 Input Data Points


| Real | ··· | 59 | 59 | 60 | 60 | 60 | 61 | 61 | 61 | 61 | 61 | 62 | 62 | 62 | 62 | 62 | 63 | 63 | 63 | 63 | 63 | 63 | 63 | 64 | 64 | 64 | 64 | 64 | 64 | 64 | 64 | 64 | 64 |
|------|-----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
| **IMG** | **···** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** |



### ✅ Cosine_Output

|<img src="/History/img/img90.png" width=1000>|
|--|

#### ➡️[Matlab] First 32 Output Data Points

| Real | -1 | 4091 | -1 | 2 | -1 | 2 | -1 | -3 | -1 | -4 | -1 | -1 | -1 | 3 | -1 | 3 | -1 | -1 | -1 | -1 | -1 | -2 | -1 | 2 | -1 | -1 | -1 | -4 | -1 | -1 | -1 | 0 | ··· |
|------|----|------|----|---|----|---|----|----|----|----|----|----|----|---|----|---|----|----|----|----|----|----|----|---|----|---|----|----|----|----|----|----|----|
| **IMG** | **0** | **-6** | **0** | **-1** | **0** | **-1** | **0** | **-4** | **0** | **0** | **0** | **-1** | **0** | **-1** | **0** | **1** | **0** | **0** | **0** | **-1** | **0** | **-1** | **0** | **-1** | **0** | **0** | **0** | **-1** | **0** | **0** | **0** | **0** | ··· |



|<img src="/History/img/img91.png" width=1000>|
|--|

#### ➡️ [Matlab] Last 32 Output Data Points


| Real | ··· | -1 | 1 | -1 | -1 | -1 | -4 | -1 | -1 | -1 | -1 | -1 | -2 | -1 | -1 | -1 | -1 | -1 | 3 | -1 | 3 | -1 | -1 | -1 | -5 | -1 | 2 | -1 | 2 | -1 | 2 | -1 | 4091 |
|------|-----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|---|----|---|----|---|----|----|----|----|----|----|----|----|----|----|------|
| **Imag** |  **···** | **0** | **1** | **0** | **-1** | **0** | **0** | **0** | **-2** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **-1** | **0** | **-1** | **0** | **0** | **0** | **0** | **0** | **2** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** |



🎉 Matlab을 통해 예측한 결과와 같음을 확인할 수 있다.  <br>
☑️ FPGA와 연결하기 위해 Cosine Input을 8clk 쉬고 다시 반복하도록 설계하여 출력이 진행될 때도 Input Data가 입력되는 것을 확인할 수 있다.

## (3) Synthesis

|Setup_time| Area|
--|--|
|<div align = "middle"> 0.14 ps|<div align = "middle"> 187768.2|


Timing_max| Area
--|--
|<img src="/History/img/img70.png" width=400>| <img src="/History/img/img72.png" width=400>|

> Hold time은 Layout 단계에서 충분히 해결 가능하므로 front-end 과정에서는 Setup time과 Area 최적화에 집중하였다.

## (4) Gate Simulation [[결과 분석]](/History/Progress_report/gate.md)

### 🔍 TestBench: Vectorization / Flattening

```systemverilog
logic signed [0:143] din_re;
logic signed [0:143] din_im;
logic [0:207] dout_re;  
logic [0:207] dout_im;
```

#### 🤔 다차원 배열을 1차원 벡터로 변환하는 것의 필요성

:one: **게이트 시뮬레이션에서 배열 제한:** 
- 일부 EDA 툴이나 합성된 netlist는 배열을 직접 시뮬레이션할 수 없음.
 
:two: **배선 단순화:** 
- 모든 요소를 하나의 연속된 vector로 바꾸면, 모듈 간 연결이 간단해짐.

:three: **자동화 가능:** 
- Testbench에서 반복문으로 배열을 채우던 로직을 벡터 슬라이스로 처리 가능.


```systemverilog
logic signed [8:0] din_re_arr [0:15];
logic signed [8:0] din_im_arr [0:15];
logic signed [12:0] dout_re_arr [0:15];
logic signed [12:0] dout_im_arr [0:15];
```

- 사용자의 편의를 위해 RTL 배열를 추가하여 Waveform에서의 가독성을 높였다.

##

### 😎 Gate Simulation

### ☑️ Latency: 89clk

|<img src="/History/img/img92.png" width=600>|
|--|

|Input: 32 clk(32 x 16 = 512 points)  |Output: 32 clk(32 x 16 = 512 points) |
|--|--|
|<img src="/History/img/img93.png" width=500>|<img src="/History/img/img94.png" width=500>|


### ✅ Cosine_Input

|<img src="/History/img/img95.png" width=1000>|
|--|

#### ➡️ [Matlab] First 32 Input Data Points


| Real | 63 | 64 | 64 | 64 | 64 | 64 | 64 | 64 | 64 | 64 | 64 | 63 | 63 | 63 | 63 | 63 | 63 | 63 | 62 | 62 | 62 | 62 | 62 | 61 | 61 | 61 | 61 | 61 | 60 | 60 | 60 | 59 | ··· |
|------|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
| **IMG** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **···** |


|<img src="/History/img/img96.png" width=1000>|
|--|

#### ➡️[Matlab] Last 32 Input Data Points


| Real | ··· | 59 | 59 | 60 | 60 | 60 | 61 | 61 | 61 | 61 | 61 | 62 | 62 | 62 | 62 | 62 | 63 | 63 | 63 | 63 | 63 | 63 | 63 | 64 | 64 | 64 | 64 | 64 | 64 | 64 | 64 | 64 | 64 |
|------|-----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
| **IMG** | **···** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** |



### ✅ Cosine_Output

|<img src="/History/img/img97.png" width=1000>|
|--|

#### ➡️[Matlab] First 32 Output Data Points

| Real | -1 | 4091 | -1 | 2 | -1 | 2 | -1 | -3 | -1 | -4 | -1 | -1 | -1 | 3 | -1 | 3 | -1 | -1 | -1 | -1 | -1 | -2 | -1 | 2 | -1 | -1 | -1 | -4 | -1 | -1 | -1 | 0 | ··· |
|------|----|------|----|---|----|---|----|----|----|----|----|----|----|---|----|---|----|----|----|----|----|----|----|---|----|---|----|----|----|----|----|----|----|
| **IMG** | **0** | **-6** | **0** | **-1** | **0** | **-1** | **0** | **-4** | **0** | **0** | **0** | **-1** | **0** | **-1** | **0** | **1** | **0** | **0** | **0** | **-1** | **0** | **-1** | **0** | **-1** | **0** | **0** | **0** | **-1** | **0** | **0** | **0** | **0** | ··· |



|<img src="/History/img/img98.png" width=1000>|
|--|

#### ➡️ [Matlab] Last 32 Output Data Points


| Real | ··· | -1 | 1 | -1 | -1 | -1 | -4 | -1 | -1 | -1 | -1 | -1 | -2 | -1 | -1 | -1 | -1 | -1 | 3 | -1 | 3 | -1 | -1 | -1 | -5 | -1 | 2 | -1 | 2 | -1 | 2 | -1 | 4091 |
|------|-----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|---|----|---|----|---|----|----|----|----|----|----|----|----|----|----|------|
| **Imag** |  **···** | **0** | **1** | **0** | **-1** | **0** | **0** | **0** | **-2** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **-1** | **0** | **-1** | **0** | **0** | **0** | **0** | **0** | **2** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** |


## (5) FPGA Targeting [[결과 분석]](/History/Progress_report/fpga.md)

|LUT|Setup-time|Latency|power
--|--|--|--|
|<div align = "middle">65538 (30%)| <div align = "middle"> 0.576 ns|<div align = "middle"> 89 clk|<div align = "middle"> 1.74 W|

<img src="/History/img/img79.png" width=400> |<img src="/History/img/img84.png" width=400> |
--|--

<img src="/History/img/img80.png" width=400> |<img src="/History/img/img82.png" width=200>|<img src="/History/img/img83.png" width=200>|
--|--|--


- LUT 30% 사용 -> Combinational Logic ↑
- FF, DSP 약 10% -> 적정 Pipelining, Multiplier
- Setup Time & Hold Time Slack MET 

## 진행 결과

<table border="1" cellspacing="0" cellpadding="5">
  <thead>
    <tr>
      <th>구분</th>
      <th>검증 항목</th>
      <th>검증 요소</th>
      <th>완료 여부</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan="3">ASIC (500MHz)</td>
      <td>RTL Simulation</td>
      <td>Cosine, Random Fixed Data</td>
      <td align="center">○</td>
    </tr>
    <tr>
      <td>Synthesis</td>
      <td>Setup Violation, Area</td>
      <td align="center">○</td>
    </tr>
    <tr>
      <td>Gate Simulation</td>
      <td>Cosine, Random Fixed Data</td>
      <td align="center">○</td>
    </tr>
    <tr>
      <td rowspan="3">FPGA (100MHz)</td>
      <td>FPGA top Block</td>
      <td>Cosine generator, FFT, VIO</td>
      <td align="center">○</td>
    </tr>
    <tr>
      <td>RTL Simulation</td>
      <td>Cosine Fixed Data</td>
      <td align="center">○</td>
    </tr>
    <tr>
      <td>Synthesis & Implementation</td>
      <td>Setup Violation, Utilization, Bitstream</td>
      <td align="center">○</td>
    </tr>
  </tbody>
</table>


## 🚀Trouble Shooting 
[⚒️[Timing Miss Match Trouble]](/History/trouble_shooting/Trouble_Shooting1.md)   <br>
[⚒️[Random Input Trouble]](/History/trouble_shooting/Trouble_Shooting2.md)  <br>
[⚒️[Clock-gate Latch]](/History/trouble_shooting/Trouble_Shooting3.md) <br>
[⚒️[Indexsum Problem]](/History/trouble_shooting/Trouble_Shooting4.md) <br>
[⚒️[Vivado Synthesis Error]](/History/trouble_shooting/Trouble_Shooting5.md)       <br>
[⚒️[GateSim Trouble]](/History/trouble_shooting/Trouble_Shooting6.md)       <br>
[⚒️[FPGA SetUp Trouble]](/History/trouble_shooting/Trouble_Shooting7.md)      <br>
[⚒️[더 작성할 내용 있으면 추가]](/History/trouble_shooting/Trouble_Shooting8.md)      <br>

