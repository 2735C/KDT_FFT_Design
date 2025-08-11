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
<img width="1551" height="761" alt="image" src="https://github.com/user-attachments/assets/a09e11f8-483d-4b9a-be05-764e73d76ca3" />
 <br>

### 🧐문제 인식
**HW 설계가 더 적합한 이유**
어쩌구 저쩌구 <br>

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

Fixed, float 개념부터 foarmat 관련 이야기랑 matlab 시행착오 등등 적으면 될 듯

## (2) RTL Simulation

### Butterfly Calculation

#### step 0
step마다 각각 twiddle factor가 다르니까 format이랑 연산 방법 등에 대해 소개하던가 코드 부분 발췌해서 설명하던가(허수 실수 교차 되는 거 등등)

#### step 1
솰라솰라

#### step 2
솰라솰라
### CBFP
솰라솰라

### 시뮬 사진 
아무 생각이 없다

## (3) Synthesis

합성 결과 사진 첨부 이건 제가 파일 zip 해제 안 해도 돼서 제가 넣을게요


## (4) Gate Simulation

### Testbench Code 핵심 첨부 및 설명
솰라솰라


### 시뮬 사진

이미지 

## (5) FPGA Targeting

### Vivado

vio 연결 설정이랑 xdc 설정 관해서 언급 및 사진, 결과 적기 




## 🚀Trouble Shooting 
[⚒️[Timing Miss Match Trouble]](/History/trouble_shooting/Trouble_Shooting1.md)   <br>
[⚒️[Random Input Trouble]](/History/trouble_shooting/Trouble_Shooting2.md)  <br>
[⚒️[Clock-gate Latch]](/History/trouble_shooting/Trouble_Shooting3.md) <br>
[⚒️[Indexsum Problem]](/History/trouble_shooting/Trouble_Shooting4.md) <br>
[⚒️[Vivado Synthesis Error]](/History/trouble_shooting/Trouble_Shooting5.md)       <br>
[⚒️[GateSim Trouble]](/History/trouble_shooting/Trouble_Shooting6.md)       <br>
[⚒️[FPGA SetUp Trouble]](/History/trouble_shooting/Trouble_Shooting7.md)      <br>
[⚒️[더 작성할 내용 있으면 추가]](/History/trouble_shooting/Trouble_Shooting8.md)      <br>

