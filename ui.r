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
          leafletOutput("map")
        )
      )
    ),
    tabPanel('Drug Chart',
      sidebarLayout(
        sidebarPanel(
          selectInput('yearData', label = "Select Year:", choices = list("2015" = '2015',"2014" = '2014', 
                                                                         "2013" = '2013'), selected = '2013'),
          selectInput('plotDrugs', label = "Select Graph:",
                      choices = list("Promoted Drugs" = 'promoChart', "Overall Drug Prescriptions" = 'drugSales',
                                     "Overall Drug Sales" = 'drugPrescriptions'),
                      selected = "promoChart"
          ),
          br(),
          conditionalPanel(condition = "input.plotDrugs == 'promoChart'",
                           radioButtons('amountOrPayment', label = "Rank Drugs by:",
                                        choices = list("Total Amount" = 'Amount', "Total Payments" = 'Payments'),
                                        selected = 'Amount'))
          #conditionalPanel(condition = "input.plotDrugs != 'promoChart'",
                           #checkboxInput("compareToData", label = "Compare to Drug Promotions", value = FALSE))
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
    tabPanel('Physicans',
      sidebarLayout(
        sidebarPanel(
          selectInput('yearSelect', label = "Select Year:", choices = list("2013" = '2013_doctor_data.csv', "2014" = '2014_doctor_data.csv', "2015" = '2015_doctor_data.csv'), selected = '2015_doctor_data.csv'),
          textInput("doctorSelect1", label = "Enter a physician's first name and last name", value = "Michael Silverman"),
          textInput("doctorSelect2", label = "Enter another physician's first name and last name", value = "Mark Elmore"),
          hr()
        ),
        mainPanel(
          plotlyOutput('chart')
        )
      )
    )
  )
))
      
  