library(XML)
library(dplyr)
library(stringr)
library(rvest)
library(audio)
library(sentimentr)

##Basic
##https://www.amazon.com/dp/B0012IOXWU


#Remove all white space
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

prod_code = "B005NL739M"
url <- paste0("https://www.amazon.com/dp/", prod_code)
doc <- read_html(url)

#obtain the text in the node, remove "\n" from the text, and remove white space
prod <- html_nodes(doc, "#productTitle") %>% html_text() %>% gsub("\n", "", .) %>% trim()
prod

#Source funtion to Parse Amazon html pages for data
source("https://raw.githubusercontent.com/rjsaito/Just-R-Things/master/Text%20Mining/amazonscraper.R")

pages <- 10

reviews_all <- NULL
for(page_num in 1:pages){
  url <- paste0("http://www.amazon.com/product-reviews/",prod_code,"/?pageNumber=", page_num)
  doc <- read_html(url)
  
  reviews <- amazon_scraper(doc, reviewer = F, delay = 2)
  reviews_all <- rbind(reviews_all, cbind(prod, reviews))
}

pacman::p_load_gh("trinker/sentimentr")

sent_agg <- with(reviews_all, sentiment_by(comments))
head(sent_agg)

par(mfrow=c(1,2))
with(reviews_all, hist(stars))
with(sent_agg, hist(ave_sentiment))




##Loop Placeholder
prods <- read.csv('C:/Users/Jeff/Desktop/prods.csv')

code <- as.vector(prods$Code)
dscr <- as.vector(prods$Product)


#Remove all white space
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

for (i in 1:11) {
  prod_code = code[i]
  url <- paste0("https://www.amazon.com/dp/", prod_code)
  doc <- read_html(url)
  prod <- html_nodes(doc, "#productTitle") %>% html_text() %>% gsub("\n", "", .) %>% trim()
  prod
  source("https://raw.githubusercontent.com/rjsaito/Just-R-Things/master/Text%20Mining/amazonscraper.R")
  pages <- 10
  
  reviews_all <- NULL
  
  for(page_num in 1:pages){
    url <- paste0("https://www.amazon.com/product-reviews/",prod_code,"/?pageNumber=", page_num)
    doc <- read_html(url)
    
    reviews <- amazon_scraper(doc, reviewer = F, delay = 2)
    reviews_all <- rbind(reviews_all, cbind(prod, reviews))
    pacman::p_load_gh("trinker/sentimentr")
    
    sent_agg <- with(reviews_all, sentiment_by(comments))
    head(sent_agg)
    
    par(mfrow=c(1,2),oma=c(4,0,4,0))
    for (i in 1:11) {
      prod_code2 = dscr[i]
      with(reviews_all, hist(stars, main = paste("")))
      with(sent_agg, hist(ave_sentiment, main = paste("")))
      mtext(prod_code2, side=3, line=1, outer=TRUE, cex=2, font=2)
    }
  }
}




##Amazon_Scraper
# R Code Starts here ...
library(rvest)
library("rvest", lib.loc="~/R/win-library/3.1")
# Testing on amazon transend 
url_amazon<-"https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords=HAMERMILL+TIDAL&rh=i%3Aaps%2Ck%3AHAMERMILL+TIDAL"
url_amazon

#
Amazon_titled_h1<- url_amazon %>%
  read_html() %>%
  html_nodes(".titled h1") %>%
  html_text()
Amazon_titled_h1 # Nothing on the webpage has a CSS SELECTOR - "titled h1"

#
Amazon_Normal_Text<- url_amazon %>%
  read_html() %>%
  html_nodes(".a-text-normal") %>%
  html_text()
head(Amazon_Normal_Text)# Output for CSS Selector - ".a-text-normal"

#
Amazon_Normal_Text1<- url_amazon %>%
  read_html() %>%
  html_nodes(".a-text-normal:nth-child(1)") %>%
  html_text()
head(Amazon_Normal_Text1)# Output for CSS Selector - ".a-text-normal"
#
df<- data.frame(Amazon_Normal_Text,stringsAsFactors = FALSE)
View(df)
#
df1<- data.frame(Amazon_Normal_Text1,stringsAsFactors = FALSE)
View(df1)
#
Amazon_Normal_Text2<- url_amazon %>%
  read_html() %>%
  html_nodes(".a-text-normal:nth-child(1)") %>%
  html_text()
head(Amazon_Normal_Text2)# Output for CSS Selector - ".a-text-normal"

write.csv(df1, file = "C:/Users/Jeff/Desktop/spls_scrape_test_010417.csv", row.names = FALSE)




