#2장 해답 https://rpubs.com/Minji-Hong/597820
#코드2들이 어떻게 변하는지를 맞춰보자

#코드2-3
log(10)+5
sqrt(25)
max(5,3,2)
abs(-10)
factorial(5)
sin(pi/2)

#코드2-4
a <- 10
b <- 20
c <- a+b
print(c) # alt+ '-' 누르면 자동으로 <-입력됨

#코드2-6
a<-20
b<-30
a+b
a<-"A"
a+b

#벡터는 데이터 구조의 가장 기본적 형태로, 1차원 형태의 데이터를 저장할 수 있다
#벡터를 생성하는데 사용되는 함수는 c()함수이다

#코드2-7
x <- c(1,2,3)
y <- c("a","b","c")
z <- c(TRUE, TRUE, FALSE)
x
y
z

#코드2-8
w <- c(1,2,3, "a","b","c")
w

#코드2-9
v1 <- 50:90
v1

v2 <- c(1,2,5, 50:90)
v2

#코드2-10 일정한 간격의 숫자
v3 <- seq(1,101,3)
v3

v4 <- seq(0.1,1.0,0.1)
v4

#코드2-11 반복된 숫자
v5 <- rep(1,times=5)
v5
v6 <- rep(1:5, times=3) # 1에서 5까지 3번 반복
v6
v7 <- rep(c(1,5,9), times=3) # 1,5,9를 3번 반복
v7

#코드2-12 벡터 원소값에 이름 지정
score <- c(90, 85, 70)
score
names(score) #NULL은 아무것도 없다는 의미
names(score) <- c("John","Tom","Jane") #값의 이름은 따옴표로 묶여진 문자열이여야 함
#또 값들의 이름은 서로 달라야 한다. 같아도 에러는 발생하지 않지만 나중에 문제가 됨
names(score)
score #이름과 함께 값이 출력 됨, 이 값은 연산 시 일종의 주석이고 연산을 할 때 값에 붙어있는 이름은 무시하고 작업함

#코드2-13
d <- c(1,4,3,7,8)
d[1]
d[2]
d[3]
d[4]
d[5]
d[6]

#코드2-14
d[c(1,3,5)]
d[1:3]
d[seq(1,5,2)]
d[-2] #2번째 값 제외하고 출력
d[-c(3:5)] #3-5번째 값 제외하고 출력

#코드2-15
GNP <- c(2090, 2450, 960)
GNP
names(GNP) <- c("Korea","Japan","Nepal")
GNP
GNP[1]
GNP["Korea"]
GNP[c("Korea","Nepal")]

seq(1,100,2) #앞에 붙어있는 [24]등의 기호는 그 뒤에 있는 변수가 24번째 변수라는 이야기

#코드2-16
v1 <- c(1,5,7,8,9)
v1
v1[2] <- 3 #v1의 2번째 값을 3으로 변경
v1
v1[c(1,5)] <- c(10,20) #v1의 1, 5번째 값을 각각 10, 20으로 변경
v1

#코드2-17
d <- c(1,4,3,7,8)
2*d
d-5
3*d+4

#코드2-18
x <- c(1,2,3)
y <- c(4,5,6)
x+y
x*y #대응하는 원소끼리 곱하고 더하여 출력
z <- x + y
z

#코드2-19
d <- c(1,2,3,4,5,6,7,8,9,10)
sum(d)
sum(2*d)
length(d)
mean(d[1:5])
max(d)
min(d)
sort(d) #오름차순 정렬
sort(d, decreasing = FALSE) #오름차순 정렬
sort(d, decreasing = TRUE) #내림차순 정렬, d, decreasing 처럼 매개변수 2개를 필요로 한다. decreasing은 매개변수명이고, FALSE, TRUE는 매개변수 값임

v1 <- median(d)
v1
v2 <- sum(d)/length(d)
v2

#매개변수 = parameter
sort(x = d, decreasing =TRUE) #정상작동
sort(x = d, TRUE) #parameter명 안써도 작동함 순서만 맞으면 됨
sort(d, TRUE) #정상작동
sort(TRUE, d) #에러
sort(d) #정상작동, 매개변수명 default로 작동되도록 정의되어 있기 때문

