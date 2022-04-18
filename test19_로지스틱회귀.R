# Logistic Regression
#독립변수 : 연속형, 종속변수: 법주형
#종속변수와 독립변수간의 관계를 통해서 분류 모델을 생성
#분류 결과는 이항분포를 따른다. 출력범위가 0 ~ 1 사이가 됨
# 출력을 위해 로지스틱 함수(시그모이드 함수)를 사용한다.
# 예: 생존/ 사망, 고객 부도 여부 , 최종 학력 등 범주형으로 결과를 분류하고자 할 때 사용

# 시험 성적, 내신 성적, 순위에 따른 대학원 합격여부 데이터로 분류 모델 작성

mydata <- read.csv('testdata/binary.csv')
head(mydata, 3)
str(mydata)

#독립변수: gre gpa rank, 종속변수:admit(범주형)
summary(mydata) # 데이터의 분포 확인

#admit, rank 변수로 빈도표 작성
xtabs(formula = ~ admit + rank, data = mydata)

table(mydata$admit,mydata$rank)

#분류모델 작성
#train/ test분리(7/3): 모델의 과적합(overfitting) 방지가 목적
set.seed(42)
idx <- sample(1:nrow(mydata), nrow(mydata) * 0.7)
train <- mydata[idx, ]  #280   4
test <- mydata[-idx, ]  #120   4
dim(train)
dim(test)
head(train)
head(test)

#로지스틱 회귀모델은 일반화된 선형회귀 모델
#model <- lm(formula = admit ~., data = train)  #선형회귀모델
lgmodel <- glm(formula = admit ~ ., data = train, family = binomial(link = 'logit'))#logit-오즈비에 루트

summary(lgmodel)

#예측 
pred <- predict(lgmodel, newdata = test, type = 'response') #type=response=0~1사이값으로 변환
pred
#cat('예측 값: ', head(pred,10))
cat('실제 값: ', head(test$admit),10)
cat('예측 값: ', head(ifelse(pred>0.5 , 1 ,0),10))
test

#분류 정확도 계산 
result_pred <- ifelse(pred>0.5,1, 0)
t <- table(result_pred, test$admit)
t
(80+9) / nrow(test)  #0.7416667 74.17%의 분류 정확도(accuracy)를 가진 모델
(t[1,1] + t[2,2]) / nrow(test)
sum(diag(t)) / nrow(test)

#새로운 값으로 분류하기
new_data <- train[c(1:3),]
new_data <- edit(new_data)
new_data
new_pred <- predict(lgmodel, newdata = new_data, type = 'response')
new_pred
new_pred <- ifelse(new_pred > 0.5,1,0)
new_pred

t1 <- table(new_pred, test$admit)
