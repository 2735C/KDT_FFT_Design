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


## 🚀프로젝트 개요

본 프로젝트에서는 **BFP(Block Floating Point) 기반 Radix-2² 구조의 FFT**를 대상으로 MATLAB 환경에서 Floating 모델을 **Q-format 기반 Fixed-point 모델로 변환**하여 **알고리즘 수준의 사전 검증(High-level verification)** 을 수행하였다. 이어서 CBFP(Combined Block Floating Point) 모델의 Fixed-point 구현을 적용하여 **BFP와 CBFP 알고리즘 간 성능을 비교**하였다.

CBFP 모델을 기반으로 **RTL 설계 및 합성**을 진행하고, 이를 통해 **setup time violation, Area, Latency** 등의 특성을 분석하였다. 마지막으로 **게이트 레벨 시뮬레이션**과 **FPGA Targeting**을 수행하여 RTL 설계의 기능적 타당성을 검증하였다.


**FFT의 필요성**
- **시간 영역 신호를 주파수 영역으로 변환**하여 주파수 분석, 채널 분리 등 다양한 신호 처리에 활용 가능.

- 통신 시스템(OFDM, 5G, Wi-Fi), 레이더, 오디오·영상 처리 등 **실시간·고속 신호 처리**가 필요한 대부분의 시스템에서 핵심 알고리즘으로 사용됨.

**HW가 적합한 이유**

- **FFT 연산**은 곱셈과 덧셈이 반복되는 **고연산량 알고리즘**으로, 소프트웨어에서는 처리 속도와 전력 효율이 제한됨.

- 하드웨어에서는 **병렬 연산, 파이프라인 구조, 메모리 최적화**를 통해 **실시간** 처리가 가능.

- RTL 설계 및 FPGA 구현을 통해 setup time, area, latency 등의 특성을 직접 분석하고 최적화 가능.

- 결과적으로 실시간 통신 및 신호 처리 시스템에서 **고속·저전력 FFT 구현**이 가능함.

##

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


## 개발 과정
> 더 많은 내용을 확인하고 싶으면 --> [[발표 자료]](/History/PPT/Team2_발표자료.pdf)


🔥🔥🔥🔥 디버깅 과정은 Trouble 슈팅 칸 만들거니까 개발 과정에는 결론만 적어주셈 🔥🔥🔥🔥

## (1) Fixed point modeling

### 

Fixed, float 개념부터 foarmat 관련 이야기랑 matlab 시행착오 등등 적으면 될 듯 <br>
- Float 모델은 정확한 실숫값들의 연산으로 알고리즘을 확인해 가며 원하는 출력을 만들어 내는지 시뮬레이션을 진행할 수 있습니다. <br>
- Fixed 모델은 완성된 float 모델을 고정 소수점을 사용하여 정숫값들의 연산으로 수정한 모델로, 비트들로 이루어진 연산을 수행하는 하드웨어에서의 연산을 미리 시뮬레이션할 수 있습니다. <br>
- 고정 소수점으로 실수값들을 정수로 나타낼때는 부호비트와 정수비트 그리고 소수비트로 구성됩니다. 이떄 정수비트와 소수비트를 나타낼때는 실수값을 기준으로 포멧을 정하여 정해진 비트로 나타냅니다. <br>
- Fixed 모델로 작성된 MATLAB코드를 해석하면서 알게 된것은 사칙연산 과정 특히 곱셈 과정에서 비트가 크게 증가하게 되기에, 이것을 Saturaion과정과 Round 과정을 거쳐야 비트수를 줄일수 있게 되어 하드웨어 구현에서 크기를 줄이고 속도를 올릴며 전력소모를 줄일수 있습니다. <br>
- Fixed 모델에 cos 데이터를 512개로 샘플링한 데이터와 랜덤입력을 넣어 나온 결과를 SQNR 과정을 거쳐 정확도를 비교 했을때 랜덤입력에서 정확도 dB값이 낮게 나온것을 확인 하였습니다. 이는 

## (2) RTL Simulation

 ### :one: Butterfly Calculation 
<img src="/History/img/img10.png" width=1000> <br>
Butterfly Calculation을 clk당 16개의 데이터 처리로 해결하기에는 N = 512기준 으로 1과 256번 인덱스 연산까지 오는 clk때 까지 가기전에 다음 clk때 데이터가 소실되는 문제가 있습니다.<br>
이를 해결 하기위해 쉬프트 레지스터를 사용하여 256번째 인덱스 데이터가 오기까지 clk마다 데이터를 저장하고 256번쨰 인덱스가 들어 오는 clk때부터는 쉬프트레지스터 1번 인덱스 부터의 출력과 입력 데이터 간에 버터플라이 연산을 수행합니다.<br>
이러한 입/출력 제어는 카운터로 제어되며 다음 단계에서는 버터플라이 연산을 하는데 필요한 인덱스가 달라지기에 필요한 쉬프트 레지스터의 크기 와 카운터의 비트가 작아지게 됩니다.<br>
카운터는 이 밖에도 버터플라이 연산결과를 곱셈연산 제어할떄도 사용됩니다.<br>

