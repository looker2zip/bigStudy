#######
#데이터 조작 기초

num <- scan()
num

sum(num)

# 실습: 키보드로 문자 입력하기 
name <- scan(what = character())

name


getwd()
setwd("C:/DEV/r-workspaces/day-20220501/data")
student <- read.table(file = "student.txt")
student

names(student) <- c("번호", "이름", "키", "몸무게")
student


student2 <- read.csv(file = "student4.txt",sep = ",",na.strings = "-",fileEncoding = "euc-kr")
student2

install.packages("readxl")
library(readxl)
student3 <- read_excel(path = "studentexcel.xlsx",sheet="student")
                                                                                                                                                      
student3

# txt 파일에 저장
write.table(student, "studentw.txt", row.names = FALSE)
# csv 파일에 저장
write.csv(student2, "student2w.csv", row.names = F, quote = F)
 # excel 파일에 저장
install.packages("writexl")

library(writexl)
write_xlsx(x=student3, path="student3w.xlsx", col_names = TRUE)


# 실습: dplyr 패키지와 hflight 데이터 셋 설치 
install.packages(c("dplyr", "hflights"))
library(dplyr)
library(hflights)

str(hflights)

# 실습: tbl_df() 함수 사용하기 
hflights_df <- tbl_df(hflights)
hflights_df


# 실습: hflights_df를 대상으로 특정일의 데이터 추출하기 
filter(hflights_df, Month == 1 & DayofMonth == 2)  # 1월 2일 데이터 추출


# 실습: hflights_df를 대상으로 지정된 월의 데이터 추출하기 
filter(hflights_df, Month == 1 | Month == 2) # 1월 또는 2월 데이터 추출


# 실습: hflights_df를 대상으로 데이터 정렬하기 
arrange(hflights_df, Year, Month, DepTime, ArrTime)

# 실습: hflights_df를 대상으로 지정된 칼럼 데이터 검색하기 
select(hflights_df, Year, Month, DepTime, ArrTime)

# 실습: hflights_df를 대상으로 칼럼의 범위로 검색하기 
select(hflights_df, Year:ArrTime)

# 실습: hflights_df에서 출발 지연시간과 도착 지연시간의 차이를 계산한 칼럼 추가하기 
mutate(hflights_df, gain = ArrTime - DepTime, 
       gain_per_hour = gain / (AirTime / 60))


# 실습: mutate() 함수에 의해 추가된 칼럼 보기 
select(mutate(hflights_df, gain = ArrDelay - DepDelay, 
              gain_per_hour = gain / (AirTime / 60)),
       Year, Month, ArrDelay, DepDelay, gain, gain_per_hour)


# 실습: hflights_df에서 비행시간의 평균 구하기 
summarise(hflights_df, avgAirTime = mean(AirTime, na.rm = TRUE))
# hflights_df %>% summarise(avgAirTime = mean(AirTime, na.rm = TRUE))

# 실습: hflights_df의 관측치 길이 구하기 
summarise(hflights_df, cnt = n(), 
          delay = mean(AirTime, na.rm = TRUE))


# 실습: 도착시간(ArrTime)의 표준편차와 분산 계산하기 
summarise(hflights_df, arrTimeSd = sd(ArrTime, na.rm = TRUE),
          arrTimeVar = var(ArrTime, na.rm = T))



# 실습: 공통변수를 이용하여 내부조인(inner_join)하기
# 단계 1: join 실습용 데이터프레임 생성
df1 <- data.frame(x = 1:5, y = rnorm(5))
df2 <- data.frame(x = 2:6, z = rnorm(5))

df1

df2

# 단계 2: inner_join 하기 
inner_join(df1, df2, by = 'x')

# 실습: 공통변수를 이용하여 왼쪽 조인(left_join)하기
left_join(df1, df2, by = 'x')

# 실습: 공통변수를 이용하여 오른쪽 조인(right_join)하기
right_join(df1, df2, by = 'x')


# 실습: 공통변수를 이용하여 전체 조인(full_join)하기
full_join(df1, df2, by = 'x')


# 실습: 두 개의 데이터프레임을 행 단위로 합치기 
# 단계 1: 실습을 위한 데이터프레임 생성
df1 <- data.frame(x = 1:5, y = rnorm(5))
df2 <- data.frame(x = 6:10, y = rnorm(5))

df1

df2

# 단계 2: 데이터프레임 합치기 
df_rows <- bind_rows(df1, df2)
df_rows


# 실습: 두 개의 데이터프레임을 열 단위로 합치기 
df_cols <- bind_cols(df1, df2)
df_cols


################################################################

