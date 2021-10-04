#Loading the packages we need
source("./packages.R")


#Reading the csv file and setting types
data <- read_csv("All_Streaming_Shows.csv", 
                 col_names = c("title","year","content_rating","imdb_rating","r_rating","genre","description","nb_seasons","streaming_platform"),
                 col_types = "cffdifccf",
                 skip =1)
#We at first clean the dataset :
#Our first step is to change the type of the number of seasons into an integer and delete all the characters

data$nb_seasons <- data$nb_seasons %>% str_replace("Seasons","") %>% str_replace("Season","") %>% str_replace(" ","") 
data$nb_seasons <- data$nb_seasons %>%  as.integer()

#For the column Genre, we split it into two different columns since each serie can have 2 differents Genres
data=separate(data,genre,c("genre_1","genre_2"),",",TRUE)
#Since there's some years in the genre category, we decided to replace them with NAN values since a year isn't a genre
data=mutate(data,genre_2=ifelse(substr(genre_2,1,1)=='1' |substr(genre_2,1,1)=='2',NA,genre_2))
#We split the streaming platform into 3 different columns aswell since each serie can be broadcast on different platforms
data=separate(data,'streaming_platform',c("streaming_platform1","streaming_platform2","streaming_platform3"),",",TRUE)
view(data)