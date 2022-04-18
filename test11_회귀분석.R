#선형 회귀 분석 모델 만들기
#y= wx+b 일차방정식을 작성하는데 이것이 곧 선형회귀 모델이다.
#w(기울기:slope), b(절편:bias)는 최소 제곱법을 ㅌ총해 얻을 수 있다.
#x(독립변수), y(종속변수) : x와 y는 원인과 결과의 관계를 갖는 변수여야 한다.

#부모의 IQ: 110,120,130,140,150
#자식의 IQ: 100,105,128,115,142

x <- c(110,120,130,140,150)
y <- c(100,105,128,115,142)
cor(x,y)  #0.8660744 양의 상관관계가 매우 강하다. 원인과 결과 관계? 있으면 선형회귀분석
plot(x,y)

#모델 작성 방법 1:직접 최소제곱법 수식을 사용

x_dev <- x - mean(x)
y_dev <- y - mean(y)
dev_mul <- (x - mean(x))*(y - mean(y))
square <- x_dev ** 2
df <- data.frame(x, y, x_dev, y_dev, dev_mul, square)
df
mean(df$x)
mean(df$y)
sum(df$dev_mul)
sum(df$square)
# y= wx+b
w <- sum(df$dev_mul) / sum(df$square)
w #0.94 - 기울기
b <- mean(df$y) - (mean(df$x) * w)
b
y= w*x+b  #선형회귀 모델 수식 완성
88*w+b
143*w+b

#모델 작성 방법 2:제공되는 함수를 사용
model <- lm(formula = y ~ x)   #내부적으로 최소제곱법을 사용 해 w, b를 구함
model
abline(model, col = 'blue')

predict(model, data.frame(x= c(88,143)))

#선형회귀: 변수간의 함수 관계를 파악하는 방법 중 하나로 독립변수가 종속변수애
# 미치는 영향을 파악하고 이를 통해 독립변수의 일정한 값에 대응하는 종속변수 값을
#예측(경향, 추론, 추측) 하는 모형산출 알고리즘이다. 
#------------------------------------------
df2 <- data.frame(workhour = 1:7, totalpay = seq(10000, 70000, by = 10000))
df2
#시간당 급여액에 대한 회귀분석
cor(df2$workhour, df2$totalpay)
plot(df2)
wmodel <- lm(formula = df2$totalpay ~ df2$workhour)
wmodel
abline(wmodel, col = 'blue', lwd = 2)
predict(wmodel)
grid()

#미지의 시간 당 급여액은?
predict(wmodel, data.frame(workhour = c(2.74,3.2,8.9)))


