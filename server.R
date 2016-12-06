library(shiny)
library(dplyr)
library(plotly)
shinyServer(function(input, output) {

  #Ryan's widgets -- not complete
  dataInputChart <- reactive({
    switch(input$plotDrugs,
           "promoChart" = promoChart,
           "drugSales" = drugSales,
           "drugPrescriptions" = drugPrescriptions)
  })

  output$drugSummary <- renderText({"Analysis of the specific drugs that companies and organizations lobby for to the hospitals and physicians in Washington.\n 
                         Below is a visualization of the payments that these promoters make to the hospitals and physicians in order to persuade\n
                         them to prescribe a certain drug. (Refer to the tab of the left to also see overall drug sales and overall monthly\n 
                         prescription numbers and how they relate to the promoted drugs)"})
})