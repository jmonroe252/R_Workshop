#R Workshop - Section 2

#Some Basics - A little review
#Create a dataframe from scratch
age <- c(25, 30, 56) 
gender <- c("male", "female", "male") 
weight <- c(160, 110, 220) 
mydata <- data.frame(age,gender,weight) 

#Using the Editor
mydata <- data.frame(age=numeric(0), gender=character(0), weight=numeric(0))
mydata <- edit(mydata)

#Create a dataframe from scratch
age <- c(25, 30, 56) 
gender <- c("male", "female", "male") 
weight <- c(160, 110, 220) 
mydata <- data.frame(age,gender,weight) 


#Testing for Missing Values
is.na(x) # returns TRUE of x is missing
y <- c(1,2,3,NA)
is.na(y) # returns a vector (F F F T) 

#Recoding Values to Missing
# recode 99 to missing for variable v1
# select rows where v1 is 99 and recode column v1 
mydata[mydata$v1==99,"v1"] <- NA 

#Excluding Missing Values from Analyses
#Arithmetic functions on missing values yield missing values. 
x <- c(1,2,NA,3)
mean(x) # returns NA
mean(x, na.rm=TRUE) # returns 2 


mydata[!complete.cases(mydata),]
newdata <- na.omit(mydata) 

#Create new variables
mydata$sum <- mydata$x1 + mydata$x2
mydata$mean <- (mydata$x1 + mydata$x2)/2 
attach(mydata) 
mydata$sum <- x1 + x2
mydata$mean <- (x1 + x2)/2
detach(mydata)
mydata <- transform( mydata,sum = x1 + x2, mean = (x1 + x2)/2)

# create 2 age categories
mydata$agecat <- ifelse(mydata$age > 70, c("older"), c("younger")) 
# another example: create 3 age categories 
attach(mydata)
mydata$agecat[age > 75] <- "Elder"
mydata$agecat[age > 45 & age <= 75] <- "Middle Aged"
mydata$agecat[age <= 45] <- "Young"
detach(mydata) 

# create 2 age categories 
mydata$agecat <- ifelse(mydata$age > 70, c("older"), c("younger")) 

# another example: create 3 age categories 
attach(mydata)
mydata$agecat[age > 75] <- "Elder"
mydata$agecat[age > 45 & age <= 75] <- "Middle Aged"
mydata$agecat[age <= 45] <- "Young"
detach(mydata) 


# rename interactively 
fix(mydata) # results are saved on close 
# rename programmatically 

library(reshape)
mydata <- rename(mydata, c(oldname="newname"))
# you can re-enter all the variable names in order
# changing the ones you need to change.the limitation
# is that you need to enter all of them!
names(mydata) <- c("x1","age","y", "ses") 

# sorting examples using the mtcars dataset
data(mtcars)
# sort by mpg
newdata = mtcars[order(mtcars$mpg),] 
# sort by mpg and cyl
newdata <- mtcars[order(mtcars$mpg, mtcars$cyl),]
#sort by mpg (ascending) and cyl (descending)
newdata <- mtcars[order(mtcars$mpg, -mtcars$cyl),] 

#Example
#Import Data
urlfile <-'https://raw.github.com/jmonroe252/R_Workshop/master/regions.csv'
region <-read.csv(urlfile)

urlfile <-'https://raw.github.com/jmonroe252/R_Workshop/master/trade.csv'
trade <-read.csv(urlfile)

#Rename Partner.Country in Trade dataset
names(trade)[names(trade)=="Partner.Country"] <- "Country"

#Merge 
trade1 <- (merge(region, trade, by = 'Country'))

#Drop unused columns and rename for next merge
colnames(trade1)
trade1 <- trade1[c(1,2,6:58)]

names(trade1)[names(trade1)=="Country"] <- "Partner_Country"
names(trade1)[names(trade1)=="Region"] <- "Partner_Region"
names(trade1)[names(trade1)=="Reporting.Country"] <- "Country"

trade1 <- (merge(region, trade1, by = 'Country'))
names(trade1)[names(trade1)=="Country"] <- "Reporting_Country"
names(trade1)[names(trade1)=="Region"] <- "Reporting_Region"

trade1 <- trade1[c(1,2,6:59)]

#Aggregate the data, adding a year column
library(reshape)
trade1[] <- lapply(trade1, as.character)
trade2 <- melt(trade1, id=c("Reporting_Country","Reporting_Region", "Partner_Country", "Partner_Region", "Segment"))
names(trade2)[names(trade2)=="variable"] <- "Year"

#Convert Year to numeric
trade2$Year <- gsub("X", "", paste(trade2$Year))
trade2$Year <- as.numeric(trade2$Year)
trade2$value <- as.numeric(trade2$value)

#Sum by Reporting, Partner Region and Year
trade3 <-aggregate(trade2$value, by=list(trade2$Reporting_Region, trade2$Partner_Region, trade2$Year), 
                    FUN=sum, na.rm=TRUE)

#But the column names are messed up
trade3 <- aggregate(trade2["value"], by=trade2[c("Reporting_Region","Partner_Region", "Segment", "Year")], FUN=sum)


##Review
#1 Create a dataframe with the following columns and data
type1 <- c(5, 10, 15) 
type2 <- c("good", "bad", "good") 
type3 <- c(100, 150, 200) 
q1 <- data.frame(type1,type2,type3) 

#Create 2 categories in a new column named Type4 where type 3 sub1 < 150 and sub2 => 150
q1$type4 <- ifelse(q1$type3 < 150, c("sub1"), c("sub2")) 

#Q3, Retrieve the Region and Trade files from Github
#Merge the Region and Trade files by Partner Country field 
urlfile <-'https://raw.github.com/jmonroe252/R_Workshop/master/regions.csv'
region <-read.csv(urlfile)

urlfile <-'https://raw.github.com/jmonroe252/R_Workshop/master/trade.csv'
trade <-read.csv(urlfile)

names(trade)[names(trade)=="Partner.Country"] <- "Country"

#Merge 
trade1 <- (merge(region, trade, by = 'Country'))

#Remove all columns except Partner_Country, Segment, and the Dates 1990:2040 
trade1 <- trade1[c(1,7:58)]

#Melt the data so the columns are Country, Segment, Year, value
trade1[] <- lapply(trade1, as.character)
trade2 <- melt(trade1, id=c("Country", "Segment"))
names(trade2)[names(trade2)=="variable"] <- "Year"
#Aggregate value by Country, Segment and Year
trade2$Year <- gsub("X", "", paste(trade2$Year))
trade2$Year <- as.numeric(trade2$Year)
trade2$value <- as.numeric(trade2$value)
trade3 <- aggregate(trade2["value"], by=trade2[c("Country","Segment", "Year")], FUN=sum)