#코드2-20 (주의)
#논리연산자란 연산의 결과가 TRUE또는 FALSE로 출력되는 연산자를 말한다
#A == B, A와 B가 같으면 TRUE
#A != B, A와 B가 같지 않으면 TRUE
#A | B, A 또는 B 어느 한쪽이라도 TRUE면 TRUE
#A & B A와 B 모두 TRUE일 때만 TRUE

d <- c(1,2,3,4,5,6,7,8,9)
d >= 5
d[d>5]
sum(d>5) #(주의) TRUE를 sum하라는 뜻임! FALSE TRUE로 반환된다는 사실을 기억!
#논리값이 산술연산에 사용되면 FALSE는 0으로, TRUE는 1로 간주된다
TRUE+TRUE
sum(d[d>5]) #(주의) 5보다 큰 값의 합계를 출력

condi <- d > 5 & d <8
d[condi]

#여러개의 벡터를 합쳐 새로운 벡터 만들기
x <- c(1,2,3)
y <- c(4,5)
c(x,y)
z <- c(x,y)
z

#코드2-21
ds <- c(90, 85, 70, 84)
my.info <- list(name='Tom', age=60, status=TRUE, score=ds) #리스트는 1차원 자료구조이면서 다양한 자료형들의 값을 저장할 수 있다.
my.info #리스트에 저장된 내용을 모두 출력
my.info[[1]] #리스트의 첫 번째 값을 출력, 벡터와는 달리 저장된 값들이 세로 방향으로 출력된다. 
# 개 중요한 점은 [1]이 아닌 [[1]]을 써야된다는 점!
my.info[[4]] 
my.info$name #리스트에서 값의 이름이 name인 값을 출력

#코드2-22
#factor는 문자형 데이터가 저장된 벡터의 일종이다. 문자형 벡터를 만든 뒤 factor()함수를 이용하여 변환
bt <- c('A', 'B', 'B', 'O', 'AB', 'A') #문자형 벡터 bt 정의'
bt.new <- factor(bt)
bt
bt.new #factor로 만드니 큰따옴표가 사라졌다! factor의 목적이 어떤 종류를 나타내는 문자값을 저장하는 것이기 때문
bt[5]
bt.new[5]
levels(bt.new) #factor에 저장된 값의 종류를 출력
as.integer(bt.new) #factor의 문자값을 숫자로 바꾸어 출력 (중요) 저장된 문자값을 숫자로 바꾸어 분석 작업에 활용할 수 있다!
bt.new[7] <- 'B'
bt.new[8] <- 'C' #factor의 역할 중 하나는 이미 지정된 값의 종류 외에 다른 값이 들어오는 것을 막는 것!
bt.new

#chapter2. 연습문제 
#1번
25+99
456-123
2*(3+4)
(3+5*6)/7
(7-4)*3
210+35
1256%%7
184%%5
1976/24
16*25+186*5-67*22

#2번
a <-4
b <-5
c <- a + b
c

#3번
pi <- 3.14
a <- c(10,12,15)
area <- pi * a^2
area

#4번
y <- 2*x^2 + 5*x + 10
x <- c(6,8,10)
y

#5번
#val.b가 지정이 안되어있음. 지정해줘야됨
val.a <- 10
val.b <- 10
sum.ab <- val.a + val.b

#6번
vc.1 <- c(95,86,47,55,68)
print(vc.1)

#7번
vc.2 <- seq(100,200,2)
print(vc.2)

#8번
vc.3 <- rep(TRUE,20)
print(vc.3)

#9번
d <- c(100:200)
print(d)

d[10]

d[-c(92:101)] #

d[seq(2,101,2)] #

d[seq(3,101,3)] #

d.20 <- d[1:20]

d.20[-5]

d.20[-c(5,7,9)] #


#10번 #
absent <- c(10, 8, 14, 15, 9, 10, 15, 12, 9, 7, 8, 7)
absent
names(absent) <- c("JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC")
absent

absent["MAY"]
absent[c("JUL","SEP")]
sum(absent[c(1:6)])
mean(absent[c(7:12)])

#11번 #
d1 <- c(1:50)
d2 <- c(51:100)

