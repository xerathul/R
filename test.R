?data
?typeof
typeof(scala)
?ls()


pairs(Petal.Width ~Petal.Length, pch = c(1:4)[iris$Species], data=iris)

install.packages("moments")
library(moments)
skewness(iris$Sepal.Length)
kurtosis(iris$Sepal.Length)

head(iris)
summary(iris)
subset(iris, i)
str(iris)

test <- subset(iris,select=-c(Sepal.Length,Species))
head(test,5)
head(iris)

name <- c("aa","bb","cc","dd")
gender <- c("F","M","M","F")
price <- c(50,65,45,75)  # 단위는 만원으로 가정
client <- data.frame(name,gender,price)
client
client$result <- ifelse(client$price>=65,'Best','Normal')
client

client$gender2 <- ifelse(client$gender=='M','Male','Female')
client

x <- c(2,3,5,6,7,10)
max(x)
min(x)
mean(x)

m <- matrix(1:12, nrow = 3)

t(m)
#----------------------
hf <- read.csv("testdata/galton.csv")
dim(hf)


hf1 <- subset(hf, hf$sex=='F')
head(hf1)
dim(hf1)
head(hf1)
summary(hf1)
cor(hf1$mother, hf1$height)
plot(height ~ mother, data= hf1)

model <- lm(height ~ mother, data= hf1)
summary(model)
abline(model)

predict(model, data.frame(mother = 61))
#------------------------15
library(MASS)
data("birthwt")
head(birthwt)
summary(birthwt)
#states <- as.data.frame(state.x77[, c('Murder','Population','Illiteracy','Income','Frost')])

data <- as.data.frame(birthwt[,c('bwt','age','lwt','smoke')])
head(data)
#mfit <- lm(formula = Murder ~Population+Illiteracy+Income+Frost, data = states)
model_data <- lm(formula = bwt ~ age + lwt + smoke,data = data)
summary(model_data)
newData <- data.frame("age"=c(30, 35),'lwt'=c(110, 120), 'smoke'=c(0, 1))
newData
predict(model_data,  newData)

