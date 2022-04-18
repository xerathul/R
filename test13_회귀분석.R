#iris dataset으로 선형회귀 분석 : 상관관계와 회귀모델의 적합성
head(iris)
cor(iris[, 1:4])
cor(iris[,-5])

#연습1: 상관관계가 약한 변수로 모델 작성
cor(iris$Sepal.Length, iris$Sepal.Width)   #-0.1175698
plot(iris$Sepal.Length, iris$Sepal.Width)
model1 <- lm(formula = Sepal.Length~ Sepal.Width, data= iris)
summary(model1)#p-value: 0.1519>0.05이므로 적합한 모델이 아님. Multiple R-squared:  0.01382
abline(model1, col = 'blue', lwd = 2)

#연습2: 상관관계가 강한 변수로 모델 작성
cor(iris$Sepal.Length, iris$Petal.Length) #0.8717538
plot( iris$Petal.Length, iris$Sepal.Length)
model2 <- lm(formula = iris$Sepal.Length~iris$Petal.Length)
summary(model2)  #p-value: < 2.2e-16<0.05 이므로 적합한 모델 R-squared:   0.76 76%의 설명력
abline(model2)

#회귀분석모형의 적절성을 위한 조건을 충족해야 함
#...
