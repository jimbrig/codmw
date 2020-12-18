
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
    shiny::selectInput("game", "Select Game:", choices = c("Modern Warefare" = "mw", "Black Ops Cold War" = "bo"), selected = "bo") %>%
      shinyjs::disabled(),
    shinydashboard::menuItem(
      "Dashbaord",
      tabName = "dash",
      icon = shiny::icon("dashboard"),
      selected = TRUE
    ),
    shinydashboard::menuItem(
      "Videos",
      tabName = "videos",
      icon = shiny::icon("film")
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
  shinydashboard::tabItems(
    tabItem(
      tabName = "dash",
      box(
        title = "Stat Selector:",
        width = 12,
        collapsible = TRUE,
        fluidRow(
          column(
            6,
            shinyWidgets::pickerInput(
              "stat",
              label = icon_text("calculator", "Select Stats:"),
              choices = stat_choices,
              multiple = TRUE,
              selected = stat_choices[c(1:3)]
            )
          ),
          column(
            6,
            shinyWidgets::pickerInput(
              "tag",
              label = icon_text("xbox", "Select Gamertag:"),
              choices = gamertag_choices,
              selected = gamertags[2]
            )
          )
        ),
        hr(),
        fluidRow(
          column(
            12,
            shinydashboard::infoBoxOutput("statbox", width = 4),
            shinydashboard::infoBoxOutput("statbox2", width = 4),
            shinydashboard::infoBoxOutput("statbox3", width = 4)
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
      ),

      fluidRow(
        box(
          title = "WELCOME!",
          collapsible = TRUE,
          collapsed = FALSE,
          width = 12,
          htmltools::includeMarkdown("welcome.md")
        )
      )
    ),
    tabItem(
      tabName = "videos",
      fluidRow(
        column(
          12,
          shinydashboard::tabBox(
            width = 12,
            title = icon_text("film", "Regiment Uploaded Videos:"),
            tabPanel(
              title = "Recently Uploaded:",
              fluidRow(
                column(12,
                       box(
                         background = "black",
                         width = 6,
                         title = "MACE2DAFACE",
                         footer = "Uploaded by: Munchy",
                         HTML('<iframe width="100%" height="315"
           src="https://www.youtube.com/embed/O05UqXBu68k" frameborder="0"
           allow="accelerometer; autoplay; encrypted-media; gyroscope;
           picture-in-picture" allowfullscreen></iframe>')
                       ),
                       box(
                         background = "black",
                         width = 6,
                         title = "CHOPPERDOWN",
                         footer = "Uploaded by: KimithJongith",
                         HTML('<iframe width="100%" height="315"
           src="https://www.youtube.com/embed/SpfZ3FW5Lzo"
           frameborder="0" allow="accelerometer; autoplay;
           encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
                       )
                ),
                fluidRow(
                  div(
                    style = "text-align: center",
                    shiny::actionButton("upload_video", label = "Upload a Video"),
                    tags$a(h3("Official DocZees Video Channel"),
                           href = "https://www.youtube.com/channel/UCovK7IiXrhewBjb-ZZtKOig/")
                  )
                )
              )
            )
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
  title = "DocZees Call of Duty Tracker App",
  skin = "black"
)
