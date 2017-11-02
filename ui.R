library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Choose CSV File",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")
      ),
      tags$hr(),
      checkboxInput("header", "Header", TRUE),
      uiOutput('listsup'),
      uiOutput('supplier'),
      #actionButton("actionplotly", "Plotly")
      HTML('<h2 style="color: #2e6c80;">Instructions:</h2>
            <p>Load a CSV file with the following structure.</p>
           <ul>
           <li>Route</li>
           <li>Supplier</li>
           <li>Scheduled</li>
           <li>Scheduled_End</li>
           <li>Real</li>
           <li>Real_End</li>
           </ul>
           <p>The process will split the data into traning and testig and for now only predict using Linear Model</p>
           <p>Download the sample data <a href="https://drive.google.com/file/d/1jsbker9L1oXDWnsucrrYir8y6Kvg7NsS/view?usp=sharing" target="_blank" rel="noopener">here.</a></p>
        ')
    ),
    mainPanel(
      plotlyOutput("pplotly")
    )
  )
)
)