print(d1)
print(d2)

length(d2)

print(d1+d2)
print(d2-d1)
print(d1*d2)
print(d2/d1)

sum(d1)
sum(d2)

sum(d1) + sum(d2)

max(d2)
min(d2)

mean(d2)
mean(d1)
mean(d2) - mean(d1)

sort(d1, decreasing=TRUE)

d1 <- sort(d1, decreasing=FALSE)
d2 <- sort(d2, decreasing=FALSE)
d1.new <- d1[c(1:10)]
d2.new <- d2[c(1:10)]
d3 <- c(d1.new, d2.new)

#12번
v1 <- 51:90

print(v1[v1 < 60])

length(v1[v1 < 70])

sum(v1[v1>65])

v1[v1<65|v1>80]

v1[v1%%7==3]

v1[v1%%7==0] <- 0 

sum(v1[v1%%2==0])

v1[v1%%2==1 | v1>80]

v1[v1%%3==0 & v1%%5==0]

v1[v1%%2==0] <- v1[v1%%2==0]*2 #

v1[v1%%7!=0] #


#3장 matrix and dataframe
#matrix의 셀에 저장되는 값은 동일한 자료형이여야 하고, 
#자료형이 다른 컬럼들로 구성 된 데이터 테이블은 데이터프레임의 형태로 저장되고 활용됨

#코드3-1
z <- matrix(1:20, nrow = 4, ncol = 5)

#코드3-2 열방향 말로 행방향으로 채우기
z2 <- matrix(1:20, nrow = 4, ncol = 5, byrow=T)

#코드3-3
x <- 1:4
y <- 5:8
z <- matrix(1:20, nrow=4, ncol = 5)

m1 <- cbind(x,y)
m1
m2 <- rbind(x,y)
m2
m3 <- rbind(m2,x)
m3
m4 <- cbind(z,x)
m4

#코드3-4
z <- matrix(1:20, nrow=4, ncol=5)
z
z[2,3]
z[1,4]
z[2,] #숫자를 생략하면 모든 열이 값을 의미한다!
z[,4]

#코드3-5
z <- matrix(1:20, nrow=4, ncol=5)
z
z[2,1:3]
z[1,c(1,2,4)]
z[1:2,]
z[,c(1,4)]

#코드3-6
score <- matrix(c(90,85,69,78,
                  85,86,49,95,
                  90,80,70,60),
                  nrow=4, ncol=3)
score
rownames(score) <- c('John','Tom','Mark','Jane')
colnames(score) <- c('English','Math','Science')
score

#코드3-7
score['John','Math']
score['Tom',c('Math','Science')]
score['Mark',]
score[,'English']
rownames(score)
colnames(score)
colnames(score)[2]

#코드3-8
city <- c("Seoul","Tokyo","washington")
rank <- c(1,3,2)
city.info <- data.frame(city, rank) #데이터프레임을 만든 후에는 매트릭스와 동일한 방법으로 다룰 수 있다
#동일한 방법으로 행의 이름과 열의 이름을 지정할 수 있고, 프레임 안에 있는 값을 추출하는 방법도 매트릭스와 동일

iris #4개의 숫자형 열과 1개의 문자형 열이므로 iris는 데이터프레임임

#코드3-9
iris[,c(1:2)]
iris[,c(1,3,5)]
iris[,c("Sepal.Length","Species")]
iris[1:5,]
iris[1:5,c(1,3)]

#코드3-10
dim(iris) #행과 열의 개수 출력
nrow(iris) #행 개수 출력
ncol(iris) #열 개수 출력
colnames(iris)
head(iris)
tail(iris)

#코드3-11
str(iris) #데이터셋 요약 정보 보기
iris[,5] #품종 데이터 보기
unique(iris[,5]) #중복 제거!!
table(iris[,"Species"]) #품종의 종류별 행의 개수 세기
table(iris[,5]) #Table()함수는 그룹을 나타내는 값이 포함된 자료에서 각 그룹별로 몇개의 관측치가 존재하는지 출력함 = 도수분포표

