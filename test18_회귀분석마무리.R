#mtcars dataset으로 단순 / 다중 선형회귀

head(mtcars)
str(mtcars)
dim(mtcars)

#연습1- 단순선형회귀
# 임의의 마력수(hp)를 입력하면 연비는 얼마일까? 이를 위한 모델 작
#hp: 독립변수 (연속형), mpg: 종속변수(연속형)

cor(mtcars$hp,mtcars$mpg)   #-0.7761684 반비레 관계 
par(mar=c(1,1,1,1))
plot(mpg ~ hp, data = mtcars, xlab='hp', ylab = 'mpg')

model <- lm(formula=mpg~hp, data = mtcars)
model
summary(model)  # p-value: 1.788e-07  R-squared:  0.6024,

abline(model)

#예측값 얻기
new_hp=110
cat('예측값: ',-0.06823*new_hp+30.09886)

new_hp=160
cat('예측값: ',-0.06823*new_hp+30.09886)

new_hp=70
cat('예측값: ',-0.06823*new_hp+30.09886)

#predict() 함수 사용
mynew <- mtcars[c(1,2),]
mynew <- edit(mynew)
mynew
pred <- predict(model, newdata = mynew)
cat('예측값: ',pred)
pred
#연습2- 다중선형회귀
# 임의의 마력수(hp)와 차무게(wt)를 입력하면 연비는 얼마일까? 이를 위한 모델 작
#hp,wt: 독립변수 (연속형), mpg: 종속변수(연속형)

cor(mtcars$hp, mtcars$mpg)
cor(mtcars$wt, mtcars$mpg)

model2 <- lm(formula = mpg ~ hp+wt, data = mtcars)
model2   # y = -0.03177 * new_hp + -3.87783 * new_wt + 37.22727 수식완성

new_hp= 110; new_wt = 2.62
cat('예측값: ',-0.03177 * new_hp + -3.87783 * new_wt + 37.22727)

new_hp= 160; new_wt = 6.62
cat('예측값: ',-0.03177 * new_hp + -3.87783 * new_wt + 37.22727)

new_hp= 80; new_wt = 2.0
cat('예측값: ',-0.03177 * new_hp + -3.87783 * new_wt + 37.22727)

#predict
new_data <- data.frame(hp=110, wt=2.62)
predict(model2,newdata = new_data)

new_data <- data.frame(hp=160, wt=5.62)
predict(model2,newdata = new_data)

new_data <- data.frame(hp=80, wt=1.62)
predict(model2,newdata = new_data)
