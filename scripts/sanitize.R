library(dplyr)
dataset <- read.csv('data/general_payment_data_2013.csv', stringsAsFactors = FALSE)
doctors <- filter(dataset, Physician_Profile_ID != 0)
drugs <- group_by(doctors, Name_of_Associated_Covered_Drug_or_Biological1) %>%
  summarize(n = n(), Payment = sum(Total_Amount_of_Payment_USDollars))
hospitals <- filter(dataset, Teaching_Hospital_ID != 0)


# a function that returns a data of hospitals
gethospitalData <- function(year) {
  hospiltals <- read.csv(paste0('data/general_payment_data_', year, '.csv'), stringsAsFactors =  FALSE) %>%
    filter(Physician_Profile_ID == 0)
  return(hospitals)
}
  

# a function that returns a data of physicians
getphysiciansData <- function(year) {
  physicians <- read.csv(paste0('data/general_payment_data_', year, '.csv'), stringsAsFactors =  FALSE) %>%
    filter(Physician_Profile_ID != 0)
  return(physicians)
}


hospitals.2013 <- gethospitalData(2013)
physicians.2013 <- getphysiciansData(2013)
