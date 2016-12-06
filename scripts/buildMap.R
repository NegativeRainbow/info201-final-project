library(leaflet)
library(dplyr)
library(stringr)

#Using the leaflet package we are able to create a map that places markers where hosiptals are
BuildMap <- function(year) {
  # Read in the csv file the viewer wants to see..
  dataset <- read.csv(paste0('data/sanitized/',year))
  #Using the duplicated function we eliminate any duplicates so we have only one marker for each hospital
  unique.hospitals <- dataset[!duplicated(dataset$Teaching_Hospital_ID),]
  #Get total sum of how much the hospitals got paid
  total.payment <- dataset %>% group_by(Teaching_Hospital_ID) %>% summarise(Total = sum(Total_Amount_of_Payment_USDollars))
  #Merge the two data frame
  merged.dataset <- left_join(unique.hospitals, total.payment)
  
  # Create map with markers
  m <- leaflet(merged.dataset) %>%
    addTiles() %>%  # Add default OpenStreetMap map tiles
    # Add markers using long and lat and description when viewer hovers over marker
    addMarkers(~lon, ~lat, popup= ~paste0("<b>Name: </b>", str_to_title(Teaching_Hospital_Name),
                                          "<br><b>Address: </b>", address,
                                          "<br><b>Total Payment: </b>$", paste(format(Total, big.mark=","),sep=""))) 
  return(m)  # Print the map
}