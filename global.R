#Loading the packages we need
source("./packages.R")
source("./functions.R")


#Reading the csv file and setting types
df<- read_csv("Web_series_data.csv", 
              col_names = c("title","genre","tags","languages","series_or_movies","hidden_gem_score",
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
data = data %>% mutate(release_year=substr(release_date,8,12), 
            release_netflix_year=substr(netflix_date,1,4)) %>% 
            select( -c(release_date,netflix_date))

#On remove le Dollar de boxoffice
data= data %>% mutate(data,box_office=substr(box_office,2,15))

########### Clean Country available ############
all_country_availability = unlist(strsplit(data$country_availability[5], ","))
data_country_availability = data %>% select(-c(genre,series_or_movies,hidden_gem_score,run_time,director,writer,imdb_scrore,awards_received,awards_nominated,box_office,release_netflix_year,summary,imdb_vote,image,poster))

#function 
data_country_availability = clean_multiple_values(all_country_availability,data_country_availability,data$country_availability)
data_country_availability = data_country_availability %>% select(-c(country_availability))

########### Clean Genre ############
data_genre_sep <- data %>% separate(genre,c("genre_1","genre_2","genre_3","genre_4","genre_5","genre_6"),", ",TRUE)
vecteur_genre=unique(c(data_genre_sep$genre_1,data_genre_sep$genre_2,data_genre_sep$genre_3,data_genre_sep$genre_4,data_genre_sep$genre_5,data_genre_sep$genre_6))
vecteur_genre=vecteur_genre[vecteur_genre!=""]
vecteur_genre=head(vecteur_genre,-1)
data_genre_availability = data %>% select(-c(series_or_movies,country_availability,hidden_gem_score,run_time,director,writer,imdb_scrore,awards_received,awards_nominated,box_office,release_netflix_year,summary,imdb_vote,image,poster))

#function
data_genre_availability = clean_multiple_values(vecteur_genre,data_genre_availability,data$genre)
data_genre_availability = data_genre_availability %>% select(-c(genre))

data_merge <- merge(data,data_genre_availability,by=c("title","release_year")) %>% merge(data_country_availability,by=c("title","release_year"))
view((data_merge))





