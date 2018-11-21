library(shiny)
library(gapminder)
library(tidyverse)
library(DT)
library(shinythemes)
library(rsconnect)

# Define UI for application
ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("Alvin's Gapminder App: GDP per capita plots"),
  sidebarLayout(
    sidebarPanel(
      #Add input choices for gdpPerCap range, continents, plot types, and columns to display
      sliderInput("gdpInput", "Range of GDP Per Capita:", 241, 113524, c(241, 113524), pre = "$"),
      checkboxGroupInput("continentInput", "Continents to display:",
                         levels(gapminder$continent), selected = levels(gapminder$continent)),
      radioButtons("plotInput", "Plot type:",
                   choices = c("Violin", "Jitter", "Both"),
                   selected = "Both"),
      checkboxGroupInput("colDisplay", "Columns in table to display:",
                         names(gapminder), selected = names(gapminder))
    ),
    mainPanel(
      #Output plot and table
      plotOutput("gapminder_plot"),
      dataTableOutput("gapminder_data")
    )
  )
  
)

# Define server logic required
server <- function(input, output) {
  
  #Filter gapminder for gdpPerCap range and continent
  gapminder_filtered <-  reactive({gapminder %>%
      filter(gdpPercap < input$gdpInput[2],
             gdpPercap > input$gdpInput[1],
             continent %in% input$continentInput)})
  
  #Display either violin, jitter, or both
  output$gapminder_plot <- renderPlot({
    switch(input$plotInput,
           Violin = gapminder_filtered() %>%
             ggplot(aes(x = continent, y = gdpPercap)) +
             scale_y_log10() +
             theme_bw() +
             geom_violin(aes(fill = continent), show.legend = FALSE), #Violin
           Jitter = gapminder_filtered() %>%
             ggplot(aes(x = continent, y = gdpPercap)) +
             scale_y_log10() +
             theme_bw() +
             geom_jitter(alpha = 0.2), #jitter
           Both = gapminder_filtered() %>%
             ggplot(aes(x = continent, y = gdpPercap)) +
             scale_y_log10() +
             theme_bw() +
             geom_violin(aes(fill = continent), show.legend = FALSE) + #Violin
             geom_jitter(alpha = 0.2)) #And jitter
  })
  
  #output table, and select desired columns
  output$gapminder_data <- renderDataTable({
    gapminder_filtered() %>%
      select(input$colDisplay)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)