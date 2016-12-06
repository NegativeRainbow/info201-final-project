library(dplyr)
library(plotly)
library(stringr)
setwd("~/Documents/INFO201/info201-final-project")


# This function accepts two parameters: 'df' as the data frame, and 'first.name_last.name' as the doctor's name in the form "firstname lastname".
# It returns a data frame full of the payments for that doctor
getdoctorPayments <- function(df, first.name_last.name) {
  # To handle case insensitive
  full.name <- strsplit(first.name_last.name," ")[[1]]
  first.name <- full.name[1]
  last.name <- full.name[2]
  upper.first <- toupper(first.name)
  upper.last <- toupper(last.name)
  cap.first <- str_to_title(first.name)
  cap.last <- str_to_title(last.name)
  doctor.payments <- df %>% filter((Physician_First_Name == first.name | Physician_First_Name == upper.first | Physician_First_Name == cap.first) & 
                                     (Physician_Last_Name == last.name | Physician_Last_Name == upper.last | Physician_Last_Name == cap.last))
  
  # getting hover informations to be displayed in charts
  name <- paste0("Name: ", str_to_title(first.name), " ", str_to_title(last.name))
  specialty <- paste0("Specialty: ", doctor.payments$Physician_Specialty)
  address <- paste0("Business address: ", doctor.payments$Recipient_Primary_Business_Street_Address_Line1, " ", doctor.payments$Recipient_City, " ", doctor.payments$Recipient_State, " ", doctor.payments$Recipient_Zip_Code, " ", doctor.payments$Recipient_Country)
  total.payment <- paste0("Total payment in US Dollars: ", sum(doctor.payments$Total_Amount_of_Payment_USDollars))
  doctor.payments$Total_Payment_for_the_Year_USDollars <- sum(doctor.payments$Total_Amount_of_Payment_USDollars)
  
  # adding the hover information into a new colummn
  doctor.payments$hover <- with(doctor.payments, paste0(name, '<br>', specialty, '<br>', address, '<br>', total.payment))
  
  return(doctor.payments)
}

# This function accepts three parameters: 'df' as the data frame to be used, 'doctor1.name' as one doctor's name, and 'doctor2.name' as another doctor's name.
# It returns a chart that compares both doctor's total payment
physicianChart <- function(year, doctor1.name, doctor2.name) {
  dataset <- read.csv(paste0('data/sanitized/', year))
  
  doctor1.payments <- getdoctorPayments(dataset, doctor1.name) %>% head(1)
  doctor2.payments <- getdoctorPayments(dataset, doctor2.name) %>% head(1)
  
  Doctor_Names <- c(str_to_title(doctor1.name), str_to_title(doctor2.name))
  Total_Payment_for_the_Year_USDollars <- c(doctor1.payments$Total_Payment_for_the_Year_USDollars, doctor2.payments$Total_Payment_for_the_Year_USDollars)
  hover <- c(doctor1.payments$hover, doctor2.payments$hover)
  
  # creating a dataframe that will be used for making the chart
  chart.df <- data.frame(Doctor_Names, Total_Payment_for_the_Year_USDollars, hover)
  
  p <- plot_ly(chart.df, x = ~Doctor_Names, y = ~Total_Payment_for_the_Year_USDollars, type = 'bar', text = ~hover,
               marker = list(color = c('rgba(204,204,204,1)', 'rgba(222,45,38,0.8)'))) %>%
    layout(title = "",
           xaxis = list(title = ""),
           yaxis = list(title = "Total payment for the Year in US Dollars"))
  
  return(p)
}