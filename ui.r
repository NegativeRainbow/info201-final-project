library(shiny)
library(dplyr)
library(plotly)
library(markdown)

shinyUI(
  navbarPage('Info Final Project',
    tabPanel('Hospital map',
      sidebarLayout(
        sidebarPanel(
          selectInput('yearvar', label = "Which Year?", choices = list("2015" = '2015_hospital_data.csv', "2014_hospital_data.csv" = '2014', "2013" = '2013_hospital_data.csv'))
      ),
        mainPanel(
          plotOutput("plot")
        )
      )
    ),
    tabPanel('Drug Chart',
      sidebarLayout(
        sidebarPanel(
          radioButtons("radio", label = h3("Radio buttons"),
                       choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3), 
                       selected = 1),
          
          hr(),
          textOutput("value")
          #selectInput('plot', label = "Select Graph:", 
         #             choices = list("Promoted Drugs" = 'promoChart', "Overall Drug Prescriptions" = 'drugSales',
         #                            "Overall Drug Sales" = 'drugPrescriptions'),
         #             selected = "promo"
         # ),
         # fluidRow(column(3, verbatimTextOutput("value"))),
         # br()
          #conditionalPanel(condition = "ouput.chart == 'sales'",
          #                 checkboxInput("compareToData", label = "Compare to Drug Promotions", value = FALSE))
        ),
        mainPanel(
          textOutput("text1"),
          plotOutput("chart")
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
      
  