#코드3-12
colSums(iris[,-5]) #열별 합계, 5번째 행 빼고 나머지는 더해라
colMeans(iris[,-5]) #열별 평균
rowSums(iris[,-5]) #행별 합계
rowMeans(iris[,-5]) #행별 평균

#코드3-13
#transpose 함수
z <- matrix(1:20, nrow=4, ncol=5)
z
t(z)

#코드3-14
#조건에 맞는 행과 열의 값 추출
#중간에 줄바꿈을 할때 콤마, &, | 와 같이 이후에 어떤 내용이 따라온다고 암시하는 기호 뒤에서 줄바꿈을 하는 것이 좋다
#subset함수는 매트릭스에서는 작동이 잘 되지 않고 df에서 작동이 되니 주의하자. 매트릭스에 subset() 하고싶으면 데이터프레임으로 변환 한 후에 실행한다
IR.1 <- subset(iris, Species=="setosa")
IR.1
IR.2 <- subset(iris, Sepal.Length > 5.0 & Sepal.Width > 4.0)
IR.2
IR.2[, c(2,4)] #IR.2에서 2, 4열의 값만 추출

#코드3-15
a <- matrix(1:20, 4, 5)
b <- matrix(21:40, 4, 5)
a
b
2*a
3*b
2*a + 3*b

a+b #이것들을 실행하려면 두 매트릭스의 크기(행과 열의 개수)가 같아야 한다
b-a
b/a
a*b

a <- a*3 #a*3까지면 하면 결과만 보여주니까 a에 다시 넣어줌
b <- b-5

#코드3-16
class(iris) #iris 데이터셋의 자료구조 확인
class(state.x77)
is.matrix(iris) #데이터셋이 매트릭스인지 확인하는 함수
is.data.frame(iris) #데이터셋이 데이터프레임인지를 확인하는 함수
is.matrix(state.x77)
is.data.frame(state.x77)

#코드3-17
st <- data.frame(state.x77) #매트릭스를 데이터프레임으로 변환
head(st)
class(st)

iris.m <- as.matrix(iris[,1:4]) #데이터프레임을 매트릭스로 변환할때 주의할 점! 매트릭스에 저장되는 모든 값의 자료형이 동일해야 함. 안그러면 변환 오류남
head(iris.m)
class(iris.m)

#코드3-18
iris[,"Species"] #결과=벡터, 매트릭스 데이터프레임 둘다 가능
iris[,5] #결과=벡터, 매트릭스 데이터프레임 둘다 가능
iris["Species"] #결과=데이터프레임, 데이터프레임만 가능
iris[5] #결과=데이터프레임, 데이터프레임만 가능
iris$Species #결과=벡터, 데이터프레임만 가능

#코드3-19
setwd("C:/Users/nells/Downloads/R_study_source/Ch03") #set work directory = 작업 폴더 지정
air <- read.csv("airquality.csv", header=T) #csv파일 읽기
head(air)

#코드3-20
setwd("C:/Users/nells/Downloads/R_study_source/Ch03")
my.iris <- subset(iris, Species=='setosa')
write.csv(my.iris, "my_iris.csv", row.names=F) #row.names 행 번호를 붙이지 마라

air <- read.csv("C:/Users/nells/Downloads/R_study_source/Ch03/airquality.csv", header=T)
air <- read.csv(file.choose(), header=T) #직접 찾아서 가져올 수도 있다!!!!!!

#3장 요약
#매트릭스는 2차원 테이블 형태의 자료구조이며 모든 셀에 저장되는 값이 동일한!!! 자료형이다!

#chapter3. 연습문제 
#1번 (1-1, 1-2, 1-4)
score <- matrix(c(10,40,60,20,21,60,70,30),
                nrow=4, ncol=2)

colnames(score) <- c('m','f')

score

colnames(score) <- c('male','female')

score[2,]

score[,2]; score[,'female']

score[3,2]


#2번 (2-7, 2-9, 2-15, 2-18)
class(state.x77)
st <- data.frame(state.x77)

st
head(st)

rownames(st)

colnames(st)

dim(st)

str(st) #구조

apply(st, 1, mean) #1이 행별이라는 뜻임 행별로 mean을 구하겠다는 뜻임; 
rowMeans(st) #로 해도 됨

apply(st, 2, sum)
colSums(st)

