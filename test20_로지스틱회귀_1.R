# # Logistic Regression
# 날씨 정보를 읽어 내일 비 유무 판단하기
weather <- read.csv("testdata/weather.csv")
head(weather, 3)
dim(weather)  # 366  15
str(weather)
summary(weather)
colnames(weather)

weather_df <- weather[, c(-1, -5, -6, -8, -14)] # 필요없는 컬럼 제거
head(weather_df, 3)
str(weather_df)

unique(weather_df$RainTomorrow)  # Yes, No 값 밖에 없다는걸 확인

# RainTomorrow 변수를 더미(dummy)변수화
weather_df$RainTomorrow[weather_df$RainTomorrow == 'Yes'] <- 1
weather_df$RainTomorrow[weather_df$RainTomorrow == 'No'] <- 0
head(weather_df, 3)
str(weather_df) # 확인해보니 RainTomorrow가 chr로 되어있음
weather_df$RainTomorrow <- as.numeric(weather_df$RainTomorrow) # Numeric으로 바꿔줌

# train / test
dim(weather_df)  # 366  10
set.seed(12) # 현실세계에선 안됨. 편안하게 똑같은 값으로 해서 보기편하게 하려고 일부러 주는거임
idx <- sample(1:nrow(weather_df), nrow(weather_df) * 0.7) # 샘플링을 통해 7:3으로 나눔
train <- weather_df[idx,]
test <- weather_df[-idx,]
dim(train); dim(test)  # 256 10, 110 10

# model
weather_model <- glm(RainTomorrow ~ ., data=train, family='binomial')
weather_model
summary(weather_model)

# 예측
pred <- predict(weather_model, newdata=test, type='response') # train으로 학습하고 test로 검정한다
head(pred, 10)

result_pred <- ifelse(pred >= 0.5, 1, 0)

table(result_pred)
table(result_pred, useNA = 'ifany')  #NA도 결과에 참여하게 한다.

# confusion matrix
t <- table(result_pred, test$RainTomorrow)
# 분류모델의 정확도 (Accuracy)
sum(diag(t)) / nrow(test)   # 0.8545455  85%의 분류정확도

# 분류모델의 평가 : ROC curve
# ROC(Receiver Operating Characteristic) curve는 다양한 threshold에 대한 이진분류기의 성능을 한번에 표시한 것이다.
# 이진 분류의 성능은 True Positive Rate와 False Positive Rate 두 가지를 이용해서 표현하게 된다.
# ROC curve를 한 마디로 이야기하자면 ROC 커브는 좌상단에 붙어있는 커브가 더 좋은 분류기를 의미한다고 생각할 수 있다.

install.packages('ROCR')
library(ROCR)

pr <- prediction(pred, test$RainTomorrow)
pr
prf <- performance(pr, measure = 'tpr', x.measure = 'fpr')
plot(prf)
# 곡선이 왼쪽 상단에 가까울 수록 좋은 모델로 판정함.