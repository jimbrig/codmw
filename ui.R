
#  ------------------------------------------------------------------------
#
# Title : UI
#    By : Jimmy Briggs
#  Date : 2020-02-10
#
#  ------------------------------------------------------------------------

# header ------------------------------------------------------------------
header <- shinydashboard::dashboardHeader(
  title = icon_text("xbox", "CODMW") #, # insert_logo("img/codmw-logo-alt.jpg", width = 200)
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
    h5(
      icon_text("clock", "Data Last Updated as of:"),
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
        fluidRow(
          column(
            5,
            shinydashboard::infoBoxOutput("statbox", width = 12)
          ),
          column(
            width = 5,
            shinyWidgets::pickerInput(
              "stat",
              label = icon_text("calculator", "Select Stat:"),
              choices = stat_choices,
              selected = "current_win_streak"
            ),
            shinyWidgets::pickerInput(
              "tag",
              label = icon_text("xbox", "Select Gamertag:"),
              choices = gamertag_choices,
              selected = gamertags[2]
            )
          )
        ),
        hr(),
    shinydashboard::tabBox(
      id = "data_tab",
      title = icon_text("table", "Data"),
      width = 12,
      shiny::tabPanel(
        title = "Lifetime Gamer Stats",
        icon = shiny::icon("xbox"),
        fluidRow(
          column(
            12,
            DT::dataTableOutput("table")
          )
        )
      ),
      shiny::tabPanel(
        title = "Stats by Game Mode",
        icon = shiny::icon("gamepad"),
        fluidRow(
          column(
            12,
            shinyWidgets::pickerInput(
              "mode",
              label = icon_text("table", "Select Data Type:"),
              choices = c("HC Domination" = "hc_dom", "HC Kill Confirmed" = "hc_conf"),
              selected = c("HC Domination" = "hc_dom", "HC Kill Confirmed" = "hc_conf"),
              multiple = TRUE
            ),
            DT::dataTableOutput("table_mode")
          )
        )
      )
    )
  ),
  setBackgroundImage(
    src = "img/codmw_background_3.jpeg",
    shinydashboard = TRUE
  )
)

shinydashboard::dashboardPage(
  header = header,
  sidebar = sidebar,
  body = body,
  title = "COD App",
  skin = "black"
)
