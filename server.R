library(dplyr)
library(plotly)
library(leaflet)
library(shiny)

# Using function 'source' we called our functions from the scripts folder
source('./scripts/buildMap.R')
source('./scripts/physicianChart.R')
source('./scripts/drugChart.R')

#Start shiny server
shinyServer(function(input, output) {
  #Render the leaflet map that returns a map of the usa with markers for where hospitals are
  #Calls function BuildMap that takes in the dataset the user wants
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