### :check: step 0

각 모듈의 step0는 매 클럭마다 16개의 입력값을 병렬로 연산한다
연산은 2단구조: Add/Sub enable 신호와 Mulenable신호로 제어한다.

step0_0 Add/Sub 단계 | step1_0 Add/Sub 단계|
--|--
|<img src="/History/img/img30.png" width=400> |<img src="/History/img/img32.png" width=400>|


> shift register로 입력값을 저장한 뒤, shift register의 출력값과 새로 들어오는 입력값의 add/sub 동작 수행 

  
step0_0 Mul 단계|step1_0 Mul 단계|
--|--
|<img src="/History/img/img31.png" width=400>| <img src="/History/img/img33.png" width=400>|


> add/sub 연산 후 mul_enable신호로 twiddle factor를 곱해주는 연산이 수행됨

> 앞선 연산값이 그대로 출력(twddile factor = 1), sub연산 결과의 Re↔Im 교차(twiddle factor = j)이 반복되어 수행됨


### :check: step 1

step0_1 Add/Sub 단계| step1_1 Add/Sub 단계|
--|--
|<img src="/History/img/img34.png" width=400> |<img src="/History/img/img36.png" width=400>|


> 4가지의 shift type에 따라 shift register의 경로 설정, add/sub enable 신호가 각각 다르게 제어됨

> shift type이 0,2일때는 shift register의 경로를 결정하여 저장하고, shift type이 1,3일 때 연산을 수행함

  
step0_1 Mul 단계 | step1_1 Mul 단계|
--|--
|<img src="/History/img/img35.png" width=400>| <img src="/History/img/img37.png" width=400>|


> add/sub 연산 후 mul_enable신호로 twiddle factor를 곱해주는 연산이 수행됨

> twiddle factor값이 다양해지면서 다양한 조합으로 곱셈을 진행함

> twiddle factor가 복소수일 경우에는 결과의 Re↔Im 교차가 발생함

> 버터플라이 연산이 진행될수록 연산 주기가 짧아져 module1의 step1에서는 더 짧은 주기로 twiddle factor의 곱셈 조합이 변화됨


### :check: step 2

 step0_2 Add/Sub 단계 |  step1_2 Add/Sub 단계
--|--
| <img src="/History/img/img38.png" width=400> | <img src="/History/img/img39.png" width=400>|


> step1과 동일하게 4가지의 shift type에 따라 shift register의 경로 설정, add/sub enable 신호가 각각 다르게 제어됨

> module이 진행됨에 따라 shift register의 크기가 달라짐

> shift type이 0,2일때는 shift register의 경로를 결정하여 저장하고, shift type이 1,3일 때 연산을 수행함

  
step0_2 Mul 단계| step1_2 Mul 단계
--|--
|<img src="/History/img/img40.png" width=400>| <img src="/History/img/img41.png" width=400>|


> add/sub 연산 후 mul_enable신호로 twiddle factor를 곱해주는 연산이 수행됨

> twiddle factor는 미리 계산한 뒤, ROM에 저장하여 각 연산 index에 맞춰 곱셈을 수행함

> twiddle factor가 복소수일 경우에는 결과의 Re↔Im 교차가 발생함

> step1_2부터는 연산이 매clk마다 수행되어 출력됨

## 

 ### :two: CBFP

 #### ➤ BFP vs CBFP

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




### 시뮬 사진 
아무 생각이 없다

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
### Top Module Schematic
<img src="/History/img/img1.png" width=1000>
설계한 각 Module들을 연결하여 만들 최종 Top Module은 다음과 같다.


### Elaborated Design
<img src="/History/img/img2.png" width=1000>
Top Module Schematic을 바탕으로 Module들을 Wiring하였고, Vivado로 만든 Design은 다음과 같다.


### Vivado

> **Clocking Wizard**

<img src="/History/img/img50.png" width=250> <img src="/History/img/img51.png" width=250>
<img src="/History/img/img52.png" width=600>


FPGA에서 사용할 보드는 Avnet-Tria UltraZed-7EV Carrier Card로, System Clock이 300MHz이다. <br>
하지만, 우리가 사용할 Clock은 100MHz이므로, System Clock을 Prescaling 해주어야 한다. <br>
이를 위해, Vivado의 IP를 활용하여 위와 같은 Clocking_Wizard를 설계하였다. <br>

Clocking Wizard에서 발생하는 locked 신호는 Prescaling한 clock이 완벽한 준비 상태인지 나타내는 신호이다. <br>
따라서, locked 신호가 0이면 clk이 미완 상태이므로, 전체 시스템을 reset 상태로 유지해야 한다. <br>
현재, 전체 시스템에서 Negative Reset을 사용 중이므로, locked 신호와 AND 처리해 reset 신호를 설정하였다. <br>

> **VIO**

<img src="/History/img/img53.png" width=250> <img src="/History/img/img54.png" width=250>
<img src="/History/img/img55.png" width=250>

