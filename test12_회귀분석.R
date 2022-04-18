#단순 선형 회귀 모델 연습: 독립, 종속변수가 각 1개

cor(women$height, women$weight)
plot(weight ~ height, data= women)

mfit <- lm(formula = weight ~ height, data=women)
mfit
abline(mfit, col = 'blue', lwd = 2)

print(3.45* 58-87.52)
predict(mfit)
predict(mfit, data.frame((height=c(58))))

summary(mfit) #모델의 요약 통계량
#모델 정보 p값이 0.05이상이면 인과관계가 없다(밀도:상관관계)
#Multiple R-squared: 모델의 설명력(결정계수)
#독립변수가 2개이상일 경우 Adjusted R-squared:  0.9903 

mfit

cor.test(women$height, women$weight)  #상관계수 분석

#회귀분석모형의 적절성을 위한 조건 : 아래의 조건 위배 시에는 변수 제거나 조정을 신중히 고려해야 함.
#1) 정규성 : 독립변수들의 잔차항이 정규분포를 따라야 한다.
#2) 독립성 : 독립변수들 간의 값이 서로 관련성이 없어야 한다.
#) 선형성 : 독립변수의 변화에 따라 종속변수도 변화하나 일정한 패턴을 가지면 좋지 않다.
#4) 등분산성 : 독립변수들의 오차(잔차)의 분산은 일정해야 한다. 특정한 패턴 없이 고르게 분포되어야 한다.
#5) 다중공선성 : 독립변수들 간에 강한 상관관계로 인한 문제가 발생하지 않아야 한다.
#예) 나이와 학년이 신체 구조에 미치는 영향(교집합이 매우 커 다중공선성 우려). 아래 그림 참조.

#그래프로 확인
#1. 선형성, 2. 정규성, 3. 등분산성
#Cook's distance- outlier(이상치)
plot(mfit)
par(mfrow=c(2,2))
plot(mfit)

#위의 그래프를 통해 선형성을 만족하지 못함
#이런 경우 비선형 회귀 모델을 작성(polynomial Regression): 다항회귀
mfit2 <- lm(weight ~ height +I(height^2), data = women)
summary(mfit2)  #R-squared:  0.9995

predict(mfit2, data.frame(height = c(59,58,44,63)))
#117.47311 115.10294  99.36403 128.61506
