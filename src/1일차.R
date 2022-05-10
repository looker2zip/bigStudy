#######
#Subsection 2 R Studio 설치하기

R.version

??Print
help(print)
## 함수에 대한 도움말
help(summary) # ?summary와 동일
## 키워드에 대한 도움말
help("for") # ?"for"와 동일
## help.search() 함수: 키워드를 통해 관련 자료를 내 컴퓨터에 설치된(installed) 패키지에서 찾음. 키워드와 관련된 패키지와 함수 정보 제공 
??ANOVA # help.search("ANOVA") 와 동일 
## apropos() 함수: 로딩된(loaded) 패키지에서 키워드를 포함하는 객체를 찾음
apropos("ANOVA")
## help.start() 함수: HTML 웹 브라우저를 통한 도움말을 제공
help.start()
help(q)

#######
#Subsection 3 R Studio 시작하기

10+3
10-3
10*3
10/3
10%%3
10%/%3
10^3

install.packages("ggplot2")
ggplot()
library(ggplot2)
ggplot()
help("ggplot")
detach("package:ggplot2", unload=TRUE)
ggplot()

str(iris)
install.packages("dplyr")
library(dplyr)
glimpse(iris)
detach("package:dplyr",unload = TRUE)
glimpse(iris)
dplyr::glimpse(iris)

#######
#Subsection 4 R 문법 기초
# 스칼라(단일값)
a <- 3
a
print(a)
b <- 4.5
c <- a+b
print(c)

# 벡터(다중값)
z=c(1,2,3)
print(z)
mean(z)

# NA 확인
one <- 100
two <- 75
three <- 80
four <- NA

is.na(one)
is.na(four)


#범 주형 데이터 저장
gender <- factor("m", c("m","f"))
gender
gender2 <- factor("성별", c("남성","여성"))
gender2
season <- factor("season", c("spring","summer","fall","winter"))
season
nlevels(season)
levels(season)

str(iris)
nlevels(iris$Species)
levels(iris$Species)

# 데이터를 넣고 꺼내는 방법
x <- c("a", "b", "c")
print(x)
x[1:2]
x[2:3]

x <- list(name="foo", height=70)
x
x$name
x[[1]]

d <- data.frame(x=c(1, 2, 3, 4, 5), y=c(6,7,8,9,10)) 
d
d$x
d$y
d[1,]
d[,1]

d[c(1,3),2]
d[-1,-c(2,3)]
d[-1,-c(2)]


# if 제어문
# 만약 a=60이면 a > 60 패스이다라고 그렇지 않으면 실패를 출력하는 구문
a=60
a
if(a>=90){
  print("A++")
}else{
  print("실패")
}
# for 반복문
# i<-c(1,2,3,4,5,6,7,8,9,10)
for(i in 1:10){
  print(i)
}



##############################
#Subsection 1 분류 분석을 통한 라벨 변수에 미치는 영향변수 도출하기

# 실습: 의사결정 트리 생성: ctree() 함수 이용 
# 단계 1: party 패키지 설치 
install.packages("party")
library(party)

# 단계 2: airquality 데이터 셋 로딩
#install.packages("datasets")
library(datasets)
str(airquality)

# 단계 3: formula 생성
formula <- Temp ~ Solar.R + Wind + Ozone

# 단계 4: 분류모델 생성 - formula를 이용하여 분류모델 생성
air_ctree <- ctree(formula, data = airquality)
air_ctree

# 단계 5: 분류분석 결과
plot(air_ctree)


# 실습: 학습데이터와 검정데이터 샘플링으로 분류분석 수행
# 단계 1: 학습데이터와 검정데이터 샘플링
install.packages("party")
library(party)
#set.seed(1234)
idx <- sample(1:nrow(iris), nrow(iris) * 0.7)
train <- iris[idx, ]
test <- iris[-idx, ]

# 단계 2: formula(공식) 생성
formula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width

# 단계 3: 학습데이터 이용 분류모델 생성
iris_ctree <- ctree(formula, data = train)
iris_ctree

# 단계 4: 분류모델 플로팅
# 단계 4-1: 간단한 형식으로 시각화 
plot(iris_ctree, type = "simple")

# 단계 4-2: 의사결정 트리로 플로팅
plot(iris_ctree)


# 단계 5: 분류모델 평가
# 단계 5-1: 모델의 예측치 생성과 혼돈 매트릭스 생성
pred <- predict(iris_ctree, test)

table(pred, test$Species)

# 단계 5-2: 분류 정확도 - 96%
(12 + 16 + 15) / nrow(test)

library(caret)
confusionMatrix(pred, test$Species)





# 실습: rpart() 함수를 이용한 의사결정 트리 생성
# 단계 1: 패키지 설치 및 로딩
install.packages("rpart")
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)

# 단계 2: 데잍 로딩
data(iris)

# 단계 3: rpart() 함수를 이용한 분류분석
rpart_model <- rpart(Species ~ ., data = iris)
rpart_model

