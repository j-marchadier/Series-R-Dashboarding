#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define UI for application that draws a histogram
ui <- dashboardPage(
    
    dashboardHeader(title= "Movies and Series Analysis"),
    dashboardSidebar(
        sidebarMenu(
            selectInput("v_select",label= "Type :",choices=c("Series and Movies","Movie","Series"),
                        selected="Series and Movies"),
            selectInput("score","Score :",c("All","Best 30 Scores","Best 100 Scores","Worse 100 Scores"),
                        selected="All"),
            selectInput("runtime_select",label= "Runtime :",choices=c("All",
                        "< 30 minutes","30-60 mins","1-2 hour","> 2 hrs"),selected="All")
            
            
        
    )),
    dashboardBody(
        fluidRow(
        
        box(plotOutput("histogram"),align="center"),
        box(plotOutput("mapgraph"),align="center"),
        box(plotOutput("piechart"),align="center"),
        box(plotOutput("boxofficechart"),align="center")
        
        
    ))
)    