###데이터 탐색(EDA와 시각화) 기초
######################################################################33

# 실습: 실습용 데이터 가져오기 
getwd()
setwd("C:/DEV/r-workspaces/day-20220501/data")
dataset <- read.csv("dataset.csv", header = T)
dataset

# 실습: 전체 데이터 보기 
print(dataset)
View(dataset)

# 실습: 데이터의 앞부분과 뒷부분 보기 
head(dataset)
tail(dataset)

# 실습: 데이터 셋 구조 보기 
names(dataset)
attributes(dataset)
str(dataset)


# 다양한 방법으로 데이터 셋 조회하기 
# 단계 1: 데이터 셋에서 특정 변수 조회하기 
dataset$age
dataset$resident
length(dataset$age)

#단계 2: 특정 변수으 조회 결과를 변수에 저장하기 
x <- dataset$gender
y <- dataset$price

x
y

# 단계 3: 산점도 그래프로 변수 조회
plot(dataset$price)

# 단계 4: 칼럼명을 사용하여 특정 변수 조회
dataset["gender"]
dataset["price"]


# 단계 5: 색인을 사용하여 특정 변수 조회
dataset[2]
dataset[6]
dataset[3, ]
dataset[ , 3]

# 단계 6: 2개 이상의 칼럼 조 
dataset[c("job", "price")]
dataset[c(2, 6)]
dataset[c(1, 2, 3)]
dataset[c(2, 4:6, 3, 1)]


#단계 7: 특정행/열을 조회
dataset[ , c(2:4)]
dataset[c(2:4), ]
dataset[-c(1:100), ]

###### 데이터 정제

# 실습: summary() 함수를 사용하여 결측치 확인하기
summary(dataset$price)
sum(dataset$price)

# 실습: sum() 함수의 속성을 이용하여 결측치 제거하기 
sum(dataset$price, na.rm = T)

# 실습: 결측치 제거 함수를 이용하여 결측치 제거 
price2 <- na.omit(dataset$price)
sum(price2)
length(price2)


# 실습: 결측치를 0으로 대체하기 
x <- dataset$price
x[1:30]
dataset$price2 = ifelse(!is.na(x), x, 0)
dataset$price2[1:30]


# 실습: 결측치를 평균으로 대체하기 
x <- dataset$price
x[1:30]
dataset$price3 = ifelse(!is.na(x), x, round(mean(x, na.rm = TRUE), 2))
dataset$price3[1:30]
dataset[c('price', 'price2', 'price3')]

################### 극단치
# 실습: 범주형 변수의 극단치 처리하기 
table(dataset$gender)
pie(table(dataset$gender))


# 실습: subset() 함수를 사용하여 데이터 정제하기 
dataset <- subset(dataset, gender == 1 | gender == 2)
dataset
length(dataset$gender)
pie(table(dataset$gender))
pie(table(dataset$gender), col = c("red", "blue"))


# 실습: 연속형 변수의 극단치 보기 
dataset <- read.csv("dataset.csv", header = T)
dataset$price
length(dataset$price)
plot(dataset$price)
summary(dataset$price)

# 실습: price 변수의 데이터 정제와 시각화 
dataset2 <- subset(dataset, price >= 2 & price <= 8)
length(dataset2$price)
stem(dataset2$price)

# 실습: age 변수의 데이터 정제와 시각화 
# 단계 1: age 변수에서 NA 발견
summary(dataset2$age)
length(dataset2$age)

# 단계 2: age 변수 정제(20 ~ 69)
dataset2 <- subset(dataset2, age >= 20 & age <= 69)
length(dataset2)

# 단계 3: box 플로팅으로 평균연령 분석
boxplot(dataset2$age)

######################변수간의 관계 분석과 시각화



## Anscombe's Quartet of ‘Identical’ Simple Linear Regressions

# yet are quite different. 

# 데이터 구조
str(anscombe)

# 데이터 view
anscombe

# 변수별 평균, 표준편차
options(digits = 2) # 소수점 자리 설정

sapply(anscombe, mean) # mean

sapply(anscombe, sd) # standard deviation

# x, y 상관계수 (x, y correlation)
attach(anscombe)
cor(x1, y1)

cor(x2, y2)

cor(x3, y3)

cor(x4, y4)

detach(anscombe) 

# Simple Linear Regrassions by 4 groups
attach(anscombe)

lm(y1 ~ x1)

lm(y2 ~ x2)

lm(y3 ~ x3)

lm(y4 ~ x4)

# Scatter Plot & Simple Linear Regression Line
par(mfrow = c(2,2)) # 2 x 2 layout
attach(anscombe)

