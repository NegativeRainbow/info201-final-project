library(plotly)
library(dplyr)
library(tidyr)


buildDrugChart <- function(chartType, year, amountOrPayment) {

  data <- read.csv(paste0('data/sanitized/',year,'_data.csv'))

  data <- select(data, Total_Amount_of_Payment_USDollars, Nature_of_Payment_or_Transfer_of_Value, Name_of_Associated_Covered_Drug_or_Biological1) %>% 
          mutate("row" = 1:nrow(data), "payment.amount" = Total_Amount_of_Payment_USDollars) %>% 
          filter(!(Name_of_Associated_Covered_Drug_or_Biological1 == ""))

  dataSumm <- spread(data, Nature_of_Payment_or_Transfer_of_Value, Total_Amount_of_Payment_USDollars) %>% group_by(Name_of_Associated_Covered_Drug_or_Biological1) %>% 
              summarise("total.Payments" = n(), "education" = sum(Education, na.rm = TRUE), "total.Amount" = sum(payment.amount))
  
p <- plot_ly(dataSumm, x = ~Name_of_Associated_Covered_Drug_or_Biological1, y = ~eval(parse(text = paste0("total.", amountOrPayment))), type = 'bar', name = paste0("Total ",amountOrPayment)) %>%
    add_trace(y = ~education, name = 'Education') %>%
      layout(title = paste0("Most Promoted Drugs by Total ", amountOrPayment),
             xaxis = list(title = "Drug Name"),
             yaxis = list(title = paste0("Total", amountOrPayment)))
  

  
  return(p)
}
  
  # data <- read.csv(paste0('data/sanitized/',year,'_data.csv'))
  # if(as.character(chartType) != 'promoChart') {
  #   yearlyData <- read.csv(paste0('data/sanitized/',year,'_',chartType,'.csv'))
  # }
  # data <- select(data, Total_Amount_of_Payment_USDollars, Nature_of_Payment_or_Transfer_of_Value, Name_of_Associated_Covered_Drug_or_Biological1)