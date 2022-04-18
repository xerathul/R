# Logistic Regression
#날씨 정보를 읽어 내일 비 유무 판단하기
weather <- read.csv('testdata/weather.csv')
head(weather)
dim(weather)  # 366  15
str(weather)
summary(weather)
colnames(weather)

weather_df <- weather[, c(-1,-6,-8,-14)]
head(weather_df)
str(weather_df)
summary(weather_df)
weather_df[!complete.cases(weather_df), ] #na가 있는 행 찾기
sum(is.na(weather_df))  #na의 개수 확인
weather_df <- na.omit(weather_df)
sum(is.na(weather_df))


unique(weather_df$RainTomorrow)  # "Yes" "No" 
# RainTomorrow 변수를 더미 변수화
weather_df$RainTomorrow[weather_df$RainTomorrow == 'Yes'] <- 1
weather_df$RainTomorrow[weather_df$RainTomorrow == 'No'] <- 0
weather_df$RainTomorrow <- as.numeric(weather_df$RainTomorrow)
head(weather_df)
str(weather_df)

#train/ test 모델의 과적합 방지 목적
dim(weather_df)  #361  11
set.seed(12)     #실습할 때만 
idx <- sample(1:nrow(weather_df), nrow(weather_df)*0.7)
train <- weather_df[idx,]
test <- weather_df[-idx,]
dim(train)  #252  11
dim(test)   #109  11

#model
wmodel <- glm(formula = RainTomorrow~., data=train, family = 'binomial')
wmodel
summary(wmodel)

#predict
pred <- predict(wmodel, newdata = test, type = 'response')
head(pred)
result_pred <- ifelse(pred >= 0.5, 1, 0)
head(result_pred)
result_pred
table(result_pred)
table(result_pred, useNA = 'ifany') #na도 결과에 참여여

#confusion matrix
t <- table(result_pred, test$RainTomorrow)
#accuracy of model
t
sum(diag(t))/nrow(test)

#분류모델의 평가: ROC curve
#ROC(Receiver Operating Characteristic) curve는 다양한 threshold에 대한 이진분류기의 성능을 한번에 표시한 것이다.
#이진 분류의 성능은 True Positive Rate와 False Positive Rate 두 가지를 이용해서 표현하게 된다.
#ROC curve를 한 마디로 이야기하자면 ROC 커브는 좌상단에 붙어있는 커브가 더 좋은 분류기를 의미한다고 생각할 수 있다.

#install.packages("ROCR")
library(ROCR)
pr <- prediction(pred, test$RainTomorrow)
prf <- performance(pr, measure = 'tpr', x.measure = 'fpr')
plot(prf)

#커브 선이 왼쪽상단에 가까울 수록 좋은 모델 이다.
#AUC


#이때 AUC (Area Under the ROC Curve)는 ROC curve의 밑면적을 말한다. 
#즉, 성능 평가에 있어서 수치적인 기준이 될 수 있는 값으로,
#1에 가까울수록 그래프가 좌상단에 근접하게 되므로 좋은 모델이라고 할 수 있다.


#AUC의 기준은 아래와 같다. 
#0.90-1 = excellent
#0.80-0.90 = good 
#0.70-0.80 = fair 
#0.60-0.70 = poor
#0.50-0.60 = fail

auc <- performance(pr, measure = 'auc')
auc <- auc@y.values   #여러값 중에서 y.values만 보겠다
auc[[1]] #good model

# 새 값으로 예측
new_data <- train[c(1:3),]
new_data <- edit(new_data)

new_pred <- predict(wmodel, newdata = new_data, type='response')
ifelse(new_pred>0.5, '비옴','안옴')
