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

})