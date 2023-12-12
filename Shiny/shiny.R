# Load packages
library(shiny)
library(ggplot2)
library(plotly)

#For TAB 1 BoxPlot

data <- readRDS("SOAI_AFINN.rds") |>
  select(YearsCode, Age, EdLevel, total_score)             

all_cols_values <- names(data)

############
#    ui    #
############
ui <- fluidPage(
  
  title="Survey Results",
  fluidRow(
        selectInput(inputId = "y_val"
                    , label = "Choose a variable of interest:"
                    , choices = all_cols_values
                    , selected = "Age"),
    
        plotlyOutput(outputId = "box")
  )
)


############
# server   #
############
server <- function(input,output){
  
  # TAB 1: BOXPLOT
  
  output$box <- renderPlotly({
    ggplot(data, aes_string(y = "total_score", x = input$y_val)) +
      geom_boxplot() +
      labs(y = "Response Score", x = input$y_val)
  })
  }
####################
# call to shinyApp #
####################
shinyApp(ui = ui, server = server)