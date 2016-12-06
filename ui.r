library(shiny)
library(dplyr)
library(plotly)
library(leaflet)

shinyUI(navbarPage('Info Final Project',
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
          selectInput('plotSelect', label = "Select Graph:", 
                      choices = list("Promoted Drugs" = 'Chart1', "Overall Drug Prescriptions" = 'Chart2',
                                     "Overall Drug Sales" = 'Chart3'),
                      selected = "Chart1"
          ),
          br(),
          conditionalPanel(condition = "input$plotSelect == 'Chart2'",
                           checkboxInput("compareToData", label = "Compare to Drug Promotions", value = FALSE))
          
        ),
        mainPanel(
          plotOutput("plot")
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
)
      
  