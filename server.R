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
  
  #Changes based on the selector to choose which graph to plot
  dataInputChart <- reactive({
    switch(input$plotDrugs,
           "promoChart" = 'promoChart',
           "drugSales" = 'top_drug_sales',
           "drugPrescriptions" = 'most_prescribed_drugs')
  })
  
  
  #Create the promotion chart at default if it is selected by the user
  output$drugChart <- renderPlotly({
    if(dataInputChart() == "promoChart") {
      return(buildDrugChart(input$yearData))
    } else {
      return(NULL)
    }
  })
  
   #Create the top drug sales chart if the user selects it
   output$salesChart <- renderPlotly({
     if(dataInputChart() == "top_drug_sales") {
       return(buildTopDrugChart(dataInputChart(), input$yearData))
     } else {
       return(NULL)
     }
   })
   
   #Create the most prescribed drugs chart if the user selects it
   output$prescriptionChart <- renderPlotly({
    if(dataInputChart() == "most_prescribed_drugs") {
        return(buildTopDrugChart(dataInputChart(), input$yearData))
    } else {
      return(NULL)
    }
   })
  
  #Mo's widgets
  output$chart <- renderPlotly({
    validate(
      need(input$firstName, 'Please enter first name'),
      need(input$lastName, 'Please enter last name')
    )
    p <- physicianChart(input$yearSelect, input$firstName, input$lastName)
    return(p)
  })
  
  output$physicianText <- renderText({
    "This chart compares the total amount money a phycisian earned in payments and the average of total earnings for all physicians in Washington State during the selected year."
  })

})