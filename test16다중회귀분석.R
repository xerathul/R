# 다중선형 회귀분석(mutilple Linear Regression) : 독립변수가 복수
dim(state.x77)
state.x77 #미국 각 주 관련 정보
str(state.x77)
class(state.x77)
colnames(state.x77)

states <- as.data.frame(state.x77[, c('Murder','Population','Illiteracy','Income','Frost')])
head(states)
dim(states)
cor(states)
#독립변수 : 'Population','Illiteracy','Income','Frost'
#종속변수 : 'Murder'

#모델작성
mfit <- lm(formula = Murder ~Population+Illiteracy+Income+Frost, data = states)
summary(mfit)  #p-value: 9.133e-08<0.05 유의미한 모델 Adjusted R-squared:  0.5285 설명력
par(mfrow = c(2,2))
plot(mfit)

#새값으로 예측
part_states <- states[1:3,]
pre_states <- edit(part_states)#빠르게 수정하기
pre_states
predict(mfit, pre_states)

#------------------------------------------

mfit <- lm(formula = Murder ~Population+Illiteracy+Frost, data = states)
summary(mfit)
plot(mfit)

mfit <- lm(formula = Murder ~Population+Illiteracy+Income, data = states)
summary(mfit)
plot(mfit)

mfit <- lm(formula = Murder ~Population+Illiteracy, data = states)
summary(mfit)
plot(mfit)

#회귀분석모형의 적절성을 위한 조건 : 아래의 조건 위배 시에는 변수 제거나 조정을 신중히 고려해야 함.
#1) 정규성 : 독립변수들의 잔차항이 정규분포를 따라야 한다.
#2) 독립성 : 독립변수들 간의 값이 서로 관련성이 없어야 한다.
#3) 선형성 : 독립변수의 변화에 따라 종속변수도 변화하나 일정한 패턴을 가지면 좋지 않다.
#4) 등분산성 : 독립변수들의 오차(잔차)의 분산은 일정해야 한다. 특정한 패턴 없이 고르게 분포되어야 한다.
#5) 다중공선성 : 독립변수들 간에 강한 상관관계로 인한 문제가 발생하지 않아야 한다.
#예) 나이와 학년이 신체 구조에 미치는 영향(교집합이 매우 커 다중공선성 우려). 아래 그림 참조.


par(mfrow = c(2,2))
plot(mfit)

#1) 잔차의 정규성 검증
shapiro.test(residuals(mfit)) #p-value = 0.6672 > 0.05 정규성 만족

#2) 독립성 검정
install.packages("car")
library(car)
durbinWatsonTest(mfit)  #D-W Statistic 2.31769: 2에 가까울 수록 독립성 만족

#3) 선형성 검정
boxTidwell( Murder ~Population+Illiteracy, data = states)
# Population       0.86939             -0.3228   0.7468 > 0.05 만족
# Illiteracy       1.35812              0.6194   0.5357 > 0.05 만족

#4) 등분산성 검정
ncvTest(mfit)  # p = 0.18632 > 0.5이므로 등분산성 만족

#5) 다중공선성 검정 : 분산 팽창 요인(vif()) 값이 10을 초과하면 다중공선성 발생 했다고 가정
vif(mfit)  
# Population Illiteracy     Income      Frost 
# 1.245282   2.165848   1.345822   2.082547   < 10 다중공선성이 발생 x

#-----------------------------------------------
#예측(독립, 설명)변수 선택
mfit1 <- lm(Murder ~., data = states) 
summary(mfit1)  #income , Frost 변수는 의미없을 가능성이 높음

mfit2 <- lm(Murder ~Population+Illiteracy, data = states)
summary(mfit2)
#Adjusted R-squared: 0.5484

#ATc 통계랑: 통계 모델 간의 성능 비교용
AIC(mfit1, mfit2)
# df      AIC
# mfit1  6 241.6429
# mfit2  4 237.6565  ATC 낮은 mfit2 모델이 더 좋다라고 평가됨

#AIC를 자도으로 처리하기: stepwise regression

#후진 소거법: backward ~ 모든 변수를 넣고 기여도가 낮은 변수부터 하나씩 제거하며 AIC를 체크
ful_model <- lm(Murder ~ ., data = states)
reduce_model <- step(ful_model,direction = 'backward')
summary(reduce_model)

#전진 선택법: forward ~ 유익한 변수부터 하나씩 추가하며 AIC 체크
min_model <- lm(Murder ~ 1, data = states)  #1:변수없이 출발
fwd_model <- step(min_model,direction = 'forward',
                  scope = ( Murder ~Population+Illiteracy+Income+Frost), trace = 1)
summary(fwd_model)
#위의 방법은 일반적이나, 기회를 갖지 못하는 변수가 있을 수 있다는 단점

#all subset regression : 모든 조합에 대한 검증을 함

install.packages("leaps")
library(leaps)
model <- regsubsets(Murder ~ ., data = states, nbest = 4)
summary(model)
summary(model)$bic
summary(model)$adjr2
plot(model, scale = 'bic') #맨위에 제일 진한 값
