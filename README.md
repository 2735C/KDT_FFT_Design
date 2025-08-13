# 👑TEAM: AI 반도체 설계 2기 4번째 수업 2조


## 🙋‍♂️팀원

|                                                 **최윤석**                                                 |                                                                                                                             **배상원**                                                                                                                              |                                                                        **윤의빈**                                                                        |                                                                                                                             **정은지**                                                                                                                              |
| :--------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                                Team Leader                                                 |                                                                                                                            Team member 1                                                                                                                             |                                                                  Team member 2                                                                   |                                                                                                                         Team member 3                                                                                                                        |
| [<img src="/History/img/profile_1.jpg" width=150 height=150> </br> @최윤석](https://github.com/stockfail) | [<img src="/History/img/profile_2.png" width=150 height=150> </br> @Bae SANGWON](https://github.com/BAESANGWON1) | [<img src="/History/img/profile_3.png" width=150 height=150> </br> @윤의빈](https://github.com/demic2da) | [<img src="/History/img/profile_4.jpg" width=150 height=150> </br> @Eunji Jung](https://github.com/2735C) |

## 🖊️Role

### 🐶최윤석
- Team leader
- BFP 기반 FFT Fixed point modeling
- Butterfly Calculation Module RTL Desgin 
- Gate simulation testbench design & Gate simulation


### 🐧배상원
- BFP 기반 FFT Fixed point modeling
- Butterfly Calculation Module RTL Desgin 
- Gate simulation & Debugging


### 🐻윤의빈
- BFP 기반 FFT Fixed point modeling
- Butterfly Calculation Module & Bit reverse RTL Desgin 
- Gate simulation & Debugging
- FPGA targeting



### 🐤정은지 
- BFP 기반 FFT Fixed point modeling
- CBFP Module RTL Desgin 
- Gate simulation & Debugging
- FPGA targeting


## 🚀프로젝트 개요
**FFT란?** <br>
<img width="800" alt="image" src="https://github.com/user-attachments/assets/a09e11f8-483d-4b9a-be05-764e73d76ca3" /> |
--|

- 그림과 같이 시간 도메인의 함수를 주파수 도메인 함수로 변환하는것을 푸리에 변환이라고 합니다.

- 하지만 이산적인(무한하지 않은) 영역에서 DFT(이산 푸리에 변환)은 샘플링 수에 따라 기하 급수적으로 연산양이 커지게 됩니다.

- 이를 빠르게 계산하기 위해서 사용되는것이 FFT로 연상양이 획기적으로 줄어들어 듭니다.

- IFFT 같은 경우에는 주파수 도메인 함수에서 시간도메인 함수로 변환하는 과정으로 FFT과정과 비슷하지만 1/N 스케일링 과정이 추가 됩니다.
 <br>

### 🧐문제 인식
**HW 설계가 더 적합한 이유**
- 일반적인 FFT 알고리즘을 RTL로 구현하기에는 많은 연산을 특히 복소수 곱셈 연산을 하게되어 리소스가 커지게 됩니다. <br>
그렇기 떄문에 저희는 Radix-2^2 논문을 해석하여 논문 내용을 바탕으로 만들어진 Fixed_model을 분석하였습니다. <br>
- 논문에서 사용하는 방법론은 버터플라이 연산은 Radix-2 방식으러 진행하여 연산이 간단하며 회전인자 곱셈은 Radix-4와 같이 적은 곱셈연산을 수행합니다.
이러한 연산을 수행하는 방법으로는 첫번째 버터플라이 연산후에는 간단한 1,-j와 같은 곱셈을 진행하는데 이때는 멀티플라이어가 필요가 없게됩니다.
두번째 버터플라이 연산후에는 복잡한 회전인자 곱셈연산이 추가되지만 다음번 버터플라이 연산때는 다시 단순한 곱셈이 이루어져 결과적으로 필요한 멀티플라이어 갯수가 줄어듭니다.
이러한 연산이 반복되는구조로 샘플링 갯수(N) 가 2의 제곱수이면서 2048이하 일때  하드웨어 구현에 최적화 된 알고리즘 이라는것을 알수 있었습니다.<br>
- Fixed과정에서 saturaion, rounding 과정에서 오차가 발생한다는점을 랜덤입력 과 SQNR을 통해 찾게되어 CBFP논문의 내용또한 해석하여 참조 하였습니다.<br>
- CBFP과정을 추가하여 작은값이 라운딩과정에서 값을 잃어 큰 오차가 발생하는 문제를 작은값이 많은 여유비트를 가진다는 점을 이용하여 MSB쪽으로 값을 이동시켜 라운딩해 값을 최대한 보존하여 높은 SQNR을 얻을수 있었습니다.


🎉 그래서 직접 8-point FFT RTL 설계를 진행해 보았다. 어쩌구<br>

**적용된 HW 설계 기법**

아래로 소개....

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
> 더 많은 내용을 확인하고 싶으면 --> [[발표 자료]](/History/PPT/Team2_발표자료.pdf)


🔥🔥🔥🔥 디버깅 과정은 Trouble 슈팅 칸 만들거니까 개발 과정에는 결론만 적어주셈 🔥🔥🔥🔥

## (1) Fixed point modeling

### 

Fixed, float 개념부터 foarmat 관련 이야기랑 matlab 시행착오 등등 적으면 될 듯 <br>
- Float 모델은 정확한 실숫값들의 연산으로 알고리즘을 확인해 가며 원하는 출력을 만들어 내는지 시뮬레이션을 진행할 수 있습니다. <br>
- Fixed 모델은 완성된 float 모델을 고정 소수점을 사용하여 정숫값들의 연산으로 수정한 모델로, 비트들로 이루어진 연산을 수행하는 하드웨어에서의 연산을 미리 시뮬레이션할 수 있습니다. <br>
- 고정 소수점으로 실수값들을 정수로 나타낼때는 부호비트와 정수비트 그리고 소수비트로 구성됩니다. 이떄 정수비트와 소수비트를 나타낼때는 실수값을 기준으로 포멧을 정하여 정해진 비트로 나타냅니다. 

## (2) RTL Simulation

### Butterfly Calculation
<img src="/History/img/img10.png" width=1000> <br>
Butterfly Calculation을 clk당 16개의 데이터 처리로 해결하기에는 N = 512기준 으로 1과 256번 인덱스 연산까지 오는 clk때 까지 가기전에 다음 clk때 데이터가 소실되는 문제가 있습니다.<br>
이를 해결 하기위해 쉬프트 레지스터를 사용하여 256번째 인덱스 데이터가 오기까지 clk마다 데이터를 저장하고 256번쨰 인덱스가 들어 오는 clk때부터는 쉬프트레지스터 1번 인덱스 부터의 출력과 입력 데이터 간에 버터플라이 연산을 수행합니다.<br>
이러한 입/출력 제어는 카운터로 제어되며 다음 단계에서는 버터플라이 연산을 하는데 필요한 인덱스가 달라지기에 필요한 쉬프트 레지스터의 크기 와 카운터의 비트가 작아지게 됩니다.<br>
카운터는 이 밖에도 버터플라이 연산결과를 곱셈연산 제어할떄도 사용됩니다.<br>
#### step 0

각 모듈의 step0는 매 클럭마다 16개의 입력값을 병렬로 연산한다
연산은 2단구조: Add/Sub enable 신호와 Mulenable신호로 제어한다.

### step0_0 Add/Sub 단계                       step1_0 Add/Sub 단계

<img src="/History/img/img30.png" width=400> <img src="/History/img/img32.png" width=400>


shift register로 입력값을 저장한 뒤, shift register의 출력값과 새로 들어오는 입력값의 add/sub 동작 수행 
  
### step0_0 Mul 단계                           step1_0 Mul 단계

<img src="/History/img/img31.png" width=400> <img src="/History/img/img33.png" width=400>


add/sub 연산 후 mul_enable신호로 twiddle factor를 곱해주는 연산이 수행됨
앞선 연산값이 그대로 출력(twddile factor = 1), sub연산 결과의 Re↔Im 교차(twiddle factor = j)이 반복되어 수행됨


#### step 1
솰라솰라

#### step 2
솰라솰라
### CBFP
솰라솰라<br> 

### 시뮬 사진 
아무 생각이 없다

## (3) Synthesis

합성 결과 사진 첨부 이건 제가 파일 zip 해제 안 해도 돼서 제가 넣을게요


## (4) Gate Simulation

### Testbench Code 핵심 첨부 및 설명
- 게이트 시뮬레이션은 RTL구현에서 합성이후 시뮬레이션 단계로 이떄부터는 이상적인 동작을 넘어 실제 동작과 같은 환경과 같이 테스트 하게 됩니다.
이과정을 통해 알수 있는것은 합성이 완벽하게 되었는지 와 앞선 신호가 X를 출력할때 그 이후 신호들이 모두 X를 출력하는 X-problem문제까지 찾을수 있습니다. <br>
- 게이트 시뮬레이션 테스트 결과는 합성에 문제가 있었던 부분과 코드에서 초기화 하지 않은 부분들을 찾을 수 있게 되어 실제 Chip이 오동작을 일으키는 문제를 방지할수 있습니다. <br>
- 게이트 시뮬레이션과 RTL 시뮬레이션에서 큰차이점은 게이트 시뮬레이션은 실제와 같이 동작하기에 배열로 정리한 데이터들이 사실 큰 비트들로 순서대로 전달되는것을 확인할수 있습니다. <br>
- 하지만 이렇게 되면 저희가 테스트 결과를 확인하기에 보기 어렵기 때문에 테스트 벤치 코드에서 입/출력 데이터 비트들을 다시 배열로 볼수 있게 정리해서 새로운 변수에 저장하여 쉽게 디버깅이 가능했습니다. <br>   



### 시뮬 사진

이미지 

## (5) FPGA Targeting
### Top Module Schematic
<img src="/History/img/img1.png" width=1000>
설계한 각 Module들을 연결하여 만들 최종 Top Module은 다음과 같다.


### Elaborated Design
<img src="/History/img/img2.png" width=1000>
Top Module Schematic을 바탕으로 Module들을 Wiring하고, Vivado로 만든 Design은 다음과 같다.

### Vivado

> **Clocking Wizard**


- vio 연결 설정이랑 xdc 설정 관해서 언급 및 사진, 결과 적기 




## 🚀Trouble Shooting 
[⚒️[Timing Miss Match Trouble]](/History/trouble_shooting/Trouble_Shooting1.md)   <br>
[⚒️[Random Input Trouble]](/History/trouble_shooting/Trouble_Shooting2.md)  <br>
[⚒️[Clock-gate Latch]](/History/trouble_shooting/Trouble_Shooting3.md) <br>
[⚒️[Indexsum Problem]](/History/trouble_shooting/Trouble_Shooting4.md) <br>
[⚒️[Vivado Synthesis Error]](/History/trouble_shooting/Trouble_Shooting5.md)       <br>
[⚒️[GateSim Trouble]](/History/trouble_shooting/Trouble_Shooting6.md)       <br>
[⚒️[FPGA SetUp Trouble]](/History/trouble_shooting/Trouble_Shooting7.md)      <br>
[⚒️[더 작성할 내용 있으면 추가]](/History/trouble_shooting/Trouble_Shooting8.md)      <br>

