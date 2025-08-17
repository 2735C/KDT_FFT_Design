# 👑TEAM: AI 반도체 설계 2기 4번째 수업 2조


## 🙋‍♂️팀원

|                                                 **최윤석**                                                 |                                                                                                                             **배상원**                                                                                                                              |                                                                        **윤의빈**                                                                        |                                                                                                                             **정은지**                                                                                                                              |
| :--------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                                Team Leader                                                 |                                                                                                                            Team member 1                                                                                                                             |                                                                  Team member 2                                                                   |                                                                                                                         Team member 3                                                                                                                        |
| [<img src="/History/img/profile_1.jpg" width=150 height=150> </br> @최윤석](https://github.com/stockfail) | [<img src="/History/img/profile_2.png" width=150 height=150> </br> @Bae SANGWON](https://github.com/BAESANGWON1) | [<img src="/History/img/profile_3.png" width=150 height=150> </br> @윤의빈](https://github.com/demic2da) | [<img src="/History/img/profile_4.jpg" width=150 height=150> </br> @Eunji Jung](https://github.com/2735C) |

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

## 💻 개발 환경 <br>

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



## 개발 과정
> 빠른 요약을 원한다면 --> [[발표 자료]](/History/PPT/Team2_발표자료.pdf)

## (1) Fixed point modeling [[결과 분석]](/History/Progress_report/matlab.md)

### ➤ BFP vs CBFP

|<img src="/History/img/img74.png" width=350>|<img src="/History/img/img75.png" width=350>
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

### ✳️ 성능 향상

<img src="/History/img/img76.png" width=650>|
--|



## (2) RTL Simulation [[코드 분석]](/History/Progress_report/rtl.md)

### 🧐 **사용된 하드웨어 기법**

> **파이프라인 구조**  

: FFT의 각 스테이지를 클럭마다 연속적으로 처리 가능

> **Cooley-Tukey 구조 최적화**

: Radix-2² 구조 사용

➡️ **Radix-2² FFT**는 **Radix-2의 단순 구조**(덧셈/뺄셈 기반)를 유지하면서, 두 단계의 연산을 묶어 **Radix-4**처럼 4개씩 처리하여 **연산량**을 줄이고 일부 Twiddle factor 곱셈을 단순화하여 하드웨어 효율을 높이는 구조

<img src="/History/img/img77.png" width=700>|
--|

```matlab
for kk=1:2
  for nn=1:128
    bfly01_tmp((kk-1)*256+nn) = bfly00((kk-1)*256+nn) + bfly00((kk-1)*256+128+nn);
    bfly01_tmp((kk-1)*256+128+nn) = bfly00((kk-1)*256+nn) - bfly00((kk-1)*256+128+nn);
  end
end
```

- Radix-2 단계 2개를 한 블록에서 연속 계산
- 즉, 덧셈/뺄셈을 한 블록 안에서 한 번에 처리함으로써 stage가 줄고, 일부 twiddle factor는 단순 곱셈으로 처리 가능 → 하드웨어 효율 ↑ 


> **고정 소수점 사용**  

: 부동소수점 대비 면적/전력 절감 + Precision trade-off 가능

➡️ **BFP**는 블록 단위로 **공통 스케일**을 사용하는 반면, **CBFP**는 **블록** 내 작은 값들의 여유 비트를 활용해 **Q-format을 조정**함으로써 **라운딩 오차를 줄이고 정밀도 향상**이 가능

> **LUT 사용**  

: twiddle factor를 ROM에 미리 저장하여 곱셈 비용 절감

### 시뮬 사진 


## (3) Synthesis

|Setup_time| Area|Latency
--|--|--
0.14 ps| 187768.2| 89 clk


Timing_max| Area
--|--
|<img src="/History/img/img70.png" width=400>| <img src="/History/img/img72.png" width=400>|

> Hold time은 Layout 단계에서 충분히 해결 가능하므로 front-end 과정에서는 Setup time과 Area 최적화에 집중하였다.

## (4) Gate Simulation [[결과 분석]](/History/Progress_report/gate.md)



## (5) FPGA Targeting [[결과 분석]](/History/Progress_report/fpga.md)

|LUT|Setup-time|Latency|
--|--|--
65538 (30%)| 0.576 ns| 89 clk|

<img src="/History/img/img79.png" width=500> |<div align = "left">- LUT 30% 사용 -> Combinational Logic ↑<br>- FF, DSP 약 10% -> 적정 Pipelining, Multiplier
--|--
<img src="/History/img/img80.png" width=500> |- **Setup Time & Hold Time Slack MET** |


## 진행 결과

<img src="/History/img/img81.png" width=700>|
--|

## 🚀Trouble Shooting 
[⚒️[Timing Miss Match Trouble]](/History/trouble_shooting/Trouble_Shooting1.md)   <br>
[⚒️[Random Input Trouble]](/History/trouble_shooting/Trouble_Shooting2.md)  <br>
[⚒️[Clock-gate Latch]](/History/trouble_shooting/Trouble_Shooting3.md) <br>
[⚒️[Indexsum Problem]](/History/trouble_shooting/Trouble_Shooting4.md) <br>
[⚒️[Vivado Synthesis Error]](/History/trouble_shooting/Trouble_Shooting5.md)       <br>
[⚒️[GateSim Trouble]](/History/trouble_shooting/Trouble_Shooting6.md)       <br>
[⚒️[FPGA SetUp Trouble]](/History/trouble_shooting/Trouble_Shooting7.md)      <br>
[⚒️[더 작성할 내용 있으면 추가]](/History/trouble_shooting/Trouble_Shooting8.md)      <br>

