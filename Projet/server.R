#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
source("../packages.R")
source("../Valentin.R")

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$distPlot <- renderPlot({
        ggplot(data, aes(x=`imdb_vote`)) + geom_histogram(bins=10)
    })
    output$distPlot2 <- renderPlot({
        ggplot(data_map,aes(x=long,y=lat,group=group))+
            geom_polygon(aes(fill=hidden_gem_score),color="black")+
            ggtitle("Moyenne du Score Hidden Gem selon les Pays")+
            scale_fill_gradient(name="Hidden Gem Score",low="orange",high="purple",na.value="grey50")+
            theme(axis.text.x=element_blank(),
                  axis.text.y=element_blank(),
                  axis.ticks=element_blank(),
                  axis.title.x = element_blank(),
                  axis.title.y = element_blank())
        
    })  
    output$distPlot3 <- renderPlot({
        ggplot(data_pie, aes(x = "", y = perc,fill = genre.factor)) +
            geom_bar(stat = "identity",color="white")+
            coord_polar("y",start=0)+
            geom_text(aes(label = paste(round(perc / sum(perc) * 100, 1), "%","\n", genre)),size=data_pie$perc/4.5,
                      position = position_stack(vjust = 0.55)) +
            ggtitle("Domination of the different genres")+
            theme(plot.title = element_text(hjust=0.5,size=10),
                  axis.title = element_blank(),
                  axis.text = element_blank(),
                  axis.ticks = element_blank(),
                  panel.grid=element_blank(),
                  panel.border=element_blank(),
                  legend.title=element_text(hjust=0.5))+
            guides(fill=guide_legend(reverse=TRUE))+
            scale_fill_discrete(name="Genres")
        
    })
    
    output$distPlot4 <- renderPlot({
        ggplot(data, aes(x=factor(release_year),y=`box_office`)) +
            theme(axis.text.x = element_text(angle = 90,vjust=0.5)) +
            xlab("Release year")+
            ylab("Box office moyen")+
            stat_summary(fun=mean,geom="line",size=0.3, color="red",aes(group=1))+
            scale_x_discrete(breaks = scales::pretty_breaks(n = 10))
    })
}