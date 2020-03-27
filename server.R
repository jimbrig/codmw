
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

  data_filter <- reactiveVal(NULL)

  observeEvent(input$stat, {

    out <- data()$all %>%
      filter(stat_name %in% input$stat)

    data_filter(out)
  })

  output$table <- DT::renderDataTable({
    req(data_filter())


    out <- data()[["all"]] %>%
      mutate_if(is.numeric, round, 2)

    num_cols <- out %>% select_if(is.numeric) %>% names()

    DT::datatable(
      out,
      rownames = FALSE,
      caption = "Al is a  N00b.",
      colnames = c("Stat", stringr::str_replace_all(gamertags, "%20", " ")),
      style = "bootstrap",
      extensions = c("ColReorder", "Buttons"),
      options = list(
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print', I('colvis')),
        list(colReorder = TRUE)
      )
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
      colnames = c("Mode", "Stat", stringr::str_replace_all(gamertags, "%20", " ")),
      style = "bootstrap",
      caption = "Al is a  N00b.",
      extensions = c("Responsive", "ColReorder", "Buttons"),
      options = list(
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print', I('colvis')),
        list(colReorder = TRUE)
      )) %>%
      DT::formatRound(num_cols, digits = 2)

  })

  output$statbox <- shinydashboard::renderInfoBox({

    hold <- data()[["all"]] %>%
      filter(stat_name == input$stat[1]) %>%
      slice(1) %>%
      pull(input$tag) %>%
      round(., digits = 2)

    shinydashboard::infoBox(
      title = names(gamertag_choices)[match(input$tag, gamertags)],
      value = hold,
      subtitle = input$stat[1],
      icon = shiny::icon("gamepad"),
      color = "black",
      width = 12
    )

  })

  output$statbox2 <- shinydashboard::renderInfoBox({

    hold <- data()[["all"]] %>%
      filter(stat_name == input$stat[2]) %>%
      slice(1) %>%
      pull(input$tag) %>%
      round(., digits = 2)

    shinydashboard::infoBox(
      title = names(gamertag_choices)[match(input$tag, gamertags)],
      value = hold,
      subtitle = input$stat[2],
      icon = shiny::icon("gamepad"),
      color = "black",
      width = 12
    )

  })

  output$statbox3 <- shinydashboard::renderInfoBox({

    hold <- data()[["all"]] %>%
      filter(stat_name == input$stat[3]) %>%
      slice(1) %>%
      pull(input$tag) %>%
      round(., digits = 2)

    shinydashboard::infoBox(
      title = names(gamertag_choices)[match(input$tag, gamertags)],
      value = hold,
      subtitle = input$stat[3],
      icon = shiny::icon("gamepad"),
      color = "black",
      width = 12
    )

  })

}

