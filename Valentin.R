source("./packages.R")
data <- read_csv("Web_series_data.csv")
data=as_tibble(data)

data <- read_csv("Web_series_data.csv", 
                 col_names = c("title","genre","tags","languages","series_ormouvies","hidden_gem_score",
                               "country_availability","run_time","director","writer","actors",
                               "view_rating","imdb_scrore","rotten_tomatoes_score","metacritic_score",
                               "awards_received","awards_nominated","box_office","release_date",
                               "production_house","netflix_link","imdb_link",'summary',"imdb_vote","image",
                               "poster","tmdb_trailer","trailer_site"),
                 col_types = "cffffdcccccccddddccccccdcccc",
                 skip =1)
#On split ici la colonne Genre en deux colonnes distinctes genre_1 et genre_2
data=separate(data,Genre,c("genre_1","genre_2","genre_3","genre_4","genre_5","genre_6"),",",TRUE)
#Il y avait des années dans la catégorie genre, on les remplace donc par NA car elles n'avaient aucune raison d'être ici.
#data=mutate(data,genre_2=ifelse(substr(genre_2,1,1)=='1' |substr(genre_2,1,1)=='2',NA,genre_2))
#class(data)
#view(head(data))
data=separate(data,Languages,c("language_1","language_2","language_3","language_4","language_5","language_6","language_7"),",",TRUE)
data=mutate(data,release_year=substr(release_date,8,12))
#data=separate(data,'Streaming Platform',c("streaming_platform1","streaming_platform2","streaming_platform3"),",",TRUE)
#typeof(data$genre_2)
view(head(data))

# essais <- data %>%
#   rename("Streaming_plateform" = "Streaming Platform") %>%
#   mutate(nb_plateforme = length(str_split(data$`Streaming Platform`,",")[[1]]))

# essais$nb_plateforme
# str_split(data$`Streaming Platform`[3],",")
# length(str_split(data$`Streaming Platform`[15],",")[[1]])
# view(head(essais))
# length(str_split(data$`Streaming Platform`[3], ',')[[1]])
