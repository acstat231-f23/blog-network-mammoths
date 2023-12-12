# Load packages
library(shiny)
library(ggplot2)
library(plotly)

#For TAB 1 BoxPlot

data <- readRDS("SOAI_AFINN.rds") |>
  mutate(NumYearsCode = as.numeric(YearsCode)) |>
  select(NumYearsCode, Age, EdLevel, total_score)

all_cols_values <- c("NumYearsCode", "Age", "EdLevel")
all_cols_names <- c("Number of Years Coding (Years)", "Age of Developer (Years)", "Education Level")

############
#    ui    #
############
ui <- fluidPage(
  
  title="Survey Results",
  fluidRow(
        selectInput(inputId = "y_val"
                    , label = "Choose a variable:"
                    , choices = all_cols_names
                    , selected = "Age"),
        plotlyOutput(outputId = "box", width = "100%", height = "700px")
  )
)

############
# server   #
############
server <- function(input,output){
  output$box <- renderPlotly({
    ggplot(data, aes_string(y = "total_score", x = all_cols_values[input$y_val == all_cols_names])) +
      geom_boxplot() +
      labs(y = "Response Score", x = input$y_val) +
      theme(axis.text.x = element_text(angle = 45))
  })}

####################
# call to shinyApp #
####################
shinyApp(ui = ui, server = server)