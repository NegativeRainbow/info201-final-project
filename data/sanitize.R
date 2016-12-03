library(dplyr)
library(ggmap)
# ggmap citation
# D. Kahle and H. Wickham. ggmap: Spatial Visualization with ggplot2. The R Journal, 5(1), 144-161. URL
# http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf

# Removes unnecessary columns from raw data
sanitize <- function(raw.data) {
  dataset <- select(raw.data, -Change_Type, -Recipient_Country, -Recipient_Province, -Recipient_Postal_Code, -Physician_License_State_code1, -Physician_License_State_code2, -Physician_License_State_code3, -Physician_License_State_code4, -Physician_License_State_code5, 
         -Dispute_Status_for_Publication, -Program_Year, -Payment_Publication_Date)
  return(dataset)
}
  

# Filters data to include just doctors, and removes unnecessary columns
sanitizeDoctors <- function(raw.data, year) {
  dataset <- filter(raw.data, Physician_Profile_ID != 0) %>%
    select(-Teaching_Hospital_CCN, -Teaching_Hospital_ID, -Teaching_Hospital_Name)
  write.csv(dataset, paste0('sanitized/', year, "_doctor_data.csv"))
}

# Filters data to include just doctors, removes unnecessary columns, and adds latitude and longitude
sanitizeHospitals <- function(raw.data, year) {
  dataset <- filter(raw.data, Teaching_Hospital_ID != 0) %>%
    select(-Physician_Profile_ID, -Physician_First_Name, -Physician_Middle_Name, -Physician_Last_Name, -Physician_Name_Suffix, 
           -Physician_Primary_Type, -Physician_Specialty)
  
  addresses <- paste0(dataset$Recipient_Primary_Business_Street_Address_Line1, ", ", dataset$Recipient_City, ", ", dataset$Recipient_State, " ", dataset$Recipient_Zip_Code)
  location.data <-data.frame(dataset$Recipient_Primary_Business_Street_Address_Line1, addresses) %>%
    unique() #creates new dataframe to condense number of rows to pass to ggmaps
  geocodes <- lapply(location.data$addresses, geocode) #returns list of dataframes
  geocodes <- do.call('rbind', geocodes) #compacts list of dataframes into one dataframe
  location.data$lon <- geocodes$lon
  location.data$lat <- geocodes$lat
  left_join(dataset, location.data, Recipient_Primary_Business_Street_Address_Line1) #rejoins lon and lat with original data
  
  write.csv(dataset, paste0('sanitized/', year, "_hospital_data.csv"))
}

# Sanitizes over the given years
for(year in 2013:2015){
  raw.dataset <- read.csv(paste0('raw/general_payment_data_', year, '.csv'), stringsAsFactors = FALSE)
  sanitized.dataset <- sanitize(raw.dataset)
  write.csv(sanitized.dataset, paste0('sanitized/', year, "_data.csv"))
  sanitizeDoctors(sanitized.dataset, year)
  sanitizeHospitals(sanitized.dataset, year)
}