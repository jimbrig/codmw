#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

  data <- reactive({

    map_dfr(urls, get_data) %>%
      # tibble::add_column("gamer" = gamertags) %>%
      # select(gamer, everything()) %>%
      t() %>%
      as_tibble(rownames = NA) %>%
      tibble::rownames_to_column("Stat") %>%
      set_names(c("stat", gamertags)) %>%
      as_tibble()

  })

  output$table <- DT::renderDataTable({

    out <- data() %>%
      mutate_at(vars(all_of(gamertags)), formattable::comma, digits = 2)

    DT::datatable(
      out,
      style = "bootstrap"
    ) %>%
      DT::formatRound(1:3, 2)
  })

})
