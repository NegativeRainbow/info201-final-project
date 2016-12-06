library(shiny)
library(dplyr)
library(plotly)
library(leaflet)

shinyUI(fluidPage(
  navbarPage('Info Final Project',
    tabPanel('Hospital map',
      sidebarLayout(
        sidebarPanel(
          selectInput('yearvar', label = "Which Year?", choices = list("2015" = '2015_hospital_data.csv', 
                                                                       "2014" = '2014_hospital_data.csv', 
                                                                       "2013" = '2013_hospital_data.csv'))
      ),
        mainPanel(
          leafletOutput("map")
        )
      )
    ),
    tabPanel('Drug Chart',
      sidebarLayout(
        sidebarPanel(
          selectInput('plotDrugs', label = "Select Graph:",
                      choices = list("Promoted Drugs" = 'promoChart', "Overall Drug Prescriptions" = 'drugSales',
                                     "Overall Drug Sales" = 'drugPrescriptions'),
                      selected = "promo"
          ),
          br(),
          conditionalPanel(condition = "input.plotDrugs != 'promoChart'",
                           checkboxInput("compareToData", label = "Compare to Drug Promotions", value = FALSE))
        ),
        mainPanel(
          conditionalPanel(condition = "input.plotDrugs == 'promoChart'",
                           textOutput("drugSummary"))
                           
        )
      )
    ),
    tabPanel('Physicans',
      sidebarLayout(
        sidebarPanel(
          selectInput('...', label = "....", choices = list("..." = '...'))
        ),
        mainPanel(
        )
      )
    )
  )
))
      
  