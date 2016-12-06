library(dplyr)
library(plotly)
library(leaflet)
library(shiny)


source('./scripts/buildMap.R')
source('./scripts/physicianChart.R')
source('./scripts/drugChart.R')


shinyServer(function(input, output) {
  #Davis' widgets
  output$map <- renderLeaflet({
    return(BuildMap(input$yearvar))
  })
  
  #Ryan's widgets -- not complete
  dataInputChart <- reactive({
    switch(input$plotDrugs,
           "promoChart" = 'promoChart',
           "drugSales" = 'top_drug_sales',
           "drugPrescriptions" = 'most_prescribed_drugs')
  })
  
  

  output$drugChart <- renderPlotly({
        return(buildDrugChart(input$yearData, input$amountOrPayment))
  })
   output$salesChart <- renderPlotly({
    
        return(buildTopDrugChart(dataInputChart(), input$yearData))
     
   })
   output$prescriptionChart <- renderPlotly({

        return(buildTopDrugChart(dataInputChart(), input$yearData))
   })
  
  #Mo's widgets
  output$chart <- renderPlotly({
    p <- physicianChart(input$yearSelect, input$firstName, input$lastName)
    return(p)
  })
  
  output$physicianText <- renderText({
    "In the year 2013, ... had the most total earning in payments while in 2014 and 2015, ... had the most total earning in payments"
  })

})