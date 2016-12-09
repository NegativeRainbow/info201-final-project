library(shiny)
library(dplyr)
library(plotly)
library(leaflet)

shinyUI(fillPage(theme = "fancy.css",
  navbarPage('Info Final Project - Drug Promotions',
      # Davis' Widget
      # Created tab for map interaction
      tabPanel('WA Hospital Map',
      sidebarLayout(
        sidebarPanel(
          # Lets user choose what year of the dataset they want to see using a dropdown.
          selectInput('yearvar', label = "Select Year:", choices = list("2015" = '2015_hospital_data.csv', 
                                                                       "2014" = '2014_hospital_data.csv', 
                                                                       "2013" = '2013_hospital_data.csv'))
      ),
        mainPanel(
          # Create a header describing the map
          h2("Map of Hospitals that Recieved Money from Drug Organizations"),
          # Function to output interactive map using leaflet.
          leafletOutput("map")
        )
      )
    ),
    # Ryan's Widget
    tabPanel('Drug Chart',
      sidebarLayout(
        sidebarPanel(
          #Select which year of data to use
          selectInput('yearData', label = "Select Year:", choices = list("2015" = '2015',"2014" = '2014', 
                                                                         "2013" = '2013'), selected = '2015'),
          
          #Select which graph to view
          selectInput('plotDrugs', label = "Select Graph:",
                      choices = list("Promoted Drugs" = 'promoChart', "Overall Drug Prescriptions" = 'drugPrescriptions',
                                     "Overall Drug Sales" = 'drugSales'),
                      selected = "promoChart"
          )
        ),
        mainPanel(
          #Show as a default when the app opens and when the user selects "promotedDrugs"
          conditionalPanel(condition = "input.plotDrugs == 'promoChart'",
                           h1("Top 100 Promoted Prescription Drugs"),
                           h4("Analysis of the payments that companies and organizations make to hospitals and physicians in order to persuade
               them to prescribe a certain drug."),
                           p("(A large majority of payments/gifts were not for a specific drug and are not shown here. \n
                                  Also only the top 100 drugs are shown from each yearly dataset. Zoom for more info.)"),
          br(),
          plotlyOutput("drugChart", height = "100%", width = "100%")),
          
          #Show if use selects the 'drugSales' tab
          conditionalPanel(condition = "input.plotDrugs == 'drugSales'",
                           h1("Top 100 Best Selling Prescription Drugs"),
                           h4("Analysis of the top selling prescription drugs in the U.S."),
                           p("(Only the top 100 drugs are shown from each yearly dataset)"),
          br(),
          plotlyOutput("salesChart", height = "100%", width = "100%")),
          
          
          #Show if user selects the 'drugprescriptions' tab 
          conditionalPanel(condition = "input.plotDrugs == 'drugPrescriptions'",
                           h1("Top 100 Most Prescribed Prescription Drugs"),
                           h4("Analysis of the most prescribed prescription drugs in the U.S."),
                           p("(Only the top 100 drugs are shown from each yearly dataset)"),
          br(),
          plotlyOutput("prescriptionChart", height = "100%", width = "100%"))
        )
      )
    ),
    # Mo's Widget
    tabPanel('WA Physican Comparison',
      sidebarLayout(
        sidebarPanel(
          h1("Comparison Tool"),
          h5("Compare a physician's total earnings to the average total earnings of all physicians in Washington State."),
          selectInput('yearSelect', label = "Select Year:", choices = list("2013" = 2013, "2014" = 2014, "2015" = 2015), selected = 2015),
          textInput("firstName", label = "Enter a physician's first name:", value = "Michael"),
          textInput("lastName", label = "Enter a physician's last name:", value = "Silverman"),
          hr()
        ),
        mainPanel(
          plotlyOutput('chart'),
          h4(uiOutput('physicianText'))
        )
      )
    ),
    tabPanel('About Our Project',
      sidebarLayout(
        sidebarPanel(
          img(src = "https://environment.uw.edu/wp-content/themes/coenv-wordpress-theme/assets/img/logo-1200x1200.png", height = 400, width = 400), width = 6,
          br(),
          br(),
          h1("Members:"),
          h4("Danish Bashar, Davis Huynh, Muhammad Hariz, Ryan Mills")
        ),
        mainPanel(
          h1("Target Audience"),
          h4("Patients that are worried that their doctors may be suffering a conflict of interest between giving them the best care possible and financial gains from pharmaceutical companies"),
          h1("About the Data"),
          h4("We were watching a John Oliver video about free gifts given by pharmaceutical companies to doctors, which often has an impact on the prescriptions that doctors end up making.
             When the Affordable Care Act was made law, it stipulated that the US government had to collect data on every single transaction made between these companies and doctors.
             We took the data from the three years since the act was put into place (about 6gb per year) and filtered it down to data just about recipients in Washington State (cutting down the file size to about 60mb per year).
             Each row of the data specifies one transaction between a pharmaceutical company and a doctor/hospital, with various details such as the date, the recipient, the donor, what drugs the company is tied to, and more.
             We took this data and analyzed it into the other tabs, check those for more information about what they do.")
        )
      )
    )
  )
))
      
  