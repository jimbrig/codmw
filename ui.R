#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("COD"),

  # Sidebar with a slider input for number of bins
  # sidebarLayout(
  #   sidebarPanel(
  #
  #   ),

    # Show a plot of the generated distribution
    mainPanel(
      fluidRow(
        column(
          3,
          shinyWidgets::pickerInput(
            "stat",
            label = "Select Stat:",
            choices = stat_choices,
            selected = "currentWinStreak"
          )
        )
      ),

      fluidRow(
        shiny::uiOutput("valboxes")
      ),

      DT::dataTableOutput("table")

      # plotOutput("distPlot")
    )
  )
)
