[FPGA SetUp Trouble]

<img src="/History/img/img162.png" width=800> 

Vivado Implementation 과정에서 Bitstream을 생성하던 중, bfly02 → cbfp0 cnt_reg 경로에서 지속적으로 Negative Slack이 발생하였다.

특이한 점은 Net Delay가 Logic Delay보다 크다는 것이었는데, 이는 합성기가 모듈 간 배치를 멀리 떨어뜨리면서 배선 길이가 과도하게 늘어난 결과였다.

이 문제를 해결하기 위해 해당 Path의 코드를 집중적으로 분석한 결과, cbfp에서 사용한 function이 주요 원인임을 확인하였다.

<img src="/History/img/img163.png" width=500> 

기존 cbfp0에서는 min_detect function을 사용했는데, 이 함수는 din의 real 값과 imaginary 값을 묶어 [0:31] 배열 형태의 input({din_re, din_im})을 받도록 설계되어 있었다. 함수 내부에서 다수의 삼항 연산자를 사용했는데, 이 과정에서 지나치게 많은 배열이 MUX로 연결되며 Negative Slack을 유발한 것이다.

<img src="/History/img/img164.png" width=500> 

<img src="/History/img/img165.png" width=500> 

1. 입력 크기 축소

[0:31] → [0:15]로 줄여 din_re와 din_im을 각각 따로 처리

2. 비교

두 결과(real, imaginary)를 한 번 더 삼항 연산자로 비교하여 최종 최솟값을 결정

이 방식으로 function의 복잡도를 줄여 Timing 문제를 해결할 수 있었다.

또한, Implementation Strategy를 변경해 Synthesis 방식에 변화를 주어 더 많은 Setup Time을 확보할 수 있었다.

