trace_geom_plot <- function(data){

  na.omit(data)%>%    
    
    ggplot(aes(x=factor(release_year),y=`box_office`)) +
    theme(axis.text.x = element_text(angle = 90,vjust=0.5),
          plot.title = element_text(hjust = 0.5))+
    xlab("Année de sortie")+
    ylab("Somme de tous les Box offices")+
    ggtitle("Somme des Box Offices en fonction des années de sortie")+
    stat_summary(fun="sum",geom="line",size=0.5, color="red",na.rm=TRUE,aes(group=1))+
    scale_x_discrete(breaks = scales::pretty_breaks(n = 10))
  
}