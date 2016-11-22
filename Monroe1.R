#R Workshop

##Introduction
#Basic Functions
abs(-4.2)
sqrt(99)
ceiling(3.475)
floor(3.475)
trunc(5.99)
round(3.475, digits = 2)
signif(3.475, digits = 2)
cos(3.475)
log(3.475)
log10(3.475)
exp(3.475)

#Character Functions
x <- "abcdef"
substr(x,2,4)
grep("A", c("b","A","c"), fixed = TRUE)
strsplit("abc","")
strsplit("ab,c",",")
paste("x",1:3,sep="")
paste("x",1:3,sep="M")
paste("Today is", date())
toupper('hello there!')
tolower('HELLO THERE!')

#Statistics/Probability Functions
x <- pretty(c(-3,3), 30)
y <- dnorm(x)
plot(x, y, type='l', xlab="Normal Deviate", ylab="Density", yaxs="i")
#(if figure margins too large, expand plot screen)

pnorm(1.96)
qnorm(0.9)
x <- rnorm(50,m=50,sd=50)
dbinom(0:5,10,5)
pbinom(5,10,.5)
dpois(0:2,4)
1-ppois(2,4)
x <- runif(10)

x = runif(3, min=0, max=100) 
mean(x)
mean(x,na.rm=TRUE)
sd(x)
median(x)
quantile(x,c(.3,.84))
range(x)
sum(x)
diff(x,lag=1)
min(x)
max(x)
scale(x, center=TRUE, scale=TRUE)

#Other Functions
indices <- seq(1,10,2)
indices

y <- rep(1:3,2)
y

y <- cut(x,5)


#R as a Calculator
1250+100

1+1; 4*5; 6-2

#Numbers
x = c(1,2,3,4,5,6,7,8,NA) 
mean(x)
mean(x,na.rm=TRUE)

#String Characters
letters = c("a","b","c")

##Objects

#Vector
vector <- c(2,3,5)
vector

#Array
vector1 <- c(5,9,3)
vector2 <- c(10,11,12,13,14,15)
result <- array(c(vector1,vector2),dim = c(3,3,2))
result

#Matrices
A <- matrix(c(2,4,3,1,5,7),
            nrow=2,
            ncol=3,
            byrow=TRUE)
A

#Subscripts
x[4]
x[c(2,5)]

#Dataframe
n = c(2,3,5)
s = c("aa","bb","cc")
b = c(TRUE,FALSE,TRUE)
df = data.frame(n,s,b)

#Review
q1 <- c(.295,.300,.250,.287,.215)
q2 <- mean(q1)
q3 <- q2>0.26
q4 <- as.data.frame(q1)
q4$PlusOne <- q4$q1 + 1



