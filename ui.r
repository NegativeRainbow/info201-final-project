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
          selectInput('...', label = "....", choices = list("..." = '...'))
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
      
  