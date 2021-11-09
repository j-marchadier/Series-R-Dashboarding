trace_pie_chart <- function(data){
  
  data()%>%
    
    ggplot(aes(x = "", y = perc,fill = genre.factor)) +
    geom_bar(stat = "identity",color="white")+
    coord_polar("y",start=0)+
    geom_text(aes(label = paste(round(perc / sum(perc) * 100, 1), "%","\n", genre)),
              size=data()$perc/4.5,
              position = position_stack(vjust = 0.55)) +
    ggtitle("Domination des différents genres")+
    theme(plot.title = element_text(hjust=0.5),
          axis.title = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          panel.grid=element_blank(),
          panel.border=element_blank(),
          legend.title=element_text(hjust=0.5))+
    guides(fill=guide_legend(reverse=TRUE))+
    scale_fill_discrete(name="Genres")   
    
}