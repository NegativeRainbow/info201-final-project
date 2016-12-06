library(dplyr)
library(plotly)
library(leaflet)
library(shiny)

source('./scripts/buildMap.R')


shinyServer(function(input, output) {
  #Davis' widgets
  output$map <- renderLeaflet({
    return(BuildMap(input$yearvar))
  })
  
  #Ryan's widgets -- not complete
  dataInputChart <- reactive({
    switch(input$plotSelect,
           "Chart1" = "PromoChart",
           "Chart2" = "DrugSales",
           "Chart3" = "DrugPrescriptions")
  })
})