st['Florida',]

st[,'Income']

st['Texas','Area']

st['Ohio',c('Population','Income')]

#subset을 통해서 조건을 만족하는 것을 출력하게 된다!
subset(st, Population >= 5000)

subset(st, Income >= 4500, select = c('Population', 'Income', "Area")) #subset 조건에서는 쉼표를 안붙이나봄 ㄷㄷ

nrow(subset(st, Income >= 4500))

subset(st, Area >= 100000 & Frost >= 120)

subset(st, Population < 2000 & Murder < 12)
subset(st, Population < 2000 , Murder < 12) #,로 구분해도 되는데 &로 구분하는게 낫다

mean(subset(st, Illiteracy >= 2.0)$Income)

abs(mean(subset(st, Illiteracy >= 2.0)$Income) - mean(subset(st, Illiteracy < 2.0)$Income))

max(st$Life.Exp)
rownames(subset(st, Life.Exp==max(st$Life.Exp)))

pen_income <- st['Pennsylvania','Income'] #행, 열로 해서 찾은거임
rownames(subset(st, Income > pen_income))


#3번 #3-3은 꼭 안해도 됨
class(mtcars)

dim(mtcars)

class(mtcars)

for(i in 1:ncol(mtcars)){
  cat("col",i, ":", class(mtcars[,i]),"\n")
}

?mtcars

rownames(subset(mtcars, mpg == max(mtcars$mpg)))

rownames(subset(mtcars, mpg == min(subset(mtcars,gear==4)$mpg)))

tmp <- subset(mtcars, gear == 4)
rownames(subset(tmp, mpg == min(tmp$mpg)))

mtcars['Honda Civic',c('mpg','gear')]

rownames(subset(mtcars, mpg > mtcars['Pontiac Firebird','mpg']))

mean(mtcars$mpg)

unique(mtcars[,"gear"])


#4번(4-6번)
class(airquality)

head(airquality)

subset(airquality, Temp == max(airquality$Temp), select = c("Month", "Day"))

df <- subset(airquality, Month == 6)
max(df$Wind)

mean(subset(airquality, Month == 7)$Temp)
mean(airquality[airquality$Month==7, 'Temp'])

mean(subset(airquality, Month == 5)$Ozone, na.rm=T) #na.rm=T를 붙여라

nrow(subset(airquality, Ozone > 100))


#5번(5-3번)
swiss
str(swiss)

rownames(subset(swiss, Agriculture == max(swiss$Agriculture)))

swiss[order(swiss$Agriculture, decreasing = TRUE),] #5-3은 꼭 안해도됨

subset(swiss, Catholic >= 80, select = Agriculture)

subset(swiss, Examination < 20 & Agriculture <50, select = c('Examination', 'Agriculture'))


#6번(6-1번, 6-2번)
setwd('C:/Users/nells/Downloads/R_study_source/Ch03')
class(state.x77)
df <- data.frame(state.x77) #subset은 data.frame형태의 값이 아니면 조건을 인지하지 못함
df2 <- subset(df, Income >= 5000, c('Income','Population','Area'))
write.csv(df2, file = 'df2.csv', row.names = TRUE)

ds <- read.csv('df2.csv', header=T)


#4장
#R에서 제공하는 함수를 사용하여 작업할 수 있지만, 프로그래밍 기법을 적용해야 가능한 분석도 있다.
#그리고 그 프로그래밍의 기본이 되는 것이 바로 조건문, 반복문, 사용자 정의 함수!

#코드4-1
job.type <- 'A'
if(job.type == 'B'){
  bonus <- 200
} else {
  bonus <- 100
}
print(bonus)


#주의!!!! 이렇게 쓰면 에러난다! 반드시 if문의 코드블록이 끝나는 부분과 같은 줄에 else를 작성해야 한다!!
job.type <- 'A'
if(job.type == 'B'){
  bonus <- 200
} 
else {
  bonus <- 100
}

#코드4-2 (else가 생략된 if-else 구문)
job.type <- 'B'
bonus <- 100
if(job.type == 'A'){
  bonus <- 200
}
print(bonus)



