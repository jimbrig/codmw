
#  ------------------------------------------------------------------------
#
# Title : UI
#    By : Jimmy Briggs
#  Date : 2020-02-10
#
#  ------------------------------------------------------------------------

# header ------------------------------------------------------------------
header <- shinydashboard::dashboardHeader(

  title = tags$a(
    tags$img(
      src = "img/codmw-logo.jpg",
      width = 200,
    ),
    href = "#"
  )
)

# sidebar -----------------------------------------------------------------
sidebar <- shinydashboard::dashboardSidebar(

  tags$div(
    align = "center",
    style = "font-weight: bold; color: #ffffff;",
    hr(),
    h5(
      icon_text("xbox", "Call of Duty Modern Warfare"),
    ),
    br(),
    h5(
      icon_text("clock", "Data Last Updated as of:"),
      br(),
      Sys.time()
    ),
    hr()
  ),

  shinydashboard::sidebarMenu(
    id = "sidebar_menus",
    shinydashboard::menuItem(
      "Dashbaord",
      tabName = "dash",
      icon = shiny::icon("dashboard"),
      selected = TRUE
    ),
    shinydashboard::menuItem(
      "Records",
      tabName = "records",
      icon = shiny::icon("trophy")
    ),
    shinydashboard::menuItem(
      "Clan",
      tabName = "clan",
      icon = shiny::icon("users")
    )
  )
)

body <- shinydashboard::dashboardBody(

  shinydashboard::tabItem(
    tabName = "dash",
    shinydashboard::tabBox(
      id = "dash_tab",
      title = icon_text("dashboard", "Dashbaord"),
      width = 12,

      shiny::tabPanel(
        title = icon_text("calculator", "Gamer Stats"),
        width = 12,

        fluidRow(
          column(
            width = 4,
            shinyWidgets::pickerInput(
              "stat",
              label = "Select Stat:",
              choices = stat_choices,
              selected = "current_win_streak"
            )
          ),

          column(3,
                 shinydashboard::infoBoxOutput("valboxes")
          )
        ),

        DT::dataTableOutput("table")
      )
    )
  )

)

shinydashboard::dashboardPage(
  header = header,
  sidebar = sidebar,
  body = body,
  title = "COD App",
  skin = "black"
)
