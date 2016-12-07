library(plotly)
library(dplyr)
library(tidyr)


buildDrugChart <- function(year, amountOrPayment) {
  data <- read.csv(paste0('data/sanitized/',year,'_data.csv'))
  data <- select(data, Total_Amount_of_Payment_USDollars, Nature_of_Payment_or_Transfer_of_Value, Name_of_Associated_Covered_Drug_or_Biological1) %>%
          mutate("row" = 1:nrow(data), "payment.amount" = Total_Amount_of_Payment_USDollars) %>%
          filter(!(Name_of_Associated_Covered_Drug_or_Biological1 == ""))

  dataSumm <- spread(data, Nature_of_Payment_or_Transfer_of_Value, Total_Amount_of_Payment_USDollars) 
  
  colnames(dataSumm) <- c("name.of.drug", "row", "payment.amount", "charity", "comp.services", "comp.serving", "consulting", "education", "entertainment", 
                          "food.and.bev", "gifts", "grants", "honoraria", "royalty", "facility.rental", "travel.and.lodging")
  
  group <- group_by_(dataSumm, "name.of.drug") %>% summarise("total.payments" = n(), "total.amount" = sum(payment.amount),
                                                             "education" = sum(education, na.rm = TRUE), "compensation" = sum(comp.services, comp.serving, honoraria, royalty, na.rm=TRUE ),
                                                             "consulting" = sum(consulting, na.rm=TRUE), "food.and.bev" = sum(food.and.bev, na.rm=TRUE),
                                                             "travel.and.lodging" = sum(travel.and.lodging, na.rm=TRUE), "gifts" = sum(gifts, grants, charity, na.rm=TRUE),
                                                             "facility.rental" = sum(facility.rental, na.rm=TRUE))

p <- plot_ly(group, x =~eval(parse(text = "name.of.drug")), y =~eval(parse(text = paste0("total.", amountOrPayment))), type = 'bar', name = paste0("Total ",amountOrPayment)) %>%
  add_trace(y = ~eval(parse(text = "education")), name = 'Education') %>%     
  add_trace(y = ~eval(parse(text = "compensation")), name = 'Compensation') %>%     
  add_trace(y = ~eval(parse(text = "consulting")), name = 'Consulting') %>%     
  add_trace(y = ~eval(parse(text = "food.and.bev")), name = 'Food and Beverage') %>%     
  add_trace(y = ~eval(parse(text = "travel.and.lodging")), name = 'Travel and Lodging') %>%     
  add_trace(y = ~eval(parse(text = "gifts")), name = 'Gifts') %>%     
  add_trace(y = ~eval(parse(text = "facility.rental")), name = 'Facility Rental') %>%     
  layout(title = paste0("Most Promoted Drugs by Total ", amountOrPayment),
             xaxis = list(title = "Drug Name"),
             yaxis = list(title = paste0("Total ", amountOrPayment)),
             margin = list(b=120, l=120),
             barmode = 'stack')



  return(p)
}


buildTopDrugChart <- function(chartType, yearData) {
  type = "Sales"
  if(chartType == "most_prescribed_drugs") {
    type = "Prescriptions"
  }
  if(!(chartType == "promoChart"))
  yearlyData <- read.csv(paste0('data/sanitized/',yearData,'_', chartType,'.csv'))
  
  p2 <- plot_ly(yearlyData, x=~Drug.Name, y =~eval(parse(text = paste0("Drug.", type))), type = 'bar', name = paste0("Drug ",type)) %>%
    layout(title = paste0("Top Drug ", type),
           xaxis = list(title = "Drug Name"),
           yaxis = list(title = paste0("Drug ", type)),
           margin = list(b=120, l=120))


  return(p2)
}