library(plotly)
library(dplyr)
library(tidyr)
#Two functions in this script. One to plot the data used from the main data csv's.
#The other to plot the top 100 of each, top sales or prescriptions, depending on what the user selects

buildDrugChart <- function(year) {
  #Read in the data based on the year, and filter down to the total amount, type of payment, and drug name
  data <- read.csv(paste0('data/sanitized/',year,'_data.csv'))
  data <- select(data, Total_Amount_of_Payment_USDollars, Nature_of_Payment_or_Transfer_of_Value, Name_of_Associated_Covered_Drug_or_Biological1) %>%
          mutate("row" = 1:nrow(data), "payment.amount" = Total_Amount_of_Payment_USDollars) %>%
          filter(!(Name_of_Associated_Covered_Drug_or_Biological1 == ""))

  #Use spread from tidyr to reposition the data in order to graph it correctly as markers in plotly
  dataSumm <- spread(data, Nature_of_Payment_or_Transfer_of_Value, Total_Amount_of_Payment_USDollars) 
  
  #Rename the columns so that column names don't have spaces in them anymore and to shorten some column names
  colnames(dataSumm) <- c("name.of.drug", "row", "payment.amount", "charity", "comp.services", "comp.serving", "consulting", "education", "entertainment", 
                          "food.and.bev", "gifts", "grants", "honoraria", "royalty", "facility.rental", "travel.and.lodging")
  
  #Group the columns by type of payment, eliminating some of the redundant columns by combining them
  group <- group_by_(dataSumm, "name.of.drug") %>% summarise("total.payments" = n(), "total.amount" = sum(payment.amount),
                                                             "education" = sum(education, na.rm = TRUE), "compensation" = sum(comp.services, comp.serving, honoraria, royalty, na.rm=TRUE ),
                                                             "consulting" = sum(consulting, na.rm=TRUE), "food.and.bev" = sum(food.and.bev, na.rm=TRUE),
                                                             "travel.and.lodging" = sum(travel.and.lodging, na.rm=TRUE), "gifts" = sum(gifts, grants, charity, na.rm=TRUE),
                                                             "facility.rental" = sum(facility.rental, na.rm=TRUE))

#Plot the data in a stacked bar graph that shows exactly what portions of the payments went to each nature of payment
p <- plot_ly(group, x =~eval(parse(text = "name.of.drug")), y =~eval(parse(text = paste0("facility.rental"))), type = 'bar', name = paste0("Facility Rental")) %>%
  add_trace(y = ~eval(parse(text = "education")), name = 'Education') %>%     
  add_trace(y = ~eval(parse(text = "compensation")), name = 'Compensation') %>%     
  add_trace(y = ~eval(parse(text = "consulting")), name = 'Consulting') %>%     
  add_trace(y = ~eval(parse(text = "food.and.bev")), name = 'Food and Beverage') %>%     
  add_trace(y = ~eval(parse(text = "travel.and.lodging")), name = 'Travel and Lodging') %>%     
  add_trace(y = ~eval(parse(text = "gifts")), name = 'Gifts') %>%     
  layout(title = paste0("Most Promoted Drugs by Total Amount"),
             xaxis = list(title = "Drug Name"),
             yaxis = list(title = paste0("Total Amount")),
             margin = list(b=120, l=120),
             barmode = 'stack')



  return(p)
}


buildTopDrugChart <- function(chartType, yearData) {
  #Change the graph type based on what is selected
  type = "Sales"
  if(chartType == "most_prescribed_drugs") {
    type = "Prescriptions"
  }
  if(!(chartType == "promoChart"))
  #Read in the data for the specific year
  yearlyData <- read.csv(paste0('data/sanitized/',yearData,'_', chartType,'.csv'))
  
  #Create a bar graph that shows top sales or prescriptions for each drug
  p2 <- plot_ly(yearlyData, x=~Drug.Name, y =~eval(parse(text = paste0("Drug.", type))), type = 'bar', name = paste0("Drug ",type)) %>%
    layout(title = paste0("Top Drug ", type),
           xaxis = list(title = "Drug Name"),
           yaxis = list(title = paste0("Drug ", type)),
           margin = list(b=120, l=120))


  return(p2)
}