library(shiny)
 #install.packages('rsconnect')
        #library(rsconnect)
        library(tidyverse)
ui <- fluidPage(headerPanel("Statistics Live births by state and sex in Malaysia"),
                textInput(inputId = "State",
                          label = "State:", value = "",
                          placeholder = "State"),
                selectInput(inputId = "Sex",
                            label =  "Sex",
                            choices = list(Female = "Female",
                                           Male = "Male")),
                sliderInput(inputId = "Year",
                            label = "Year Range:",
                            min = min(livebaby$Year),
                            max = max(livebaby$Year),
                            value = c(min(livebaby$Year),
                                      max(livebaby$Year)),
                            sep = ""),
                plotOutput(outputId = "nameplot"),
                submitButton(text = "show me the plot!")
  
)

server <- function(input, output, session) {
  output$nameplot <- renderPlot(livebaby %>%
                                  filter(Sex == input$Sex,
                                         State == input$State) %>%
                                  ggplot(aes(x = Year,
                                             y = `Number of Live births`)) +
                                  geom_line() +
                                  scale_x_continuous(limits = input$Year) +
                                  theme_minimal()) 
}

shinyApp(ui=ui, server=server)