실제 보드에 올리는 것이 아니므로 Bitstream의 동작 여부를 판단하기 위해서는 가상의 핀을 할당해야 한다. <br>
이를 위해 Vivado의 IP를 활용하여 위와 같은 VIO를 설계하였다. <br>
출력의 16개의 real 포트, 16개의 imaginary 포트, 그리고 출력이 되고 있다는 complete 포트, 총 33개로 구성되어 있다. <br>
따라서, VIO는 33개의 input으로 구성되어 있다. 또한, 모든 출력이 나온 후 회로를 reset 해주기 위한 1개의 output을 추가해주었다.

> **Cosine Generator**

<img src="/History/img/img57.png" width=350> 

<img src="/History/img/img58.png" width=250> <img src="/History/img/img59.png" width=250>

<img src="/History/img/img60.png" width=250> <img src="/History/img/img61.png" width=250>

FFT logic에 지속적으로 Fixed 형식의 Cosine 입력을 주기 위해 Cosine Generator를 설계하였다. <br>
각 모듈의 step2에서 twiddle factor를 가져오는 방식과 유사하게 설계하였고, 1clk 당 real, imaginary 값이 16개씩 출력된다. <br>
입력이 전달되는 동안 valid 신호를 발생시켜, 총 32clk의 valid 신호가 출력된다. <br>
기존에 동적 배열 형태로 출력을 내보내도록 설계하였으나, Vivado에서 합성 오류가 발생해 Case문으로 출력을 내보내도록 처리하였다.

> **Xdc**

<img src="/History/img/img56.png" width=400> <img src="/History/img/img62.png" width=400> 

Avnet-Tria UltraZed-7EV Carrier Card는 차동 구조의 clk을 사용한다. <br>
따라서, AC8, AC7 pin에 연결해 각각 clk_p, clk_n을 설정하고 LVDS(Low Voltage Differential Signaling) 표준으로 설정하여 300MHz 차동 클럭을 받는다. <br>

reset의 경우 AA13 pin에 연결하고 LVCMOS 1.8V로 pin 전압 레벨을 설정하여 사용한다.


> **Implementation Result**

<img src="/History/img/img63.png" width=1000>
<img src="/History/img/img64.png" width=1000>

<img src="/History/img/img65.png" width=400> <img src="/History/img/img66.png" width=400>

Vivado 합성 결과, Setup Time과 Hold Time이 모두 만족되었으며, 시뮬레이션 파형을 통해 Latency가 기존과 동일하게 89클럭임을 확인하였다. <br>
또한, Utilization Report 분석 결과, LUT 사용률은 30%로 나타났으며, 이는 function과 제어 신호 assign 등 다수의 조합 논리를 사용한 데 기인한 것으로 확인되었다. <br>
반면 FF와 DSP 사용률은 각각 약 10% 수준으로, 적절한 파이프라이닝과 곱셈기 활용이 이루어졌음을 보여준다. <br>
특히 곱셈 연산의 경우, 다수를 Bitshift 방식으로 대체하여 DSP 사용량을 눈에 띄게 줄일 수 있었다. 

> **Simulation Result**

<img src="/History/img/img67.png" width=1000>

clk_period = 1/100MHz = 10ns <br>
Latency = (915ns - 30ns) / clk_period = 88.5clk => 89clk <br>

시뮬레이션 파형을 통해 Latency가 Synopsys Gate Synthesis 결과와 동일함을 확인할 수 있었다. <br>
또한, Cosine input을 32clk 동안 주고 8clk 동안 쉰 뒤 다시 주었을 때, 출력 또한 같은 길이로 동작함을 확인할 수 있었다. <br>

- 결과 비교

<img src="/History/img/img68.png" width=400> <img src="/History/img/img69.png" width=400>

<img src="/History/img/img150.png" width=400> <img src="/History/img/img151.png" width=400>

Simulation 결과를 직접 비교하기 위해 0 ~ 15 / 128 ~ 143 / 256 ~ 271 / 384 ~ 399 / 496 ~ 511 으로 Index 구간을 나누어 비교를 진행했다. <br>
각 구간에서 Real, Imaginary 값 모두 Reordering된 순서로 출력됨을 확인할 수 있었고, 이후 반복되는 출력에서도 동일하게 나타났다.


## 🚀Trouble Shooting 
[⚒️[Timing Miss Match Trouble]](/History/trouble_shooting/Trouble_Shooting1.md)   <br>
[⚒️[Random Input Trouble]](/History/trouble_shooting/Trouble_Shooting2.md)  <br>
[⚒️[Clock-gate Latch]](/History/trouble_shooting/Trouble_Shooting3.md) <br>
[⚒️[Indexsum Problem]](/History/trouble_shooting/Trouble_Shooting4.md) <br>
[⚒️[Vivado Synthesis Error]](/History/trouble_shooting/Trouble_Shooting5.md)       <br>
[⚒️[GateSim Trouble]](/History/trouble_shooting/Trouble_Shooting6.md)       <br>
[⚒️[FPGA SetUp Trouble]](/History/trouble_shooting/Trouble_Shooting7.md)      <br>
[⚒️[더 작성할 내용 있으면 추가]](/History/trouble_shooting/Trouble_Shooting8.md)      <br>

