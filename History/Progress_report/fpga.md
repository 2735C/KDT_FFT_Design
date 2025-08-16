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
