trace_histo <- function(data){
  
  data%>%
    
    ggplot(aes(x=`imdb_vote`,fill=series_or_movies)) +
    geom_histogram(bins=25)+
    scale_fill_discrete(name="Series or Movies")+
    ylab("Nombre de films")+
    xlab("Votes Imdb")+
    ggtitle("Histogramme du nombre de films en fonction des votes Imdb")+
    theme(plot.title = element_text(hjust = 0.5))   
    
    
  
}