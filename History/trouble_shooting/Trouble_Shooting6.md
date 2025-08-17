[GateSim Trouble]

<img src="/History/img/img158.png" width=1000> 

<img src="/History/img/img159.png" width=1000> 

Synopsys로 Synthesis를 진행한 뒤 testbench를 실행하면 중간 net에서 계속 'X Problem'이 발생하였다. <br>
처음에는 합성기의 오류라 생각하고 합성을 반복해서 더 진행해 보았지만, 효과가 없었다. <br>

register들의 reset 조건을 수정하고 불필요한 register를 제거하거나 clock을 더 사용해서 동시 연산 부담을 줄이는 등의 시행착오 끝에 몇몇 else 조건의 부재가 X Problem을 발생시킨 다는 것을 깨달을 수 있었다. <br>

각 모듈과 step에서 동작을 제어하기 위한 제어 신호들의 else 조건의 부재 때문에 주요 cnt 값들이 증가하지 않았다. <br>

<img src="/History/img/img160.png" width=350> 

<img src="/History/img/img161.png" width=250> 

이후, 합성을 반복해보며 X가 발생하는 net들을 추적하였고, 주로 Indexsum, CBFP, Reordering 같은 모듈에서 처리가 미흡하였다. <br>

모든 else 조건 추가 끝에 성공적인 Synthesis 및 Gate Simulation을 마칠 수 있었다.