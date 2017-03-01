#R Workshop:  Getting and Cleaning Data

#1: Manipulating Data with dplyr
#2: Grouping and Chaining with dplyr
#3: Tidying Data with tidyr
#4: Dates and Times with lubridate


#Manipulating Data with dplyr

##Repoint to Git

mydf <- read.csv('https://raw.github.com/jmonroe252/R_Workshop/master/path2.csv', stringsAsFactors = FALSE)

dim(mydf)

head(mydf)

library(dplyr)

packageVersion('dplyr')

cran <- tbl_df(mydf)

rm("mydf")

cran

?select

select(cran, ip_id, package, country)
5:20

select(cran, r_arch:country)

select(cran, country:r_arch)

select(cran, -time)

-5:20

-(5:20)

select(cran, -(X:size))

filter(cran, package == "swirl")

filter(cran, r_version == "3.1.1", country == "US")

?Comparison


filter(cran, r_version <= "3.0.2", country == "IN")

filter(cran, country == "US" | country == "IN")

filter(cran, size > 100500, r_os == "linux-gnu")

is.na(c(3, 5, NA, 10))

!is.na(c(3, 5, NA, 10))


filter(cran, !is.na(r_version))

cran2 <- select(cran, size:ip_id)


select(cran, size:ip_id)

arrange(cran2, ip_id)

arrange(cran2, desc(ip_id))

arrange(cran2, package, ip_id)


arrange(cran2, country, desc(r_version), ip_id)

cran3 <- select(cran, ip_id, package, size)

cran3

mutate(cran3, size_mb = size / 2^20)

mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)

mutate(cran3, correct_size = size +1000)

summarize(cran, avg_bytes = mean(size))


##Grouping and Chaining with dplyr

cran <- tbl_df(mydf)

rm('mydf')

cran


?group_by


by_package <- group_by(cran, package)


summarize(by_package, mean(size))

# Compute four values, in the following order, from
# the grouped data:
#
# 1. count = n()
# 2. unique = n_distinct(ip_id)
# 3. countries = n_distinct(country)
# 4. avg_bytes = mean(size)
#
# A few thing to be careful of:
#
# 1. Separate arguments by commas
# 2. Make sure you have a closing parenthesis
# 3. Check your spelling!
# 4. Store the result in pack_sum (for 'package summary')
#
# You should also take a look at ?n and ?n_distinct, so
# that you really understand what is going on.

pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))

quantile(pack_sum$count, probs = 0.99)

top_counts <- filter(pack_sum, count > 679)

top_counts

View(top_counts)


top_counts_sorted <- arrange(top_counts, desc(count))
View(top_counts_sorted)

quantile(pack_sum$unique, probs = 0.99)

top_unique <- filter(pack_sum, unique > 465)

View(top_unique)

top_unique_sorted <- arrange(top_unique, desc(unique))


View(top_unique_sorted)

##Chaining or Piping

by_package <- group_by(cran, package)
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))


top_countries <- filter(pack_sum, countries > 60)
result1 <- arrange(top_countries, desc(countries), avg_bytes)

# Print the results to the console.
print(result1)


##Same script, but chained

result2 <-
  arrange(
    filter(
      summarize(
        group_by(cran,
                 package
        ),
        count = n(),
        unique = n_distinct(ip_id),
        countries = n_distinct(country),
        avg_bytes = mean(size)
      ),
      countries > 60
    ),
    desc(countries),
    avg_bytes
  )

print(result2)


# select() the following columns from cran. Keep in mind
# that when you're using the chaining operator, you don't
# need to specify the name of the data tbl in your call to
# select().
#
# 1. ip_id
# 2. country
# 3. package
# 4. size
#
# The call to print() at the end of the chain is optional,
# but necessary if you want your results printed to the
# console. Note that since there are no additional arguments
# to print(), you can leave off the parentheses after
# the function name. This is a convenient feature of the %>%
# operator.

cran %>%
  select(ip_id,country, package, size ) %>%
  print


# Use mutate() to add a column called size_mb that contains
# the size of each download in megabytes (i.e. size / 2^20).
#
# If you want your results printed to the console, add
# print to the end of your chain.

cran %>%
  select(ip_id, country, package, size) %>%
  mutate()

# Use mutate() to add a column called size_mb that contains
# the size of each download in megabytes (i.e. size / 2^20).
#
# If you want your results printed to the console, add
# print to the end of your chain.

cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20)


# Use filter() to select all rows for which size_mb is
# less than or equal to (<=) 0.5.
#
# If you want your results printed to the console, add
# print to the end of your chain.

cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  filter(size_mb <= 0.5)

# arrange() the result by size_mb, in descending order.
#
# If you want your results printed to the console, add
# print to the end of your chain.

cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  filter(size_mb <= 0.5) %>%
  arrange(desc(size_mb))


##Tidying Data with tidyr


library(tidyr)
library(dplyr)


#Ref:  http://vita.had.co.nz/papers/tidy-data.pdf

?gather

library(tidyr)
library(dplyr)

#drug and heartrate data
messy <- data.frame(
  name = c("Wilbur", "Petunia", "Gregory"),
  a = c(67, 80, 64),
  b = c(56, 90, 50)
)
messy

##gather==melt, seperate==cast

messy %>%
  gather(drug, heartrate, a:b)

set.seed(10)
messy <- data.frame(
  id = 1:4,
  trt = sample(rep(c('control', 'treatment'), each = 2)),
  work.T1 = runif(4),
  home.T1 = runif(4),
  work.T2 = runif(4),
  home.T2 = runif(4)
)


tidier <- messy %>%
  gather(key, time, -id, -trt)
tidier %>% head(8)

tidy <- tidier %>%
  separate(key, into = c("location", "time"), sep = "\\.") 
tidy %>% head(8)


library(readr)
##readr
data <- read_csv(readr_example("mtcars.csv"))
data
s <- spec(data)

# Alternatively you can use a spec function instead, which will only read the
# first 1000 rows (user configurable with guess_max)
s <- spec_csv(readr_example("mtcars.csv"))

# Automatically set the default to the most common type
cols_condense(s)


library(lubridate)

ymd("20110604")

mdy("06-04-2011")
dmy("04/06/2011")

arrive <- ymd_hms("2011-06-04 12:00:00", tz = "Pacific/Auckland")
arrive

leave <- ymd_hms("2011-08-10 14:00:00", tz = "Pacific/Auckland")
leave

second(arrive)

second(arrive) <- 25
arrive


second(arrive) <- 0

wday(arrive)

wday(arrive, label = TRUE)


meeting <- ymd_hms("2011-07-01 09:00:00", tz = "Pacific/Auckland")
with_tz(meeting, "America/Chicago")
auckland <- interval(arrive, leave) 
auckland

auckland <- arrive %--% leave
auckland


jsm <- interval(ymd(20110720, tz = "Pacific/Auckland"), ymd(20110831, tz = "Pacific/Auckland"))
jsm
































