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
