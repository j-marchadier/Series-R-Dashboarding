#Downloading datas
kgl_auth(creds_file = 'kaggle.json')
response <- kgl_datasets_download_all(owner_dataset = "ashishgup/netflix-rotten-tomatoes-metacritic-imdb")

download.file(response[["url"]], "netflix-rotten-tomatoes-metacritic-imdb.zip", mode="wb")
unzip_result <- unzip("netflix-rotten-tomatoes-metacritic-imdb.zip", overwrite = TRUE)

if (file.exists("netflix-rotten-tomatoes-metacritic-imdb.zip")) {
  file.remove("netflix-rotten-tomatoes-metacritic-imdb.zip")
}

rm(response,unzip_result)

#Reading the csv file and setting types
df<- read_csv("netflix-rotten-tomatoes-metacritic-imdb.csv", 
              col_names = c("title","genre","tags","languages","series_or_movies","hidden_gem_score",
                            "country_availability","run_time","director","writer","actors",
                            "view_rating","imdb_score","rotten_tomatoes_score","metacritic_score",
                            "awards_received","awards_nominated","box_office","release_date","netflix_date",
                            "production_house","netflix_link","imdb_link",'summary',"imdb_vote","image",
                            "poster","tmdb_trailer","trailer_site"),
              col_types = "cffffdcffccccddddcccccccdcccc",
              skip =1)

#We at first clean the dataset :
#Our first step is to change the type of the number of seasons into an integer and delete all the characters
data = df %>% select(-c(image,tags,languages,actors,view_rating,rotten_tomatoes_score,metacritic_score,production_house,netflix_link,imdb_link,tmdb_trailer,trailer_site))

#Date -> keep only year
data = data %>% mutate(release_year=substr(release_date,8,12), 
                       release_netflix_year=substr(netflix_date,1,4)) %>% 
  select( -c(release_date,netflix_date))

#We remove the Dollar and the comma in the box_office values, they are now double variables
data= data %>% mutate(data,box_office=substr(box_office,2,nchar(box_office)))
data$box_office <- as.numeric(gsub(",","",data$box_office))