#코드4-3* 퀴즈! score >90이면 A, 80~90이면 B, 70~80이면 C, 아니면 F인 구문을 만들어라. (다중 if-else 문)
score <- 85
if (score > 90){
  grade <- 'A'
} else if (score > 80){
  grade <- 'B'
} else if (score > 70){
  grade <- 'C'
} else if (score > 60){
  grade <- 'D'
} else {
  grade <- 'F'
}

print(grade)

#코드4-4 (조건문에서 논리연산자의 사용) &는 and, |는 or
a <- 10
b <- 20
if(a>5 & b>5){
  print(a+b)
}
if(a>5 | b>10){
  print(a*b)
}

#코드4-5 ifelse문 원래는 if 따로 else 따로인데 두 값중 하나 선택이라면 ifelse가 낫다!
#if와 else 따로 썼을 경우
a <- 10
b <- 20

if (a>b){
  c <- a
} else {
  c <- b
}
print(c)

#ifelse 쓴 경우 (훨씬 간편하다)
c <- ifelse(a>b, a, b)
print(c)



#코드4-6* 퀴즈! 반복문! *를 5번 출력하라
#for(반복 변수 in 반복 범위)
for(i in 1:5){
  print('*')
}

#코드4-7 반복 범위에 따른 반복 변수의 값 변화
for(i in 6:10){
  print(i)
}



#코드4-8* 퀴즈! 문) 2단 구구단을 for문으로 작성해라
for(i in 1:9){
  cat("2 *",i,"=",2*i,'\n') #\n은 줄 바꿈을 하는 특수문자
} #print문은 하나의 값을 출력할 때 사용하고 cat함수는 한 줄에 여러 개의 값을 결합하여 출력할 때 사용



#코드4-9* 퀴즈! 문) for, if 문 사용하여 1~20중 짝수만 출력해라
for (i in 1:20){
  if (i%%2 == 0){
    print(i)
  }
}



#코드4-10* 퀴즈! 문) for 이용하여 1~100 사이의 숫자 합계를 출력하라
sum <- 0
for (i in 1:100){
  sum <- sum + i
}
print(sum)



#코드4-11* 퀴즈! petal.Length에 따라 1.6이하이면 'L', 5.1이상이면 'H', 나머지는 'M'으로 분류
norow <- nrow(iris)
mylabel <- c()

for (i in 1:norow){
  if (iris$Petal.Length[i] <= 1.6){
    mylabel[i] <- 'L'
  } else if (iris$Petal.Length[i] >= 5.1) {
    mylabel[i] <- 'H'
  } else {
    mylabel[i] <- 'M'
  }
}

print(mylabel)
newds <- data.frame(iris$Petal.Length, mylabel)
head(newds)



#코드4-12* 퀴즈! 문) 1~100까지 숫자의 합계를 while문을 이용해서 구하라 
#while문은 어떤 조건이 만족하는 동안 코드블록을 수행하고, 그 조건이 거짓일 경우 반복문을 종료함

sum <- 0
i <- 1
while (i <= 100){
  sum <- sum + i
  i <- i +1
}
print(sum)


#코드4-13 #break과 next는 for문 while문에서 다 쓰일 수 있다 #python의 break과 동일하며 next는 continue와 동일하다!
sum <- 0
for (i in 1:10){
  sum <- sum + i
  if (i>=5) break
}
sum


#코드4-14
sum <- 0 
for (i in 1:10){
  if (i%%2 == 0) next
  sum <- sum + i
}
sum


#코드4-15* 퀴즈! (apply 함수!) iris의 1~4행의 행방향 mean과 열방향 mean을 구해라
apply(iris[,1:4], 1, mean) #row 방향으로 함수 적용
apply(iris[,1:4], 2, mean) #col 방향으로 함수 적용



#코드4-16* 퀴즈! x와 y 중에 더 큰수를 반환하는 코드를 작성해라
mymax <- function(x,y) {
  num.max <- x
  if (y > x) {
    num.max <- y
  }
  return(num.max)
}


#코드4-17
mymax(10,15)
a <- mymax(20,15)
b <- mymax(31,45)
print(a+b)


#코드4-18
mydiv <- function(x, y=2) {
  result <- x/y
  return(result)
}

