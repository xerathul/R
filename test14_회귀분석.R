#cars dataset으로 선형회귀 분석
head(cars,3)
dim(cars)  #50 20 속도와 제동거리(연속형)
cor(cars$speed, cars$dist)#0.8068949
plot(cars$speed, cars$dist)

model <- lm(formula = cars$dist~ cars$speed)
summary#p-value: 1.49e-12 유의미 R-squared:  0.6511 설명력(정확도와 다름)
abline(model)
names(model)
coef(model)
summary(model)$r.squared  #r-squared값만 보기
anova(model)
confint(model)

