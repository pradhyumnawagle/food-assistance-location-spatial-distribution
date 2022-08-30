library(tibble)
library(dplyr)
library(tidygeocoder)
library(readxl)


agency.date.list <- read_excel('Agency List_ourData + Fresh Trak Use.xlsx')

#column 8 onwards


agency.date.list$sum <- rowSums(agency.date.list[,c(8, ncol(agency.date.list))])

library(DT)
datatable(agency.date.list, rownames = FALSE) %>%
  formatStyle(columns = c("Q2 2017", "Q3 2017", "Q4 2017",    
                          "Q1 2018" , "Q2 2018", "Q3 2018", "Q4 2018", "Q1 2019",    
                          "Q2 2019" , "Q3 2019",  "Q4 2019", "Q1 2020", "Q2 2020",    
                          "Q3 2020" , "Q4 2020",  "Q1 2021",  "Q2 2021",  "Q3 2021",    
                          "Q4 2021"), 
              background = styleInterval(c('NO'), c( "green", "red")))
  