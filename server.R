
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

    get_lifetime_data(gamertags)

  })

  output$table <- DT::renderDataTable({

    out <- data()[["all"]] %>%
      mutate_if(is.numeric, round, 2)

    num_cols <- out %>% select_if(is.numeric) %>% names()

    DT::datatable(
      out,
      rownames = FALSE,
      colnames = c("Stat", gamertags),
      style = "bootstrap"
    ) %>%
      DT::formatRound(num_cols, digits = 2)
  })

  output$table_mode <- DT::renderDT({

    out <- data()[["mode"]] %>%
      mutate_if(is.numeric, round, 2) %>%
      filter(mode %in% input[["mode"]]) %>%
      select(mode, everything())

    num_cols <- out %>% select_if(is.numeric) %>% names()

    DT::datatable(
      out,
      rownames = FALSE,
      colnames = c("Mode", "Stat", gamertags),
      style = "bootstrap"
    ) %>%
      DT::formatRound(num_cols, digits = 2)

  })

  output$statbox <- shinydashboard::renderInfoBox({

    hold <- data()[["all"]] %>%
      filter(stat_name == input$stat) %>%
      slice(1) %>%
      pull(input$tag) %>%
      round(., digits = 2)

    shinydashboard::infoBox(
      title = input$tag,
      value = hold,
      subtitle = input$stat,
      icon = shiny::icon("gamepad"),
      color = "black",
      width = 12
    )

  })

}

