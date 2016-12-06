library(shiny)
library(dplyr)
library(plotly)
shinyServer(function(input, output, session) {
  
  #Ryan's widgets -- not complete
  dataInputChart <- reactive({
    switch(input$plot,
           "promoChart" = promoChart,
           "drugSales" = drugSales,
           "drugPrescriptions" = drugPrescriptions)
  })
  output$value <- renderPrint({ input$radio })
  output$chart <- renderPlot({
    plot(cars, type=input$plotType)
  })
})