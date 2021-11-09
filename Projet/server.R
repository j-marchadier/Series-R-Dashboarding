#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
source("../global.R")
source("../Fonctions/functions.R")
source("../Fonctions/clean_country.R")
source("../Fonctions/clean_genre.R")
source("../Fonctions/trace_histo.R")
source("../Fonctions/trace_map_plot.R")
source("../Fonctions/trace_geom_plot.R")
source("../Fonctions/trace_pie_chart.R")


server <- function(input, output) {
    
    filter1 <- reactive({
        if(input$v_select == "Series and Movies"){#Filtering according to the type
            data
        } else {
            data %>%
                filter(series_or_movies == input$v_select)}})
    
    
    filter2 <- reactive({
        if(input$score == "All"){
            filter1()
        } else if (input$score=="Best 30 Scores"){#Filtering according to score
            filter1()[1:30,]
        } else if (input$score=="Best 100 Scores"){
            filter1()[1:100,]
        } else{
            filter1()%>% drop_na(imdb_score)
            tail(filter1(),100)}})
    
    
    df_filtr <- reactive({
        if(input$runtime_select == "All"){#Filtering according to the run time
            filter2()
        } else {
            filter2() %>%
                filter(run_time == input$runtime_select)}})
    
    
    
    df_map <- reactive({
    #We create a database in order to exploit the country information
    final_data_country= clean_country(df_filtr())
    
    #We create here the database needed to plot the map
    fuse= final_data_country %>% select(c(region, hidden_gem_score))
    data_map <- fuse %>% group_by(region) %>% 
        dplyr::summarize(hidden_gem_score=mean(hidden_gem_score,na.rm=TRUE))
    mapdata=map_data("world")
    df_map=left_join(mapdata,data_map,by="region")
    
    return(df_map)
    })
    
    
    df_pie <- reactive({
    #We create a database in order to exploit the genre information
    final_data_genre=clean_genre(df_filtr())    
        
    #We create here our database which goes into our pie chart ggplot
    final_data_genre %>%
            count(genre) %>%
            mutate(perc = n*100 / nrow(final_data_genre)) -> df_pie
    options(digits=2)
    df_pie$perc=round(df_pie$perc,2)
    
        
    df_pie$genre=df_pie$genre[order(df_pie$perc)];df_pie$perc=sort(df_pie$perc)
    df_pie$genre.factor=factor(df_pie$genre,levels=as.character(df_pie$genre))
        
        return(df_pie)
    })
    
    output$histogram <- renderPlot({
        trace_histo(df_filtr())
        })
   
     output$mapgraph <- renderPlot({
        trace_map_plot(df_map)
        })  
    
     output$piechart <- renderPlot({
       trace_pie_chart(df_pie)
        })
    
    output$boxofficechart <- renderPlot({
        trace_geom_plot(df_filtr())
        })
}