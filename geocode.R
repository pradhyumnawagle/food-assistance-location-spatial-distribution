library(tibble)
library(dplyr)
library(tidygeocoder)
library(readxl)


agency.list <- read_excel('Agency List.xlsx')
retailer.fbst <- read_csv('retailer_fbst.csv')


agency.list <- agency.list %>% dplyr::rename(name = "Agency Name")
agency.list <- select(agency.list, name, Address, City, St)

agency.list$combined_add <- paste(agency.list$Address, agency.list$City, agency.list$St)

address_single <- tibble(singlelineaddress = agency.list$combined_add, name = agency.list$name)

census_s1 <- address_single %>%
  geocode(address = singlelineaddress, method = "census", verbose = TRUE)


############################

############################

census_s1 <- na.omit(census_s1)
census_s1 <- select(census_s1, name, lat, long)

################################

retailer.fbst <- retailer.fbst %>% dplyr::rename(store = "Store Name")
snap.agencies <- select(retailer.fbst, Latitude, Longitude, store, enter, exit, enter_exit)
snap.agencies <- snap.agencies %>% dplyr::rename(lat = Latitude, long = Longitude)
#################################

get_snap_retailers <- function(df, metric){
  
  print({{metric}})
  if({{metric}} == "all_agencies"){
    
    return (select(df, lat, long, store))
    
  } else  if({{metric}} == "closed_agencies"){
    
    df <- df[df$exit == 1,]
    df <- df[df$enter == 0,]
    return (select(df, lat, long, store))
  
  } else  if({{metric}} == "new_agencies"){
    df <- df[df$enter == 1,]
    df <- df[df$exit == 0,]
    return (select(df, lat, long, store))
    
  }else  if({{metric}} == "enter_exit"){
    df <- df[df$enter_exit == 1,]
    return (select(df, lat, long, store))
  }
}