plot(x1, y1); abline(lm(y1~x1), col = "blue", lty = 3)
plot(x2, y2); abline(lm(y2~x2), col = "blue", lty = 3)
plot(x3, y3); abline(lm(y3~x3), col = "blue", lty = 3)
plot(x4, y4); abline(lm(y4~x4), col = "blue", lty = 3)> 
detach(anscombe)


########################
# 실습: 범주형 vs 범주형 데이터 분포 시각화 
# 단계 1: 실습을 위한 데이터 가져오기 
setwd("C:/DEV/r-workspaces/day-20220501/data")
new_data <- read.csv("new_data.csv", header = TRUE)
str(new_data)

# 단계 2: 코딩 변경된 거주지역(resident) 칼럼과 성별(gender) 칼럼을
#         대상으로 빈도수 구하기 
resident_gender <- table(new_data$resident2, new_data$gender2)
resident_gender
gender_resident <- table(new_data$gender2, new_data$resident2)
gender_resident

# 단계 3: 성별(gender)에 따른 거주지역(resident)의 분포 현황 시각화 
barplot(resident_gender, beside = T, horiz = T, 
        col = rainbow(5), 
        legend = row.names(resident_gender), 
        main = '성별에 따른 거주지역 분포 현황')

# 단계 4: 거주지역(resident)에 따른 성별(gender)의 분포 현황 시각화 
barplot(gender_resident, beside = T, 
        col = rep(c(2, 4), 5), horiz = T, 
        legend = c("남자", "여자"),
        main = '거주지역별 성별 분포 현황')

# 실습: 연속형 vs 범주형 데이터의 시각화 
# 단계 1: lattice 패키지 설치와 메모리 로딩 및 데이터 준비
install.packages("lattice")
library(lattice)

# 단계 2: 직업 유형에 따른 나이 분포 현황
densityplot(~ age, data = new_data, 
            groups = job2, 
            # plot.points = T: 밀도, auto.key = T: 범례)
            plot.points = T, auot.key = T)


# 실습: 연속형 vs 범주형 vs 범주형
# 단계 1: 성별에 따른 직급별 구매비용 분석
densityplot(~ price | factor(gender), 
            data = new_data, 
            groups = position2, 
            plot.points = T, auto.key = T)


# 단계 2: 직급에 따른 성별 구매비용 분석
densityplot(~ price | factor(position2), 
            data = new_data, 
            groups = gender2, 
            plot.points = T, auto.key = T)


# 실습: 연속형(2개) vs 범주형(1개) 데이터 분포 시각화 
xyplot(price ~ age | factor(gender2), 
       data = new_data)

###########################################################
########파생변수


# 실습: 파생변수 생성하기 
# 단계 1: 데이터 파일 가져오기
setwd("C:/DEV/r-workspaces/day-20220501/data")
install.packages("reshape2")
user_data <- read.csv("user_data.csv", header = T,fileEncoding = "euc-kr")
head(user_data)
table(user_data$house_type)

# 단계 2: 파생변수 생성
house_type2 <- ifelse(user_data$house_type == 1 |
                        user_data$house_type == 2, 0 , 1)
house_type2[1:10]

# 단계 3: 파생변수 추가 
user_data$house_type2 <- house_type2
head(user_data)


# 실습: 1:N의 관계를 1:1 관계로 파생변수 생성하기 
# 단계 1: 데이터 파일 가져오기 
pay_data <- read.csv("pay_data.csv", header = T, fileEncoding = "euc-kr")
head(pay_data, 10)
table(pay_data$product_type)

# 단계 2: 고객별 상품 유형에 따른 구매금액과 합계를 나타내는 파생변수 생성
library(reshape2)
product_price <- dcast(pay_data, user_id ~ product_type,
                       sum, na.rm = T)
head(product_price, 3)
# 단계 3: 칼럼명 수정
names(product_price) <- c('user_id', '식표품(1)', '생필품(2)',
                          '의류(3)', '잡화(4)', '기타(5)')
head(product_price)


# 실습: 고객식별번호(user_id)에 대한 지불유형(pay_method)의 파생변수 생성하기 
# 단계 1: 고객별 지불유형에 따른 구매상품 개수를 나타내는 팡생변수 생성
pay_price <- dcast(pay_data, user_id ~ pay_method, length)
head(pay_price, 3)

# 단계 2: 칼럼명 변경하기 
names(pay_price) <- c('user_id', '현금(1)', '직불카드(2)', 
                      '신용카드(3)', '상품권(4)')
head(pay_price, 3)