# 단계 4: 분류분석 시각화
rpart.plot(rpart_model)




# 실습: 랜덤 포레스트 기본 모델 생성
# 단계 1: 패키지 설치 및 데이터 셋 가져오기 
# install.packages("randomForest")
urlPackage <- "https://cran.r-project.org/src/contrib/Archive/randomForest/randomForest_4.6-14.tar.gz"
install.packages(urlPackage, repos=NULL, type="source")
library(randomForest)
data(iris)

# 단계 2: 랜덤 포레스트 모데 ㄹ생성
model1 <- randomForest(Species ~ ., data = iris)
model1



# 실습: 파라미터 조정 - 트리 개수 300개, 변수 개수 4개 지정  
model2 <- randomForest(Species ~ ., data = iris,
                       ntree = 300, mtry = 4, na.action = na.omit)
model2

# 실습: 중요 변수를 생성하여 랜덤 포레스트 모델 생성 
# 단계 1: 중요 변수로 랜덤 포레스트 모델 생성
model3 <- randomForest(Species ~ ., data = iris,
                       importance = T, na.action = na.omit)

# 단계 2: 중요 변수 보기 
importance(model3)

# 단계 3: 중요 변수 시각화
varImpPlot(model3)


### 엔트포리(Entropy): 불확실성
x1 <- 0.5; x2 <- 0.5 
e1 <- -x1 * log2(x1) - x2 * log2(x2)
e1

x1 <- 0.7; x2 <- 0.3               
e2 <- -x1 * log2(x1) - x2 * log2(x2)
e2



# 실습: ;최적의 파라미터(ntree, mtry) 찾기 
# 단계 1: 속성값 생성
ntree <- c(400, 500, 600)
mtry <- c(2:4)
param <- data.frame(n = ntree, m = mtry)
param

# 단계 2: 이중 for() 함수를 이용하여 모델 생성
for(i in param$n) {
  cat('ntree =', i, '\n')
  for(j in param$m) {
    cat('mtry =', j, '\n')
    model_iris <- randomForest(Species ~ ., data = iris,
                               ntree = i, mtry = j, na.action = na.omit)
    print(model_iris)
  }
}


# 실습: 다향 분류 xgboost 모델 생성
# 단계 1: 패키지 설치
install.packages("xgboost")
library(xgboost)

# 단계 2: y 변수 생성
iris_label <- ifelse(iris$Species == 'setosa', 0,
                     ifelse(iris$Species == 'versicolor', 1, 2))
table(iris_label)
iris$label <- iris_label

# 단계 3: 데이터 셋 생성
idx <- sample(nrow(iris), 0.7 * nrow(iris))
train <- iris[idx, ] 
test <- iris[-idx, ]

# 단계 4: matrix 객체 변환
train_mat <- as.matrix(train[-c(5:6)])
dim(train_mat)

train_lab <- train$label
length(train_lab)


# 단계 5: xgb.DMatrix 객체 변환
dtrain <- xgb.DMatrix(data = train_mat, label = train_lab)

# 단계 6: model 생성 - xgboost matrix 객체 이용
xgb_model <- xgboost(data = dtrain, max_depth = 2, eta = 1,
                     nthread = 2, nrounds = 2,
                     objective = "multi:softmax", 
                     num_class = 3,
                     verbose = 0)
xgb_model

# 단계 7: testset 생성
test_mat <- as.matrix(test[-c(5:6)])
dim(test_mat)
test_lab <- test$label
length(test_lab)

# 단계 8: model prediction
pred_iris <- predict(xgb_model, test_mat)
pred_iris

# 단계 9: confusion matrix
table(pred_iris, test_lab)

# 단계 10: 모델 성능평가1 - Accuracy
(23 + 12 + 10) / length(test_lab)

# 단계 11: model의 중요 변수(feature)와 영향력 보기 
importance_matrix <- xgb.importance(colnames(train_mat), 
                                    model = xgb_model)
importance_matrix

# 단계 12: 중요 변수 시각화 
xgb.plot.importance(importance_matrix)

#################
#고속도로 주행거리에 미치는 영향변수 보기
library(ggplot2)
data(mpg)
t <- sample(1:nrow(mpg), 120)
train <- mpg[-t, ]
test <- mpg[t, ]
dim(train)
dim(test)
test$drv <- factor(test$drv)
formula <- hwy ~ displ + cyl + drv
tree_model <- ctree(formula, data = test)
plot(tree_model)



###########################################

##R을 이용한 제조 데이터 분석을 수행해 보기 -일부 소스코드 제공

