source("../functions.R")

clean_genre<- function(data){
  
  ########### Clean Genre ############
  data_genre_sep <- data %>% separate(genre,c("genre_1","genre_2","genre_3","genre_4","genre_5","genre_6"),", ",TRUE)
  all_genre_availability=unique(c(data_genre_sep$genre_1,data_genre_sep$genre_2,data_genre_sep$genre_3,data_genre_sep$genre_4,data_genre_sep$genre_5,data_genre_sep$genre_6))
  all_genre_availability=all_genre_availability[all_genre_availability!=""]
  all_genre_availability=all_genre_availability[!is.na(all_genre_availability)]
  data_genre_availability = data %>% select(-c(series_or_movies,country_availability,hidden_gem_score,run_time,director,writer,imdb_score,awards_received,awards_nominated,box_office,release_netflix_year,summary,imdb_vote,poster))
  
  #function
  data_genre_availability = clean_multiple_values(all_genre_availability,data_genre_availability,data$genre)
  data_genre_availability = data_genre_availability %>% select(-c(genre))
  
  #Our final data sets
  data_genre_merge <- merge(data,data_genre_availability,by=c("title","release_year")) %>% select(-c(genre))
  
  data_genre=pivot_longer(data_genre_merge, !c(title,release_year,series_or_movies,hidden_gem_score,country_availability,run_time,director,
                                               writer,imdb_score,awards_received,awards_nominated,box_office,summary,
                                               imdb_vote,poster,release_netflix_year),
                          names_to = "genre", values_to = "is_genre")
  
  #Remove all False is_genre since it's not a very pertinent information and remove the boolean column is_genre
  final_data_genre = filter(data_genre,is_genre==TRUE) %>%
    select(-c(is_genre))
  
  return(final_data_genre)
}