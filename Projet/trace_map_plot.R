trace_map_plot <- function(data){
  
  data()%>%
    
    ggplot(aes(x=long,y=lat,group=group))+
    geom_polygon(aes(fill=hidden_gem_score),color="black")+
    ggtitle("Moyenne du Score Hidden Gem selon les Pays")+
    scale_fill_gradient(name="Hidden Gem Score",low="orange",high="purple",na.value="grey50")+
    theme(axis.text.x=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks=element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          plot.title = element_text(hjust = 0.5))   
    
    
  
}