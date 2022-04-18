#비계층적(분할적) 분석 -  k-means
# 계층적 군집분석에 비해 큰 dataset에 효과적이며 , 관측치가 군집에 영구히
#할당되는 것이 최종결고를 개선시키는 방향으로 군집이 형성됨

data <- read.csv('testdata/exam.csv',sep = ' ',header = T)
head(data)
dim(data)

d_data <- dist(data, method = 'euclidean')
d_data

gra_data <- cmdscale(d_data)
plot(gra_data, type = 'n')

text(gra_data)
data

data$avg <- apply(data[,2:5], 1, mean)
#k-menas:k개 갯수?
#계층적 군집으로 k 개수를 얻을 수 있다. 또는 NbCluster를 사용할 수도 있다.
#install.packages("NbClust")
library(NbClust)
?scale
data_s <- scale(data[2:5])  #군집화 할 떄는 정규화 또는 표준화를 선행한다.
data_s  #표준화

#best 군집수 얻기
nc <- NbClust(data_s, min.nc = 2, max.nc = 5, method = 'kmeans')
#급격하게 떨어지다가 완만해지는 지점 : 4
nc
str(nc)
plot(table(nc$Best.nc[1,]))

model <- kmeans(data[, c('bun','avg')], 4)
model

table(model$cluster)
cluster <- model$cluster
cluster
str(cluster)

kmeans_df <- cbind(cluster, data[, c('bun','avg')])
kmeans_df
