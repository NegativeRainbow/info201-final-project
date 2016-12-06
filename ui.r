library(shiny)
library(dplyr)
library(plotly)

shinyUI(navbarPage('Info Final Project',
    tabPanel('Hospital map',
      sidebarLayout(
        sidebarPanel(
          selectInput('yearvar', label = "Which Year?", choices = list("2015" = '2015', "2014" = '2014', "2013" = '2013'))
      ),
        mainPanel(
          plotOutput("plot")
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
          plotOutput("plot")
        )
      )
    )
  )
)
      
  