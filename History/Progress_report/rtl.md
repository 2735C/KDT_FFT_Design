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

 ### ✅ Module 0_2 구조 요약

* FFT 결과는 총 **512**포인트.

* 이를 **64포인트씩 8개의 블록**(`ii=1~8`)으로 나눔.

* 각 블록 내부에서 **64개의 데이터 포인트**에 대해 연산 (`jj=1~64`).

* 각 복소수 포인트에 대해 Real/Imag 따로 처리.

* 각 블록 내에서 **가장 큰 진폭을 가진 값**을 찾아서 scaling bit 결정.

* 그 bit 수만큼 **bit shift하여 정규화**된 결과(`re_bfly02`, `im_bfly02`)를 얻음.

##

변수명 | 설명
-- | --
kk = ii | 전체 8개 블록 중 몇 번째 블록인지 (1~8)
nn = jj | 각 블록 내부에서 몇 번째 샘플인지 (1~64)
pre_bfly02(k) | Twiddle factor 곱 이후의 복소수 FFT 결과
cnt1_re(ii) | 각 블록에서 Real 값의 scaling bit
cnt1_im(ii) | 각 블록에서 Imag 값의 scaling bit
index1_re(k) | 각 포인트에 대응하는 real shift bit
index1_im(k) | 각 포인트에 대응하는 imag shift bit
re_bfly02(k) | 정규화된 real 결과값
im_bfly02(k) | 정규화된 imag 결과값

```matlab
cnt1_re = zeros(1,8);
cnt1_im = zeros(1,8);
```

* 8개의 블록에 대해 real/imag 각각 scaling bit를 저장할 공간 초기화

```matlab
for ii=1:8
  for jj=1:64
	tmp1_re = mag_detect(real(pre_bfly02(64*(ii-1)+jj)), 23);
	tmp1_im = mag_detect(imag(pre_bfly02(64*(ii-1)+jj)), 23);
```

* mag_detect: Twiddle factor 곱 이후의 복소수 FFT 결과를 이진수로 변환해 각 데이터가 얼마나 시프트될 수 있는지를 계산  (leading 0 또는 1의 개수 기반)

```matlab
	temp1_re = min_detect(jj, tmp1_re, cnt1_re(ii));
	temp1_im = min_detect(jj, tmp1_im, cnt1_im(ii));
```
* min_detect: 64개의 데이터 중 시프트가 가장 덜 되는 값을 찾는다.
* 이전까지 본 값 중 가장 큰 bit 수를 계속 유지 
* 각 블록(64개 단위)마다 최대한 안전하게 시프트할 수 있는 폭을 계산해, 해당 폭만큼 전부 정규화(bit shift)한다.

```matlab
% 실수 파트만 가져옴. 허수도 마찬가지
 for ii=1:8
  if (cnt1_re(ii)<=cnt1_im(ii))
	cnt1_re(ii)=cnt1_re(ii);
  else
	cnt1_re(ii)=cnt1_im(ii);
  end
 end
```
* 실수/허수 중 더 작은 값을 채택(즉, 더 적게 shift할 수 있는 값)
* 정규화 시 둘 중 더 작은 쪽을 기준으로 bit shift 해야 overflow 안 생김

```matlab
 for ii=1:8
  for jj=1:64
	index1_re(64*(ii-1)+jj)=cnt1_re(ii);
	index1_im(64*(ii-1)+jj)=cnt1_im(ii);
  end
 end
```

* 포인트 단위의 그 블록의 scaling bit 복사 즉, scaling index를 생성

```matlab
% 실수 파트만 가져옴. 허수도 마찬가지
 for ii=1:8
  for jj=1:64
   if (cnt1_re(ii)>12) % bitshift <10.13> -> 11bit 
	re_bfly02(64*(ii-1)+jj)=bitshift(bitshift(real(pre_bfly02(64*(ii-1)+jj)),cnt1_re(ii), 'int32'),-12, 'int32');
   else
	re_bfly02(64*(ii-1)+jj)=bitshift(real(pre_bfly02(64*(ii-1)+jj)),(-12+cnt1_re(ii)), 'int32');
   end
  end
 end
```

* 최종 출력의 정규화를 수행하는 부분

*  만약 `cnt1_re(ii) > 12`면,

    1. 먼저 왼쪽으로` cnt1_re(ii)`만큼 시프트해서 값을 키우고,

     2. 다시 오른쪽으로 12비트 시프트해서 값을 줄임. <br>→ 결국 `cnt1_re(ii) - 12 `만큼 왼쪽 시프트한 것과 같지만, 두 단계로 나눠서 계산.

* 만약` cnt1_re(ii) <= 12`면,<br>그냥 `(-12 + cnt1_re(ii))` 만큼 한번에 시프트.
**결론**
* **비트 수(저장 공간)는 고정**인데, 값의 크기(스케일)가 bitshift로 조정됨 → **overflow 방지 및 정규화 목적.**
* **비트 기준 12**: 소수점 위치 기준 조정


