library(shiny)
library(plotly)
# Define server logic required to draw a histogram
shinyServer(
  function(input, output) {
    
    output$listsup <- renderUI({
      source("Inic.R")
      inFile <- input$file1
      
      if (is.null(inFile))
        return(NULL)
      
      raw <- read.csv(inFile$datapath, header = input$header, sep = ';')

      testing <- process(raw)

       items= as.character(unique(testing$Usuario))
      # items2 = as.character(unique(testing$Cod.Cli))
       items2=as.character(unique(subset(testing, testing$Usuario == input$rt)$Cod.Cli))
       
       write.csv(testing, file = "testing.csv")
       bootstrapPage(
          span(selectInput("rt", "Route:",items), style="color:#0096D1"),
          span(selectInput("sup", "Supplier:",items2), style="color:#0096D1")
       )
    })
    
    modeldata <- reactive({
      testing <- read.csv('testing.csv')
      subset(testing, testing$Usuario == input$rt & testing$Cod.Cli == input$sup)

    })   
    
    output$pplotly <- renderPlotly({
      
    #  if ( input$actionplotly == 0 ) {
    #    return()
    #  } else {
      f <- list(
        family = "Courier New, monospace",
        size = 18,
        color = "#7f7f7f"
      )
      m <- list(
        l = 50,
        r = 50,
        b = 100,
        t = 100,
        pad = 4
      )
      plot_ly(data = modeldata(), x = ~Agendamento_Inic, y = ~TempoRealizado, type = 'scatter', mode = 'lines', name = 'Real' ) %>%
        add_trace(y = modeldata()$linear, name = 'Projection', mode = 'lines+markers')%>%
       # layout(plot_bgcolor='rgb(0, 0, 0)') %>% 
      #  layout(paper_bgcolor='black') %>% 
        layout(autosize = F, width = 500, height = 500, margin = m) %>%
        layout(xaxis = list(title = '', titlefont=f), yaxis = list(title = 'Time in Minutes', titlefont=f))
      
    #     }
      })
  })
