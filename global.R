#Loading the packages we need
source("./packages.R")


#Reading the csv file and setting types
df <- read_csv("Web_series_data.csv", 
                 col_names = c("title","genre","tags","languages","series_or_mouvies","hidden_gem_score",
                               "country_availability","run_time","director","writer","actors",
                               "view_rating","imdb_score","rotten_tomatoes_score","metacritic_score",
                               "awards_received","awards_nominated","box_office","release_date","netflix_release_date",
                               "production_house","netflix_link","imdb_link",'summary',"imdb_vote","image",
                               "poster","tmdb_trailer","trailer_site"),
                 col_types = "cffffdcccccccddddccccccdcccc",
                 skip =1)
view(df)
data = df %>% select(-c(tags,languages,actors,view_rating,rotten_tomatoes_score,metacritic_score,production_house,netflix_link,imdb_link,tmdb_trailer,trailer_site))
view(data)
#We at first clean the dataset :
#Our first step is to change the type of the number of seasons into an integer and delete all the characters


#data$languages <- data$languages %>% separate(c("language_1","language_2","language_3","language_4","language_5","language_6","language_7"),",",TRUE)
#On transforme la date de sortie pour ne garder que l'année
data = data %>% mutate(release_date=substr(release_date,8,12))
colnames(data)[13] <- "release_year"
#On transforme la date de sortie sur Netflix pour ne garder que l'année
data = data %>% mutate(data,netflix_release_date=substr(netflix_release_date,1,4))
colnames(data)[14] <- "release_netflix_year"
#On remove le Dollar de boxoffice
data= data %>% mutate(data,box_office=substr(box_office,2,15))
view(head(data))

data <- data %>% separate(genre,c("genre_1","genre_2","genre_3","genre_4","genre_5","genre_6"),",",TRUE)
view(data)

#data$nb_seasons <- str_replace(str_replace(str_replace(data$nb_seasons,"Seasons",""),"Season","")," ","")
#data$nb_seasons <- as.integer(data$nb_seasons)


#For the column Genre, we split it into two different columns since each serie can have 2 differents Genres
#data=separate(data,genre,c("genre_1","genre_2"),",",TRUE)
#Since there's some years in the genre category, we decided to replace them with NAN values since a year isn't a genre
#data=mutate(data,genre_2=ifelse(substr(genre_2,1,1)=='1' |substr(genre_2,1,1)=='2',NA,genre_2))
#We split the streaming platform into 3 different columns aswell since each serie can be broadcast on different platforms
#data=separate(data,'streaming_platform',c("streaming_platform1","streaming_platform2","streaming_platform3"),",",TRUE)

