#친밀도, 적절성, 만족도 변수로 상관분석
result <- read.csv('testdata/drinking_water.csv', fileEncoding = 'UTF-8')
head(result)

summary(result)

#공분산(힘의 관계)
cov(result$친밀도, result$적절성)
#상관계수\
cor(result$친밀도, result$적절성, method = 'pearson')
cor(result)
?cor

cor(result$친밀도+ result$적절성, result$만족도)

#시각화
plot(result$친밀도+ result$적절성, result$만족도)

symnum(cor(result))

#install.packages("corrgram")
library(corrgram)
corrgram(result)
corrgram(result, upper.panel = panel.conf)
corrgram(result, lower.panel = panel.conf)

#install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)

chart.Correlation(result, histogram = , pch = '+')

#-----------------------참고형
cor(result, method = 'spearman')
cor(result, method = 'kendall')
