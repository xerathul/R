#제어문
#조건 판단문 if
x <- 10; y <- 5
if(x+y>=10){
  cat('결과는', x+y)
  cat('\n참말이오')
}else{
  print('거짓이유')
}

if(x+y>=20){
  cat('결과는', x+y)
}else{
  print('거짓이유')
}
#3항연산자
ifelse(x>=5,'참','거짓짓')

install.packages("ggplot2")
library(ggplot2)

utils::head(mpg,2)
is(mpg)
mpg <- as.data.frame(ggplot2::mpg)
head(mpg,2)
?mpg
summary(mpg)
str(mpg)

#통합연비 칼럼 추가
mpg$total <- (mpg$cty +mpg$hwy)/2
summary(mpg)

if(mean(mpg$total)>=20){
  print('우수 연비')
}else{
  print('보통연비')
}

hist(mpg$total)

mpg$grade <- ifelse(mpg$total>=30, 'a',ifelse(mpg$total>=20,'b','c'))
summary(mpg$grade)
head(mpg,10)

#조선 판단문 switch
switch (비교구문, 실행1, 실행2...)
switch('age',id='hong',age=33,name='홍길동동')

a <- １
switch(a,mean(1:10),max(1:10))


#조건판단문 which
name <- c('kor','eng','french')
name
which(name=='kor')
#---------------------------
#반복문 : for while repeat
#반복문:for
i <- 0
for (n in i) {
  print(n)
}
for(su in 1:9){
  res=2 * su
  cat(2,'*',su,'=',res,'\n')
}
#반복문 while
i <- 0
while(TRUE){
  i=i+1
  print(i)
  if(i==3) break
}

#반복문 repeat
cnt<-1
repeat{
  print(cnt)
  cnt= cnt+2
  if(cnt>10) break
}
