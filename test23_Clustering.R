#계층적 군집분석 : 거리개념을 기본으로 군집화를 할 떄 가까운 데이터 끼리순차적으로
#군집을 형성해가는 웅집형 계층적 군집화
#hclust(거리(datafame),method=" ")

x <- c(1,2,3,4,5)
y <- c(1,1,4,3,4)
xy <- data.frame(cbind(x,y))
xy

plot(xy, pch = 20, xlab = 'x값', ylab = 'y값', xlim=c(0,6), ylim=c(0,6))
text(xy[,1], xy[,2], labels = abbreviate(rownames(xy)),cex = 0.8, pos = 1, col = 'blue')

dist(xy, method = 'euclidean') ^2

#덴드로그램으로 군집 결과 보기

hc_sl <- hclust(dist(xy)^2,method = 'single' ) #method= ward, single, complete, average...
hc_sl
plot(hc_sl, hang = -1)

hc_sl <- hclust(dist(xy)^2,method = 'complete' ) #method= ward, single, complete, average...
hc_sl
plot(hc_sl, hang = -1)

#--------------------
body <- read.csv('testdata/bodycheck.csv')
str(body)

d <- dist(body[,-1], method = "euclidean")
d

hc <- hclust(d, method = 'complete')
hc
plot(hc, hang = -1)

rect.hclust(hc, k=3, border = 'red')

library(cluster)
g1 <- subset(body, 번호 == 10|번호== 4|번호== 8|번호== 1|번호== 15)
g2 <- subset(body, 번호 == 11|번호== 3|번호== 5|번호== 6|번호== 14)
g3 <- subset(body, 번호 == 2|번호== 9|번호== 13|번호== 7|번호== 12)
g1[2:5]
g3[2:5]
g2[2:5]

summary(g1[2:5])
summary(g2[2:5])
summary(g3[2:5])
