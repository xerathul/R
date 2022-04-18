# iris dataset으로 다중 회귀분석
str(iris)

cor(iris[,-5])

nrow(iris) #150

#train/ test split(학습데이터와 검정 데이터로 분리해서 작업)
set.seed(12)
sam_tt <- sample(1:nrow(iris), nrow(iris)*0.7,replace = F) #비복원 샘플링(표본추출)
sam_tt
NROW(sam_tt)

train <- iris[sam_tt,]
test <- iris[-sam_tt, ]
dim(train)
dim(test)
head(train)
head(test)

#모델 작성 학습은 train
model <- lm(Sepal.Length~Sepal.Width+Petal.Length+Petal.Width , data = train)
summary(model)

#모델 충족 조건 확인이 필요하나 생략
par(mfrow=c(2,2))
plot(model)
#train 으로 학습하고 train으로 검증하면 그 결과는 모델이 정상이라면 결과가 유사
pred <- predict(model, train)
cat('실제값: ',train$Sepal.Length,'\n')
cat('예측값: ',round(pred,1))

#train 으로 학습하고 test로 검증한 결과가 유사해야 함,그 차이가 크면
#train data에만 최적화된 모델

pred2 <- predict(model, test)  #검정은 test
cat('실제값: ',test$Sepal.Length,'\n')
cat('예측값: ',round(pred2,1))

summary(test$Sepal.Length)
summary(pred2)
cor(pred2, test$Sepal.Length)
