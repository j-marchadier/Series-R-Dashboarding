source("../Fonctions/functions.R")

clean_country<- function(data){
  
  ########### Clean Country available ############
  all_country_availability = unlist(strsplit(data$country_availability, ","))
  all_country_availability=unique(all_country_availability)
  all_country_availability=all_country_availability[!is.na(all_country_availability)]
  data_country_availability = data %>% select(-c(genre,series_or_movies,hidden_gem_score,run_time,director,writer,imdb_score,awards_received,awards_nominated,box_office,release_netflix_year,summary,imdb_vote,poster))
  
  #function 
  data_country_availability = clean_multiple_values(all_country_availability,data_country_availability,data$country_availability)
  data_country_availability = data_country_availability %>% select(-c(country_availability))
  
  data_country_merge <- merge(data,data_country_availability,by=c("title","release_year")) %>% select(-c(country_availability))
  data_country = pivot_longer(data_country_merge,
                              !c(title,release_year,genre,series_or_movies,hidden_gem_score,run_time,director,
                                 writer,imdb_score,awards_received,awards_nominated,box_office,summary,
                                 imdb_vote,poster,release_netflix_year)
                              ,names_to = "country",values_to = "is_country")
  final_data_country = filter(data_country,is_country==TRUE) %>%
    select(-c(is_country))
  names(final_data_country)[names(final_data_country) == 'country'] <- 'region'
  
  return(final_data_country)
}