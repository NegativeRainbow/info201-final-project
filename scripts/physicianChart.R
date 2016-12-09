library(dplyr)
library(plotly)
library(stringr)

# This function accepts the physician data frame returns a uniqe version of it
uniquephysicianData <- function(dataset) {
  # making the unique data frame
  unique.doctors <- dataset[!duplicated(dataset$Physician_Profile_ID),]
  total.payment <- dataset %>% group_by(Physician_Profile_ID) %>% summarise(Total = sum(Total_Amount_of_Payment_USDollars))
  merged.dataset <- left_join(unique.doctors, total.payment)
  merged.dataset <- merged.dataset %>% arrange(-Total)
  
  # gathering hover information to be displayed on the chart
  name <- paste0("Name: ", str_to_title(merged.dataset$Physician_First_Name), " ", str_to_title(merged.dataset$Physician_Last_Name))
  specialty <- paste0("Specialty: ", merged.dataset$Physician_Specialty)
  address <- paste0("Business Address: ", merged.dataset$Recipient_Primary_Business_Street_Address_Line1, " ", merged.dataset$Recipient_City, " ", merged.dataset$Recipient_State, " ", merged.dataset$Recipient_Zip_Code, " ", merged.dataset$Recipient_Country)
  total.payment <- paste0("Total Amount Received in US Dollars: $", format(merged.dataset$Total, big.mark = ","))
  merged.dataset$hover <- with(merged.dataset, paste0(name, '<br>', specialty, '<br>', address, '<br>', total.payment))
  
  return(merged.dataset)
}


# This function accepts three parameters: 'df' as the data frame, first name and last name of the physicians searched from the UI
# It returns a data frame full of the payments for that doctor
getdoctorPayments <- function(df, first.name, last.name) {
    # To handle case insensitive
    upper.first <- toupper(first.name)
    upper.last <- toupper(last.name)
    cap.first <- str_to_title(first.name)
    cap.last <- str_to_title(last.name)
    doctor.payments <- df %>% filter((Physician_First_Name == first.name | Physician_First_Name == upper.first | Physician_First_Name == cap.first) & 
                                       (Physician_Last_Name == last.name | Physician_Last_Name == upper.last | Physician_Last_Name == cap.last))
  
  return(doctor.payments)
}


# This function accepts two parameters: 'df' as the data frame being passed and 'ID' as the ID if the desired physician
# It returns the data frame of all the payments received by the doctor with the 'ID'
searchwithID <- function(df,ID) {
  ID.payment <- df %>% filter(Physician_Profile_ID == ID)
  
  return(ID.payment)
}


# This function accepts three parameters: 'df' as the data frame to be used, the first name and the last name of the physician to be searched
# It returns a chart that compares both doctor's total payment
physicianChart <- function(year, first.name, last.name) {
  dataset <- read.csv(paste0('data/sanitized/', year, '_doctor_data.csv'), stringsAsFactors = FALSE)
  
  dataset <- uniquephysicianData(dataset)
  
  # doctor1.payments is a data frame about the average of total earnings
  doctor1.payments <-  data.frame(Title = as.character(paste0("Average of Total Earnings in year ", year)), hover = as.character(paste0("The average of total earnings in the year ",year, " was $", format(mean(dataset$Total), big.mark = ","))))
  doctor1.payments <- data.frame(lapply(doctor1.payments, as.character), stringsAsFactors = FALSE)
  doctor1.payments$Total <- mean(dataset$Total)
    
  doctor2.payments <-  getdoctorPayments(dataset, first.name, last.name) # getting the information of the doctor being searched from the UI   
    
  if(nrow(doctor2.payments) == 0){
    doctor2.payments <- lapply(data.frame(Physician_First_Name = "Physician Not Found", Physician_Last_Name = "NA", hover = "Physician Not Found"), as.character)
    doctor2.payments$Total <- 0
    Doctor_Names <- c(doctor2.payments$Physician_First_Name, doctor1.payments$Title)
    Total <- c(doctor2.payments$Total, doctor1.payments$Total)
    hover <- c(doctor2.payments$hover, doctor1.payments$hover)
  } else {
    Doctor_Names <- c(str_to_title(paste(first.name, last.name)), doctor1.payments$Title)
    Total <- c(doctor2.payments$Total, doctor1.payments$Total)
    hover <- c(doctor2.payments$hover, doctor1.payments$hover)
  }
  
  # creating a dataframe with infos to be used for making the chart
  chart.df <- data.frame(Doctor_Names, Total, hover)
  
  # using plotly to make the chart
  p <- plot_ly(chart.df, x = ~Doctor_Names, y = ~Total, type = 'bar', text = ~hover,
               marker = list(color = c('rgba(222,45,38,0.8)', 'rgba(204,204,204,1)'))) %>%
    layout(title = "",
           xaxis = list(title = ""),
           yaxis = list(title = paste("Total Amount of payment earned in", year,"(US Dollars)")),
           margin = list(pad = 5))
  
  return(p)
}