# 실습: 고객정보(user_data) 테이블에 파생변수 추가하기 
# 단계 1: 고객정보 테이블과 고객별 상품 유형에 따른
#         구매금액 합계 병합하기 
library(plyr)
user_pay_data <- join(user_data, product_price, by = 'user_id')
head(user_pay_data, 10)

# 단계 2: [단계 1]의 병합 결과를 대상으로 고객별 지불유형에 따르 ㄴ
#         구매상품 개수 병합하기 
user_pay_data <- join(user_pay_data, pay_price, by = 'user_id')
user_pay_data[c(1:10), c(1, 7:15)]


# 실습: 사칙연산으로 총 구매금액 파생변수 생성하기 
# 단계 1: 고객별 구매금액의 합계(총 구매금액) 계산하기 
user_pay_data$총구매금액 <- user_pay_data$`식표품(1)` +
  user_pay_data$`생필품(2)` +
  user_pay_data$`의류(3)` +
  user_pay_data$`잡화(4)` +
  user_pay_data$`기타(5)`

# 단계 2: 고객별 상품 구매 총금액 칼럼 확인하기 
user_pay_data[c(1:10), c(1, 7:11, 16)]


# 실습: 정제된 데이터 저장하기 
print(user_pay_data)

setwd("C:/DEV/r-workspaces/day-20220501/data")
write.csv(user_pay_data, "cleanData.csv", quote = F, row.names = F)

data <- read.csv("cleanData.csv", header = TRUE)
data

####################################################################
#######샘플링
#단순 임의 추출(Random Sampling)-비복원추출

sample(1:10, 5)

sample(1:10, 5, replace = FALSE)

sample(1:10, 5, replace = FALSE)

sample(1:10, 5, replace = FALSE)

sample(1:10, 5)

sample(1:10, 5)

sample(1:10, 5)

#단순 임의 추출(Random Sampling)- 복원추출


sample(1:10, 5, replace = TRUE)

sample(1:10, 5, replace = TRUE)

sample(1:10, 5, replace = T)

sample(1:10, 5, replace = T)

# 실습: 표본 샘플링


# 단계 1: 표본 추출하기 
nrow(data)
choice1 <- sample(nrow(data), 30)
choice1

# 50 ~ (data 길이) 사이에서 30개 행을 무작위 추출
choice2 <- sample(50:nrow(data), 30)
choice2

# 50~100 사이에서 30개 행을 무작위 추출 
choice3 <- sample(c(50:100), 30)
choice3

# 다양한 범위를 지정하여 무작위 샘플링
choice4 <- sample(c(10:50, 80:150, 160:190), 30)
choice4

# 단계 2: 샘플링 데이터로 표본추출
data[choice1, ]


# 실습: iris 데이터 셋을 대상으로 7:3 비율로 데이터 셋 생성하기 
# 단계 1: iris 데이터 셋의 관측치와 칼럼 수 확인
data("iris")
dim(iris)


# 단계 2: 학습 데이터*70%), 검정 데이터(30%) 비율로 데이터 셋 구성
idx <-sample(1:nrow(iris), nrow(iris) * 0.7)
training <- iris[idx, ]
testing <- iris[-idx, ]
dim(training)



# 실습: 데이터 셋을 대상으로 K겹 교차 검정 데이터 셋 생성하기 
# 단계 0: 교차 검정을 위한 패키지 설치 
install.packages("cvTools")
library(cvTools)

# 단계 1: 데이터프레임 생성
name <- c('a', 'b','c', 'd', 'e', 'f')
score <- c(90, 85, 99, 75, 65, 88)
df <- data.frame(Name = name, Score = score)

# 단계 2: K겹 교차 검정 데이터 셋 생성
cross <- cvFolds(n = 6, K = 3, R = 1, type = "random")
cross

# 단계 3: K겹 교차 검정 데이터 셋 구조 보기 
str(cross)
cross$which

# 단계 4: subsets 데이터 참조하기 
cross$subsets[cross$which == 1, 1]
cross$subsets[cross$which == 2, 1]
cross$subsets[cross$which == 3, 1]

# 단계 5: 데이터프레임의 관측치 적용하기 
r = 1
K = 1:3
for(i in K) {
  datas_idx <- cross$subsets[cross$which == i, r]
  cat('K = ', i, '검정데이터 \n')
  print(df[datas_idx, ])
  
  cat('K = ', i, '훈련데이터 \n')
  print(df[-datas_idx, ])
}




#########################################################################
###### PM



#######
#통계 기반 데이터 분석 기초
# Chapter 11

