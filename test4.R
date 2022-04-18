#데이터 입출력
n <- scan()
sum(1:n)

ss <- scan(what="")
ss

df <- data.frame()
df <- edit(df)
df

#파일 읽기
student <- read.table('testdata/student.txt')
student
is(student)

student2 <- read.table('testdata/student2.txt',sep = ';',
                       header = T) #, skip = 2
student2


student3 <- read.table('testdata/student3.txt',sep = ' ',
                       header = T, na.strings = '-')
student3

student4 <- read.table('testdata/student4.txt',sep = ',',
                       header = T, na.strings = '-')
student4

student5 <- read.csv('testdata/student4.txt',
                       header = T, na.strings = '-')
student5

install.packages("xlsx")
library(xlsx)
student6 <- read.xlsx('testdata/student.xlsx',sheetIndex = 1, 
                      encoding = 'utf-8')
student6

#------------------------------
#data 출력
x <- 10; y <- 20; z <- x*y
cat('결과는 ', z,'입니다.')
print(z)

cat(x, y, z)
#print는 한가지 값 만 출력가능

#파일로 출력
name <- c('관우','장비','유비')
age <- c(35,33,24)
gender <- c('m','m','f')

myframe <- data.frame(name, age, gender)
myframe
write.table(myframe,'output/my1.txt',fileEncoding = 'utf-8')
write.table(myframe,'output/my2.txt',row.names=T,fileEncoding = 'utf-8')
write.table(myframe,'output/my3.txt',row.names=F,fileEncoding = 'utf-8')
write.table(myframe,'output/my4.txt',row.names=T, quote=F,fileEncoding = 'utf-8') #따옴표 x

write.csv(myframe,'output/my5.csv',quote=F,row.names=F,fileEncoding = 'utf-8')

write.xlsx(myframe,'output/my6.xlsx', sheetName = 'sheet1')

#---------------------------------------
#도수 분포표
df <- read.csv('testdata/ex_studentlist.csv')
df

str(df)
summary(df)

# 명목형 자료로 도수분포표: gender, bloodType
#freq <- table(df$gender,df$bloodtype)
freq <- table(df$bloodtype) #명목형 자료 <- 빈도수
freq

rfreq <- prop.table(freq)  #상대도수 구하기
rfreq

rtable <- rbind(freq,rfreq)
rtable

rtable <- addmargins(rtable, margin = 1) #1-열의 합 ,2-행의 합
rtable
