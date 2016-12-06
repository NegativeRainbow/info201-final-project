library(shiny)
library(dplyr)
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
    switch(input$plotDrugs,
           "promoChart" = promoChart,
           "drugSales" = drugSales,
           "drugPrescriptions" = drugPrescriptions)
  })
  renderText({"Analysis of the specific drugs that companies and organizations lobby for to the hospitals and physicians in Washington.\n
               Below is a visualization of the payments that these promoters made to the hospitals and physicians in order to persuade \n 
               them to prescribe a certain drug. (Refer to the tab on the left to also see overall drug sales and overall monthly prescription \n
               numbers and how they relate to the promoted drugs)"})
})