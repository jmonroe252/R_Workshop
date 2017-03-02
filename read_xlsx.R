##Read a xlsx file

library(openxlsx)

#Read RISI forecast
wb <- loadWorkbook('https://raw.github.com/jmonroe252/R_Workshop/master/AllRegions.xlsx')

##All Regions w/ Adjusted Capacity
wb <- loadWorkbook('//s02afs01.na.ipaper.com/Towers-050/Global Demand Model/DMODEL/Data/AllRegions_Cap_Adj.xlsx')
sheets <- sheets(wb)

df_total = data.frame()
for (i in 1:44) {
  df <- read.xlsx(wb, sheet = i, skipEmptyRows = TRUE, colNames = TRUE)
  df$Region <- head(colnames(df),1)
  names(df)[1] <- 'Segment'
  #dlist[[i]] <- df
  df <- data.frame(df)
  df_total <- rbind(df_total,df)
}

world_ufs <- df_total[ which(df_total$Segment == '   Uncoated Woodfree' & df_total$Region != 'World'), ]