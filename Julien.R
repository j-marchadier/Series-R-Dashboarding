#Loading the packages we need
source("./packages.R")


#Reading the csv file and setting types
df<- read_csv("Web_series_data.csv", 
                 col_names = c("title","genre","tags","languages","series_ormouvies","hidden_gem_score",
                               "country_availability","run_time","director","writer","actors",
                               "view_rating","imdb_scrore","rotten_tomatoes_score","metacritic_score",
                               "awards_received","awards_nominated","box_office","release_date","netflix_date",
                               "production_house","netflix_link","imdb_link",'summary',"imdb_vote","image",
                               "poster","tmdb_trailer","trailer_site"),
                 col_types = "cffffdcccccccddddcccccccdcccc",
                 skip =1)


#We at first clean the dataset :
#Our first step is to change the type of the number of seasons into an integer and delete all the characters
data = select(df , -c(tags,languages,actors,view_rating,rotten_tomatoes_score,metacritic_score,production_house,netflix_link,imdb_link,tmdb_trailer,trailer_site))
view(data)

data$nb_seasons <- data$nb_seasons %>% str_replace("Seasons","") %>% str_replace("Season","") %>% str_replace(" ","") 
data$nb_seasons <- data$nb_seasons %>%  as.integer()

#For the column Genre, we split it into two different columns since each serie can have 2 differents Genres
data=separate(data,genre,c("genre_1","genre_2"),",",TRUE)
#Since there's some years in the genre category, we decided to replace them with NAN values since a year isn't a genre
data=mutate(data,genre_2=ifelse(substr(genre_2,1,1)=='1' |substr(genre_2,1,1)=='2',NA,genre_2))
#We split the streaming platform into 3 different columns aswell since each serie can be broadcast on different platforms
data=separate(data,'streaming_platform',c("streaming_platform1","streaming_platform2","streaming_platform3"),",",TRUE)
view(data)