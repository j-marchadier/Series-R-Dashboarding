source("./packages.R")

#Reading on our csv file
#Set correct minuscule names
#Set types of columns
data <- read_csv("All_Streaming_Shows.csv", 
                 col_names = c("title","year","content_rating","imdb_rating","r_rating","genre","description","nb_seasons","streaming_platform"),
                 col_types = "cffdifccf",
                 skip =1)

#Ramplace 
data$nb_seasons <- str_replace(str_replace(str_replace(data$nb_seasons,"Seasons",""),"Season","")," ","")
data$nb_seasons <- as.integer(data$nb_seasons)
view(head(data,100))
head(Tennis)
