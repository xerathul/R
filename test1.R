# va<-1
# va<-2
# va=3
4->va
cat('결과는 ',va)
print(va)

# 데이터 유형
kbs <-9   #스칼라는 지원 x , 기본이 벡터 값
object.size(kbs)
typeof(kbs)
typeof(3)
typeof(3.14)
is(kbs) # 데이터 유형 출력
mbc <- as.integer(kbs)
mbc
is(kbs)
is(mbc)
typeof(kbs)

mbc <- 9L
is(mbc)

ss <- '홍길동'
typeof(ss)
is(ss)
ss[1]
ss[0]

b<- TRUE  # 다 대문자
is(b)

b<- T
is(b)

#Vector 가 기본 값: character, logical, numeric(integer)

typeof(NA)
aa <- NA # 결측 데이터 (값이 입력되지 않은 상태)
aa
is(aa)

sum(2,3)
sum(2,3,NA) #결측 값이 있으면 전체가 NA
sum(2,3,NA, na.rm=T)

typeof(NULL)  # 데이터 값이 없음(값 으로 인식 되지 않음)
sum(2,3,NULL) #무시된다

typeof(NaN) #수학적으로 정의되지 않은 값(하나의 값으로  인식됨)
sum(2,3,NaN) #NaN

typeof(Inf)   #무한대
0/0

0*Inf
Inf-Inf

length(NA)
length(NaN)
length(NULL)

z <- 5.3 - 3i
z
is(z)

f<- function(){
  return('good')
}
f()
is(f)
typeof(f)

# x<-123.4
# x<-'123'
x<- F
cat(mode(x), class(x), typeof(x))

ls() #현재 사용중인 객체의 목록 확인 함수
ls.str()
rm(aa)  #변수 삭제 함수
rm(list=ls())  #모든 변수 삭제
gc()    #garbage Collector

# ctrl+L 콘솔 삭제

#-------------
#package:데이터+함수+알고리즘 꾸러미

available.packages()
dim(available.packages())

install.packages('plyr')
library(plyr)
ls('package:plyr')
data(package='plyr')
baseball
remove.packages('plyr')

# 기본 dataset: 연습용 데이터 제공
data()

Nile
head(Nile)   #앞에 6개
tail(Nile,3)

hist(Nile, freq = F)
lines(density(Nile))

help("hist")
?hist

?mean
x <- c(0:10, 50)
x
xm <- mean(x)
xm
c(xm, mean(x, trim = 0.10))
?c
getwd()

head(iris,3)
iris