mydiv(x=10, y=3)
mydiv(10, 3)
mydiv(10)


#코드4-19 (여러 개의 값을 반환해야 하는 경우에는 list함수를 이용하여 여러 개의 결과값을 하나로 묶고, 이것을 반환함)
myfunc <- function(x,y){
  val.sum <- x+y
  val.mul <- x*y
  return(list(sum=val.sum, mul=val.mul))
}

result <- myfunc(5,8)
s <- result$sum
m <- result$mul
cat('5 + 8 =', s, '\n')
cat('5 * 8 =', m, '\n')


#코드4-20 /myfunc.R에 저장된 함수 mydiv()를 이용하는 과정/ 그냥 함수 파일을 따로 저장해 놓으면 됨
setwd("C:/Users/nells/Downloads/R_study_source/Ch04")
source("myfunc.R") #myfunc.R 안에 있는 함수 실행

#함수 사용
a <- mydiv(20,4)
b <- mydiv(30,4)
a+b
mydiv(mydiv(20,2),5)


#코드4-21
score <- c(76, 84, 69, 50, 95, 60, 82, 71, 88, 84)
which(score==69) #성적이 69인 학생은 몇 번째에 있나
which(score>=85) #성적이 85 이상인 학생은 몇 번째에 있나 #인덱스를 알아내는 함수라고 할 수 있다!
max(score)
which.max(score)
min(score)
which.min(score)


#코드4-22* 퀴즈! which()함수를 이용하여 성적이 60이하인 애들은 61점으로 상향 조정해라
score <- c(76, 84, 69, 50, 95, 60, 82, 71, 88, 84)
idx <- which(score<=60)
score[idx] <- 61 #성적이 60 이하인 값들은 61점으로 성적 상향 조정
score #상향 조정된 성적 확인

idx <- which(score>=80) #성적이 80 이상인 값들의 인덱스
score.high <- score[idx] #성적이 80 이상인 값들만 추출하여 저장

#subset를 이용해도 똑같이 할 수 있다
score <- c(76, 84, 69, 50, 95, 60, 82, 71, 88, 84)
idx <- which(score>=80)
score.high <- score[idx]

score.high <- subset(score, score>=80)


#코드4-23 which() 함수는 벡터뿐만 아니라 매트릭스, 데이터프레임에 적용하여 조건에 맞는 행의 인덱스를 알아내는 대에도 사용
idx <- which(iris$Petal.Length>5.0)
iris.big <- iris[idx,]


#코드4-24 which()함수를 이용하여 매트릭스, df안의 특정 행,열 위치 알기
idx <- which(iris[,1:4]>5.0, arr.ind = TRUE)
idx


#chapter4. 연습문제
#1-1번
sum = 0
number = 0
for (i in 1:100){
  if (i%%3 == 0){
    sum = sum + i
    number = number + 1
  }
}
print(sum)
print(number)

#1-2번
for (i in 101:200){
  if(i %% 3 == 0 & i %% 4 ==0) {
    print(i)
  }
}


#1-3번
for (i in 1:24){
  if (24%%i == 0){
    print(i)
  }
}

#1-4번 *
a= 1
for (i in 1:10){
  a = a * i
}
print(a)


a = 1
for (i in 1:9){
  cat("9 *", i, "=", 9*i, "\n")
}


i=0
while (i < 9){
  i = i + 1
  cat("8 *", i, "=", 8*i, "\n")
}


for (i in 1:100){
  if (i %% 3 == 0){
    cat('*', "")}
  else{
    cat(i, "")
    }
}



#5번 *
for (i in 2:1000){
  for (j in 2:i){
    if (i%%j==0) break
  }
  if (j==i){
    print(i)
  }
}


#6번 *
fibo <- c(0,1)

while(length(fibo)<40){
  last.1 <- fibo[length(fibo)]
  last.2 <- fibo[length(fibo)-1]
  fibo <- c(fibo, (last.1 + last.2))
}
fibo


#7번
iris2<- iris[,-5]
apply(iris2, 1, sum)
apply(iris2, 2, max)

apply(iris[,-5],2,max) #이렇게 해도 됨


#9번 (유튜브로 답 보는게 나음)

