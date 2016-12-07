library(shiny)
library(dplyr)
library(plotly)
library(leaflet)

shinyUI(fluidPage(
  navbarPage('Info Final Project',
    tabPanel('Hospital map',
      sidebarLayout(
        sidebarPanel(
          selectInput('yearvar', label = "Select Year:", choices = list("2015" = '2015_hospital_data.csv', 
                                                                       "2014" = '2014_hospital_data.csv', 
                                                                       "2013" = '2013_hospital_data.csv'))
      ),
        mainPanel(
          h2("Map of Hospitals that Recieved Money from Drug Organizations"),
          leafletOutput("map")
        )
      )
    ),
    tabPanel('Drug Chart',
      sidebarLayout(
        sidebarPanel(
          selectInput('yearData', label = "Select Year:", choices = list("2015" = '2015',"2014" = '2014', 
                                                                         "2013" = '2013'), selected = '2015'),
          selectInput('plotDrugs', label = "Select Graph:",
                      choices = list("Promoted Drugs" = 'promoChart', "Overall Drug Prescriptions" = 'drugPrescriptions',
                                     "Overall Drug Sales" = 'drugSales'),
                      selected = "promoChart"
          )
        ),
        mainPanel(
          conditionalPanel(condition = "input.plotDrugs == 'promoChart'",
                           h1("Top 100 Promoted Prescription Drugs"),
                           h4("Analysis of the payments that companies and organizations make to hospitals and physicians in order to persuade
               them to prescribe a certain drug."),
                           p("(A large majority of payments/gifts were not for a specific drug and are not shown here. \n
                                  Also only the top 100 drugs are shown from each yearly dataset)"),
          br(),
          plotlyOutput("drugChart", height = "100%", width = "100%")),
          
          conditionalPanel(condition = "input.plotDrugs == 'drugSales'",
                           h1("Top 100 Best Selling Prescription Drugs"),
                           h4("Analysis of the top selling prescription drugs in the U.S."),
                           p("(Only the top 100 drugs are shown from each yearly dataset)"),
          br(),
          plotlyOutput("salesChart", height = "100%", width = "100%")),
          conditionalPanel(condition = "input.plotDrugs == 'drugPrescriptions'",
                           h1("Top 100 Most Prescribed Prescription Drugs"),
                           h4("Analysis of the most prescribed prescription drugs in the U.S."),
                           p("(Only the top 100 drugs are shown from each yearly dataset)"),
          br(),
          plotlyOutput("prescriptionChart", height = "100%", width = "100%"))
        )
      )
    ),
    tabPanel('Physicans Comparison',
      sidebarLayout(
        sidebarPanel(
          selectInput('yearSelect', label = "Select Year", choices = list("2013" = 2013, "2014" = 2014, "2015" = 2015), selected = 2015),
          textInput("firstName", label = "Enter a physician's first name", value = "Michael"),
          textInput("lastName", label = "Enter a physician's last name", value = "Silverman"),
          hr()
        ),
        mainPanel(
          plotlyOutput('chart'),
          textOutput('physicianText')
        )
      )
    ),
    tabPanel('About Us',
      sidebarLayout(
        sidebarPanel(
          img(src = "https://i.redd.it/bx6x3642swmx.jpg", height = 400, width = 400), width = 6,
          br(),
          br(),
          h1("Members:"),
          h4("Danish, Davis, Muhammad, Ryan")
        ),
        mainPanel(
          h1("Target Audience"),
          h4("Patients that are worried that their doctors may be suffering a conflict of interest between giving them the best care possible and financial gains from pharmaceutical companies"),
          h1("Frame"),
          h4("After opening up the csv final, we realized how messy the data was...")
        )
      )
    )
  )
))
      
  