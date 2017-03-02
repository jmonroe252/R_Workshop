
# Load the ggplot2 package which provides
# the 'mpg' dataset.
library(shiny)
library(rvest)

##Staples.com###########################################################################################
url_spls <- read_html('http://www.staples.com/hammermill+copy+plus/directory_hammermill%2520copy%2520plus?')

Product <- url_spls %>% 
  html_nodes(".pfm") %>%
  html_text() %>%
  stringr::str_replace_all("[\r\t\n]", "") %>% 
  trimws() %>%
  as.character() %>%
  as.data.frame() 

Product <- Product[!apply(is.na(Product) | Product == "", 1, all),]
Product <- as.data.frame(Product)

Price <- url_spls %>% 
  html_nodes(".discounted-price") %>%
  html_text() %>%
  stringr::str_replace_all("[\r\t\n]", "") %>% 
  trimws() %>%
  as.character() %>%
  as.data.frame() 

Price <- Price[!apply(is.na(Price) | Price == "", 1, all),]
Price <- as.data.frame(Price)

spls <- cbind(Product,Price)

spls$Store <- "Staples.com"
spls$Date <- Sys.Date()

##OfficeDepot.com###########################################################################################
url <- read_html("http://www.officedepot.com/catalog/search.do?Nty=1&Ntx=mode+matchpartialmax&Ntk=all&Ntt=copy+plus&N=5&cbxRefine=722807&cbxRefine=896193")

Product <- url %>% 
  html_nodes(".black") %>%
  html_text() %>%
  stringr::str_replace_all("[\r\t\n]", "") %>% 
  trimws() %>%
  as.character() %>%
  as.data.frame() 

Product <- Product[!apply(is.na(Product) | Product == "", 1, all),]
Product <- as.data.frame(Product)

Product <- Product[grep("Hammermill", Product$Product), ]
Product <- as.data.frame(Product)
Product$Product <- as.character(Product$Product)

Price <- url %>% 
  html_nodes(".right") %>%
  html_text() %>%
  stringr::str_replace_all("[\r\t\n]", "") %>% 
  trimws() %>%
  as.character() %>%
  as.data.frame() 

Price <- Price[!apply(is.na(Price) | Price == "", 1, all),]
Price <- as.data.frame(Price)

depot <- cbind(Product,Price)

depot$Store <- "OfficeDepot.com"
depot$Date <- Sys.Date()

##Amazon.com#################################################################################################
url <- read_html("https://www.amazon.com/s/ref=sr_nr_p_n_feature_two_brow_1?fst=as%3Aoff&rh=n%3A1064954%2Cn%3A1069242%2Cn%3A1069664%2Cn%3A1069712%2Ck%3Ahammermill+copy+paper%2Cp_n_size_browse-bin%3A515376011%2Cp_n_feature_keywords_two_browse-bin%3A7014633011%2Cp_n_feature_two_browse-bin%3A528170011&keywords=hammermill+copy+paper&ie=UTF8&qid=1487436836&rnid=528168011")

Product <- url %>% 
  html_nodes(".a-text-normal") %>%
  html_text() %>%
  stringr::str_replace_all("[\r\t\n]", "") %>% 
  trimws() %>%
  as.character() %>%
  as.data.frame() 

Product <- Product[!apply(is.na(Product) | Product == "", 1, all),]
Product <- as.data.frame(Product)

Product <- Product[grep("Hammermill", Product$Product), ]
Product <- as.data.frame(Product)
Product$Product <- as.character(Product$Product)

Product <- unique({Product})


Price1 <- url %>% 
  html_nodes(".sx-price-whole") %>%
  html_text() %>%
  stringr::str_replace_all("[\r\t\n]", "") %>% 
  trimws() %>%
  as.character() %>%
  as.data.frame() 

Price1 <- Price1[!apply(is.na(Price1) | Price1 == "", 1, all),]
Price1 <- as.data.frame(Price1)

Price2 <- url %>% 
  html_nodes(".sx-price-fractional") %>%
  html_text() %>%
  stringr::str_replace_all("[\r\t\n]", "") %>% 
  trimws() %>%
  as.character() %>%
  as.data.frame() 

Price2 <- Price2[!apply(is.na(Price2) | Price2 == "", 1, all),]
Price2 <- as.data.frame(Price2)

Price <- cbind(Price1,Price2)
Price$Price3 <- do.call(paste, c(Price[c("Price1", "Price2")], sep = ".")) 
Price <- c(Price$Price3)
Price <- as.data.frame(Price)
Price$Price <- as.character(Price$Price)


cbind.fill <- function(...){
  nm <- list(...) 
  nm <- lapply(nm, as.matrix)
  n <- max(sapply(nm, nrow)) 
  do.call(cbind, lapply(nm, function (x) 
    rbind(x, matrix(, n-nrow(x), ncol(x))))) 
}

amz = cbind.fill(Product, Price)

amz <- na.omit(amz)

amz <- as.data.frame(amz)

amz$Store <- "Amazon.com"
amz$Date <- Sys.Date()

prices <- rbind(spls, depot, amz)





ui <- fluidPage(
  titlePanel("Copy Paper Web Prices"),
  
  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(4,
           selectInput("Product",
                       "Product:",
                       c("All",
                         unique(as.character(prices$Product))))
    ),
    column(4,
           selectInput("Price",
                       "Price:",
                       c("All",
                         unique(as.character(prices$Price))))
    ),
    column(4,
           selectInput("Store",
                       "Store:",
                       c("All",
                         unique(as.character(prices$Store))))
    )
  ),
  # Create a new row for the table.
  fluidRow(
    DT::dataTableOutput("table")
  )
)


# Load the ggplot2 package which provides

server <- function(input, output) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- prices
    if (input$Product != "All") {
      data <- data[data$Product == input$Product,]
    }
    if (input$Price != "All") {
      data <- data[data$Price == input$Price,]
    }
    if (input$Store != "All") {
      data <- data[data$Store == input$Store,]
    }
    data
  }))
  
}

shinyApp(ui = ui, server = server)
