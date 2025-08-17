[Vivado Synthesis Error]

<img src="/History/img/img156.png" width=600> 

위와 같은 코드에서, cnt값은 clk에 따라 순차적으로 증가하도록 설계하였다. <br>
하지만, 합 연산 또는 곱 연산에서 cnt 값의 증가가 해당 posedge에 즉시 반영되지 않을 수 있기 때문에 Vivado에서는 이를 Synthesis 과정에서 오류로 분류하였다. <br>
이 오류가 동적 인덱싱 오류이다.<br>

<img src="/History/img/img157.png" width=500> 

따라서, 이를 해결하기 위해 cnt값은 그대로 쓰되, cnt의 증가에 따른 case 변경 방식으로 활용하였다. 모든 case를 할당해 주어야 하기 떄문에 코드의 길이가 길어지고 가독성이 저하되었지만, Synthesis Error를 피할 수 있었다. 

