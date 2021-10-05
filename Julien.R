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
                 col_types = "cffffdcffccccddddcccccccdcccc",
                 skip =1)


#We at first clean the dataset :
#Our first step is to change the type of the number of seasons into an integer and delete all the characters
data = df %>% select(-c(tags,languages,actors,view_rating,rotten_tomatoes_score,metacritic_score,production_house,netflix_link,imdb_link,tmdb_trailer,trailer_site))

#Date -> keep only year
data = data %>% mutate(release_date=substr(release_date,8,12))
colnames(data)[13] <- "release_year"

#Date -> keep only year
data = data %>% mutate(data,netflix_date=substr(netflix_date,1,4))
colnames(data)[14] <- "release_netflix_year"

#On remove le Dollar de boxoffice
data= data %>% mutate(data,box_office=substr(box_office,2,15))

###########
all_country_availability = unlist(strsplit(data$country_availability[5], ","))
data_country_availability = data
for (country in all_country_availability){
  print(country)
  v <- data_country_availability %>% 
    add_column(i = if_else(grepl(country, data$country_availability, fixed=TRUE), 
                             TRUE, FALSE)) %>%
    dplyr::select(i)
  data_country_availability[, country] <- v
}


#data_country_availability <- data %>% add_column(france = if_else(grepl("France", data$country_availability, fixed=TRUE), TRUE, FALSE))
view(head(data_country_availability))



#data_country_availability_count = unlist(lapply(data$country_availability, function(x) length(unlist(strsplit(x, ",")))))
#data_genres <- data %>% separate(genre,c("genre_1","genre_2","genre_3","genre_4","genre_5","genre_6"),",",TRUE)
#data$nb_seasons <- data$nb_seasons %>% str_replace("Seasons","") %>% str_replace("Season","") %>% str_replace(" ","") 
#data$nb_seasons <- data$nb_seasons %>%  as.integer()