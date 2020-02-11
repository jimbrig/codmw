
#  ------------------------------------------------------------------------
#
# Title : Server
#    By : Jimmy Briggs
#  Date : 2020-02-10
#
#  ------------------------------------------------------------------------

# Define server logic required to draw a histogram
server <- function(input, output, session) {

  data <- reactive({

    # browser()

    get_lifetime_data(gamertags)[["all"]]

  })

  output$table <- DT::renderDataTable({

    out <- data()

    DT::datatable(
      out,
      style = "bootstrap"
    ) %>%
      DT::formatRound(2:4, 2)
  })



  output$valboxes <- shinydashboard::renderInfoBox({

    hold <- data() %>%
      filter(stat_name == input$stat) %>%
      slice(1) %>%
      pull(2) %>%
      round(.,2)

    shinydashboard::infoBox(
      gamertags[1],
      hold,
      subtitle = "Stats",
      icon = shiny::icon("gamepad"),
      color = "black"
    )

  })

}

