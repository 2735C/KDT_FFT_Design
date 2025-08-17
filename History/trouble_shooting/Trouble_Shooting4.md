[Indexsum Problem]

<img src="/History/img/img153.png" width=500> 
<img src="/History/img/img154.png" width=500><img src="/History/img/img155.png" width=400> <br>
<img src="/History/img/img152.png" width=1000>

CBFP에서 생성된 index 값은 바로 indexsum 모듈로 전달된다. 그러나 cbfp0와 cbfp1의 index 생성 시점이 달라 문제가 발생했다. 이를 해결하기 위해 cbfp0의 index는 먼저 받아 레지스터에 순서대로 저장해 두었고, cbfp1의 index가 생성되면 저장된 cbfp0 index와 함께 연산하도록 설계하였다. 즉, cbfp1의 valid_out(m2_valid) 신호를 indexsum 연산 시작 신호로 사용하였다. <br>

또한 step2_2가 끝나면 indexsum을 활용한 bitshift를 바로 수행해야 하므로, step2_2의 add & sub 신호를 전송 트리거로 사용하였다. 이 방식으로 Butterfly 연산 결과와 indexsum 값을 동시에 받아 순차적으로 연산할 수 있었다. <br>

m2_valid와 tx_start 트리거 사이에는 4클럭 차이가 있으며, 데이터는 2개씩 처리된다. 따라서 후순위 indexsum이 아직 계산되지 않았더라도, bitshift 과정에서 앞쪽 출력과 indexsum 값을 처리하는 동안 후순위 indexsum이 연산되어 전체 연산이 정상적으로 진행된다. <br>