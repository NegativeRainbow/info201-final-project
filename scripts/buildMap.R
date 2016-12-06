library(leaflet)
library(dplyr)
library(stringr)

#Using the leaflet package we are able to create a map that places markers where hosiptals are
BuildMap <- function(year) {
  dataset <- read.csv(paste0('data/sanitized/',year))
  #Using the duplicated function we eliminate any duplicates so we have only one marker for each hospital
  unique.hospitals <- dataset[!duplicated(dataset$Teaching_Hospital_ID),]
  
  # Create map with markers
  m <- leaflet(unique.hospitals) %>%
    addTiles() %>%  # Add default OpenStreetMap map tiles
    addMarkers(~lon, ~lat, popup= ~paste0("<b>Name: </b>", str_to_title(Teaching_Hospital_Name), "<br><b>Address: </b>", address)) # Add markers using long and lat
  return(m)  # Print the map
}
