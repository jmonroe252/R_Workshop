#R Workshop

##Introduction
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

#Summary
#Create a vector
d <- (1:20)
d2 <- summary(d)
d3 <- mean(d)
d4 <- median(d)
d5 <- d3==d4
d6 <- as.data.frame(d)
d6$New <- d6$d/2
names(d6)[names(d6)=="d"] <- "Column1"
names(d6)[names(d6)=="New"] <- "Column2"

#Review
q1 <- c(.295,.300,.250,.287,.215)
q2 <- mean(q1)
q3 <- q2>0.26
q4 <- as.data.frame(q1)
q4$PlusOne <- q4$q1 + 1

##Control Structures, Scoping Rules and Functions

#Argument Matching
mydata <- rnorm(100) 
sd(mydata) 
sd(x = mydata) 
sd(x = mydata, na.rm = FALSE) 
sd(na.rm = FALSE, x = mydata) 
sd(na.rm = FALSE, mydata) 

#Create 2 vectors x and y
x <- rnorm(20)
y <- rnorm(20)

#bind together, transpose and convert to dataframe
mydata <- rbind(x,y)
mydata <- t(mydata)
mydata <- as.data.frame(mydata)

lm(data = mydata, y ~ x, model = FALSE, 1:100) 
lm(y ~ x, mydata, 1:100, model = FALSE)




args(paste) 
function (..., sep = " ", collapse = NULL) 
  paste("a", "b", sep = ":") [
    
    paste("a", "b", se = ":") 
    
    #Defining a function
    f <- function(a, b = 1, c = 2, d = NULL) { 
    } 
    
    #Lazy Evaluation
    f <- function(a, b) { 
      a^2 
    } 
    
    f <- function(a, b) { 
      print(a) 
      print(b) } 
    f(45) 
    
    #Arguments after '...'
    args(paste) 
    function (..., sep = " ", collapse = NULL) 
      paste("a", "b", sep = ":") 
    paste("a", "b", se = ":") 
    
    
    #Lexical Scoping
    f <- function(x, y) { 
      x^2 + y / z 
    } 
    
    make.power <- function(n) 
    { pow <- function(x) { 
      x^n 
    } 
    pow 
    } 
    
    cube <- make.power(3)
    square <- make.power(2) 
    cube(3) 
    square(3) 
    
    #Exploring a Function Closure
    ls(environment(cube)) 
    get("n", environment(cube)) 
    ls(environment(square)) 
    get("n", environment(square)) 
    
    #Lexical vs. Dynamic Scoping
    
    y <- 10 
    f <- function(x) { 
      y <- 2 
      y^2 + g(x) 
    } 
    g <- function(x) { 
      x * y 
    } 
    
    f(3) 
    
    
    g <- function(x) { 
      + 	a <- 3 
      + 	x + a + y 
      + } 
    
    g(2) 
    
    y <- 3 > g(2) 
