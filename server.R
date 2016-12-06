shinyServer(function(input, output) {
  
  #Ryan's widgets -- not complete
  dataInputChart <- reactive({
    switch(input$plotSelect,
           "Chart1" = "PromoChart",
           "Chart2" = "DrugSales",
           "Chart3" = "DrugPrescriptions")
  })
)}