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

|<img src="/History/img/img74.png" width=500>|<img src="/History/img/img75.png" width=500>
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

### ✳️ 성능 향상

<img src="/History/img/img76.png" width=1000>|
--|



## (2) RTL Simulation [[코드 분석]](/History/Progress_report/rtl.md)

<img src="/History/img/img77.png" width=1000>|
--|
<img src="/History/img/img78.png" width=1000>|




### 시뮬 사진 


## (3) Synthesis

|Setup_time| Area|Latency
--|--|--
0.14 ps| 187768.2| 89 clk


Timing_max|Timing_min| Area
--|--|--
|<img src="/History/img/img70.png" width=500>| <img src="/History/img/img71.png" width=500>| <img src="/History/img/img72.png" width=500>|

> Hold time은 Layout 단계에서 충분히 해결 가능하므로 front-end 과정에서는 Setup time과 Area 최적화에 집중하였다.

## (4) Gate Simulation

### Testbench Code 핵심 첨부 및 설명
<img src="/History/img/img13.png" width=500> <br>
- 게이트 시뮬레이션은 RTL구현에서 합성이후 시뮬레이션 단계로 이떄부터는 이상적인 동작을 넘어 실제 동작과 같은 환경과 같이 테스트 하게 됩니다.
이과정을 통해 알수 있는것은 합성이 완벽하게 되었는지 와 앞선 신호가 X를 출력할때 그 이후 신호들이 모두 X를 출력하는 X-problem문제까지 찾을수 있습니다. <br>
- 게이트 시뮬레이션 테스트 결과는 합성에 문제가 있었던 부분과 코드에서 초기화 하지 않은 부분들을 찾을 수 있게 되어 실제 Chip이 오동작을 일으키는 문제를 방지할수 있습니다. <br>
- 게이트 시뮬레이션과 RTL 시뮬레이션에서 큰차이점은 게이트 시뮬레이션은 실제와 같이 동작하기에 배열로 정리한 데이터들이 사실 큰 비트들로 순서대로 전달되는것을 확인할수 있습니다. <br>
- 하지만 이렇게 되면 저희가 테스트 결과를 확인하기에 보기 어렵기 때문에 테스트 벤치 코드에서 입/출력 데이터 비트들을 다시 배열로 볼수 있게 정리해서 새로운 변수에 저장하여 쉽게 디버깅이 가능했습니다. <br>   



###  Gate Simulation 결과

<img src="/History/img/img11.png" width=1000> <br>
<img src="/History/img/img12.png" width=1000> <br>

## (5) FPGA Targeting

|LUT|Setup-time|Latency|
65538 (30%)| 0.576 ns| 89 clk|

<img src="/History/img/img79.png" width=500> |- LUT 30% 사용 -> Combinational Logic ↑<br>- FF, DSP 약 10% -> 적정 Pipelining, Multiplier
--|
<img src="/History/img/img80.png" width=500> |Setup Time & Hold Time Slack MET


## 🚀Trouble Shooting 
[⚒️[Timing Miss Match Trouble]](/History/trouble_shooting/Trouble_Shooting1.md)   <br>
[⚒️[Random Input Trouble]](/History/trouble_shooting/Trouble_Shooting2.md)  <br>
[⚒️[Clock-gate Latch]](/History/trouble_shooting/Trouble_Shooting3.md) <br>
[⚒️[Indexsum Problem]](/History/trouble_shooting/Trouble_Shooting4.md) <br>
[⚒️[Vivado Synthesis Error]](/History/trouble_shooting/Trouble_Shooting5.md)       <br>
[⚒️[GateSim Trouble]](/History/trouble_shooting/Trouble_Shooting6.md)       <br>
[⚒️[FPGA SetUp Trouble]](/History/trouble_shooting/Trouble_Shooting7.md)      <br>
[⚒️[더 작성할 내용 있으면 추가]](/History/trouble_shooting/Trouble_Shooting8.md)      <br>

