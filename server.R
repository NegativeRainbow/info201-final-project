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
    return(buildDrugChart(dataInputChart(), input$yearData, input$amountOrPayment))
  })
  # output$salesChart <- renderPlotly({
  #   return(buildDrugChart(drugSales,))
  # })
  # output$prescriptionChart <- renderPlotly({
  #   return(buildDrugChart())
  # })


  
  #Mo's widgets
  output$chart <- renderPlotly({
    p <- physicianChart(input$yearSelect, input$doctorSelect1, input$doctorSelect2)
    return(p)
  })

})