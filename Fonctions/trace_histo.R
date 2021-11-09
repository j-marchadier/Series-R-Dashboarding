trace_histo <- function(data){
  
  data%>%
    
    ggplot(aes(x=`imdb_vote`,fill=series_or_movies)) +
    geom_histogram(bins=25)+
    scale_fill_discrete(name="Series or Movies")+
    ylab("Count")+
    xlab("Votes Imdb")+
    ggtitle("Histogramme représentant la répartition du nombre de votes Imdb")+
    theme(plot.title = element_text(hjust = 0.5))   
    
    
  
}