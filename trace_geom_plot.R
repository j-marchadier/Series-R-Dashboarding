trace_geom_plot <- function(data){

  data%>%    
    
    ggplot(aes(x=factor(release_year),y=`box_office`)) +
    theme(axis.text.x = element_text(angle = 90,vjust=0.5),
          plot.title = element_text(hjust = 0.5))+
    xlab("Année de sortie")+
    ylab("Box office moyen")+
    ggtitle("Moyenne du Box Office en fonction des années de sortie")+
    stat_summary(fun=mean,geom="line",size=0.5, color="red",aes(group=1))+
    scale_x_discrete(breaks = scales::pretty_breaks(n = 10))
  
}