install.packages("party")
library(party)
install.packages("readxl")
library(readxl)
install.packages("dplyr")
library(dplyr)
setwd("C:/DEV/r-workspaces/rs")
GE_PBA_A_검사서_2022_04_19<-read_excel(path="data/2022-04-19_GE_PBA_A_검사서.xlsx",sheet = "BFT")
GE_PBA_A_검사서_2022_04_20<-read_excel(path="data/2022-04-20_GE_PBA_A_검사서.xlsx",sheet = "BFT")
head(GE_PBA_A_검사서_2022_04_19)
head(GE_PBA_A_검사서_2022_04_20)
str(GE_PBA_A_검사서_2022_04_19)
str(GE_PBA_A_검사서_2022_04_20)
names(GE_PBA_A_검사서_2022_04_19)
names(GE_PBA_A_검사서_2022_04_20)
dim(GE_PBA_A_검사서_2022_04_19)
dim(GE_PBA_A_검사서_2022_04_20)
GE_PBA_A_검사서<-bind_rows(GE_PBA_A_검사서_2022_04_19,GE_PBA_A_검사서_2022_04_20)
dim(GE_PBA_A_검사서)
write.csv(GE_PBA_A_검사서, "data/GE_PBA_A_검사서.csv", row.names = F, quote = F)
GE_PBA_A_검사서<-read.csv(file = "data/GE_PBA_A_검사서.csv",sep = ",",na.strings = "-",fileEncoding = "euc-kr")
head(GE_PBA_A_검사서)
tail(GE_PBA_A_검사서)
dim(GE_PBA_A_검사서)
str(GE_PBA_A_검사서)
names(GE_PBA_A_검사서)

install.packages("caret")
library(caret)



################3

library(dplyr)

# One-Hot Encoding

# 데이터 생성
set.seed(0614)
data <- data.frame(Num = seq(1,100, by=1),
                   Variables = sample(c("a", "b", "c"), 100, replace=T)
)

data$Variables <- as.factor(data$Variables) # Variables 변수를 factor 처리
str(data)

data %>% head()

# [방법1]
## caret 패키지 활용 -> 머신러닝에서 자주 이용
library(caret)
dummy <- dummyVars("~.", data = data)

data2 <- data.frame(predict(dummy, newdata = data))

data2 %>% head() # 변수명이 Variables.(?) 로 바뀌고 원핫인코딩

# [방법2]
## reshape2 패키지 활용
library(reshape2) # 데이터 정제 및 변환에 유용한 패키지

data3 <- dcast(data=data, Num~Variables, length)
data3 %>% head() # levels 값들을 변수명으로 바뀌면서 원핫인코딩

######################
dmy <- dummyVars(~Result, data = GE_PBA_A_검사서)
GE_PBA_A_검사서_dmy <- data.frame(predict(dmy, newdata = GE_PBA_A_검사서))
head(GE_PBA_A_검사서_dmy)

GE_PBA_A_검사서_new <- cbind(GE_PBA_A_검사서,GE_PBA_A_검사서_dmy)
head(GE_PBA_A_검사서_new)
write.csv(GE_PBA_A_검사서_new, "data/GE_PBA_A_검사서_new.csv", row.names = F, quote = F)
GE_PBA_A_검사서_new<-read.csv(file = "data/GE_PBA_A_검사서_new.csv",sep = ",",na.strings = "-",fileEncoding = "euc-kr")
head(GE_PBA_A_검사서_new)
class(GE_PBA_A_검사서_new$ResultOK)
length(GE_PBA_A_검사서_new$ResultOK)
table(GE_PBA_A_검사서_new$ResultOK)

formula <- ResultOK ~ BLE.RSSI + ATIVECURR + STANBYCURR + IR.Current + IR.LED + ACC_X + ACC_Y + ACC_Z
GE_PBA_A_검사서_ctree <- ctree(formula, data = GE_PBA_A_검사서_new)
GE_PBA_A_검사서_ctree
plot(GE_PBA_A_검사서_ctree)


############################################
########학습데이터와 검정데이터 샘플링

idx <- sample(1:nrow(GE_PBA_A_검사서_new), nrow(GE_PBA_A_검사서_new) * 0.7)
train <- GE_PBA_A_검사서_new[idx, ]
test <- GE_PBA_A_검사서_new[-idx, ]

formula <- ResultOK ~ BLE.RSSI + ATIVECURR + STANBYCURR + IR.Current + IR.LED + ACC_X + ACC_Y + ACC_Z

GE_PBA_A_검사서_new_ctree <- ctree(formula, data = train)
GE_PBA_A_검사서_new_ctree

plot(GE_PBA_A_검사서_new_ctree, type = "simple")

plot(GE_PBA_A_검사서_new_ctree)

####################
pred <- predict(GE_PBA_A_검사서_new_ctree, test)
table(pred, test$ResultOK)
(14 + 16 + 13) / nrow(test)
##########################


###################################
######랜덤 포레스트 
urlPackage <- "https://cran.r-project.org/src/contrib/Archive/randomForest/randomForest_4.6-14.tar.gz"
install.packages(urlPackage, repos=NULL, type="source")
library(randomForest)


model <- randomForest(ResultOK ~ BLE.RSSI + ATIVECURR + STANBYCURR + IR.Current + IR.LED + ACC_X + ACC_Y + ACC_Z, data = GE_PBA_A_검사서_new)
model

varImpPlot(model)
