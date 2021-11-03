#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
source("../packages.R")

# Define UI for application that draws a histogram
ui <- dashboardPage(
    
    # Application title
    dashboardHeader(title= "Movies and Series Analysis"),
    dashboardSidebar(),
    dashboardBody(
        box(plotOutput("distPlot")),
        box(plotOutput("distPlot2")),
        box(plotOutput("distPlot3")),
        box(plotOutput("distPlot4"))
        
    ),
    mainPanel(
        plotOutput("distPlot"),
        plotOutput("distPlot2"),
        plotOutput("distPlot3"),
        plotOutput("distPlot4")
    )
)    