# 실습: 전체 데이터 셋의 특성 보기
# 단계 1: 실습 데이터 셋 가져오기 
setwd("C:/DEV/r-workspaces/day-20220501/data")
data <- read.csv("descriptive.csv", header = TRUE)
head(data)

# 단계 2: descriptive.csv 데이터 셋의 데이터 특성 보기 
dim(data)
length(data)
length(data$survey)
str(data)

# 단계 3: 데이터 특성(최소값, 최대값, 평균, 분위수, 결측치(NA) 등) 제공
summary(data)

# 실습: 성별(gender) 변수의 기술 통계량과 빈도수 구하기 
length(data$gender)
summary(data$gender)
table(data$gender)


# 실습: 이상치(outlier) 제거 
data <- subset(data, gender == 1 | gender == 2)
x <- table(data$gender)
x
barplot(x)





# 실습: 학력 수준(level) 변수를 대상으로 구성 비율 구하기 
length(data$level)
summary(data$level)

table(data$level)


# 실습: 학력 수준(level) 변수의 빈도수 시각화하기 
x1 <- table(data$level)
barplot(x1)



# 실습: 변수 리코딩과 빈도분석 하기 
# 단계 1: 거주지역(resident) 변수의 리코딩고 비율계산
data$resident2[data$resident == 1] <- "특별시"
data$resident2[data$resident >= 2 & data$resident <= 4] <- "광역시"
data$resident2[data$resident == 5] <- "시구군"

x <- table(data$resident2)
x


prop.table(x)

y <- prop.table(x)
round(y * 100, 2)


# 단계 2: 성별(gender) 변수의 리코딩과 비율계산
data$gender2[data$gender == 1] <- "남자"
data$gender2[data$gender == 2] <- "여자"
x <- table(data$gender2)
prop.table(x)
y <- prop.table(x)
round(y * 100, 2)


# 단계 3: 나이(age) 변수의 리코딩과 비율계산
data$age2[data$age <= 45] <- "중년층"
data$age2[data$age >= 46 & data$age <= 59] <- "장년층"
data$age2[data$age >= 60] <- "노년층"
x <- table(data$age2)
x

prop.table(x)
y <- prop.table(x)
round(y * 100, 2)


# 단계 4: 학력 수준(level) 번수의 리코딩과 비율계산
data$level2[data$level == 1] <- "고졸"
data$level2[data$level == 2] <- "대졸"
data$level2[data$level == 3] <- "대학원졸"
x <- table(data$level2)
x

prop.table(x)
y <- prop.table(x)
round(y * 100, 2)

# 단계 5: 합격여부(pass) 변수의 리코딩과 비율계산
data$pass2[data$pass == 1] <- "합격"
data$pass2[data$pass == 2] <- "실패"
x <- table(data$pass)

x
prop.table(x)

y <- prop.table(x)
round(y * 100, 2)

head(data)

###################################
#일표본 T검정-t.test
women$weight
mean(women$weight)
t.test(women$weight, mu=130, alternative="greater")


women$height
mean(women$height)
t.test(women$height, mu=70, alternative="less")


var.test(sleep$extra ~ sleep$group)
t.test(sleep$extra ~ sleep$group, alternative="greater", var.equal=TRUE)
t.test(sleep$extra ~ sleep$group, alternative="less", var.equal=TRUE)
t.test(sleep$extra ~ sleep$group, alternative="two.sided", var.equal=TRUE)

### 분산분석


data(anorexia,package="MASS")
anorexia 
out1=aov(Postwt~Treat,
         data=anorexia
         )
out1 
summary(out1)


out2=anova(lm(Postwt~Treat,data=anorexia))
out2


out3=oneway.test(Postwt~Treat,data=anorexia)
out3

out4=oneway.test(Postwt~Treat,data=anorexia,var.equal = TRUE)
out4


###################################
#상관분석
install.packages("corrplot")
library(corrplot)
install.packages("lattice")
library(lattice) 
mcor2=cor(mtcars$gear, mtcars$carb)
mcor2
xyplot(gear~carb,data=mtcars)
mcor=cor(mtcars)
mcor
round(mcor,2)
corrplot(mcor)


# 회귀분석

lm_fit <- lm(hp ~ cyl, data=mtcars) 
summary(lm_fit)
plot(mtcars$cyl, mtcars$hp)   # scatter plot
abline(lm_fit)          # line

###회귀선이 0점을 지나도록 추가 작업
lm_fit_0 <- lm(hp ~ cyl+0, data=mtcars)
summary(lm_fit_0)
plot(mtcars$cyl, mtcars$hp, xlim=c(0,8), ylim=c(-60, 350))
abline(lm_fit_0)
