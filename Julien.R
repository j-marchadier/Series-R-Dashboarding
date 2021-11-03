#Loading the packages we need
source("./packages.R")
source("./functions.R")

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
                            "view_rating","imdb_scrore","rotten_tomatoes_score","metacritic_score",
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

#On remove le Dollar de boxoffice
data= data %>% mutate(data,box_office=substr(box_office,2,15))

########### Clean Country available ############
all_country_availability = unlist(strsplit(data$country_availability[5], ","))
data_country_availability = data %>% select(-c(genre,series_or_movies,hidden_gem_score,run_time,director,writer,imdb_scrore,awards_received,awards_nominated,box_office,release_netflix_year,summary,imdb_vote,poster))

#function 
data_country_availability = clean_multiple_values(all_country_availability,data_country_availability,data$country_availability)
data_country_availability = data_country_availability %>% select(-c(country_availability))

########### Clean Genre ############
data_genre_sep <- data %>% separate(genre,c("genre_1","genre_2","genre_3","genre_4","genre_5","genre_6"),", ",TRUE)
vecteur_genre=unique(c(data_genre_sep$genre_1,data_genre_sep$genre_2,data_genre_sep$genre_3,data_genre_sep$genre_4,data_genre_sep$genre_5,data_genre_sep$genre_6))
vecteur_genre=vecteur_genre[vecteur_genre!=""]
vecteur_genre=head(vecteur_genre,-1)
data_genre_availability = data %>% select(-c(series_or_movies,country_availability,hidden_gem_score,run_time,director,writer,imdb_scrore,awards_received,awards_nominated,box_office,release_netflix_year,summary,imdb_vote,poster))

#function
data_genre_availability = clean_multiple_values(vecteur_genre,data_genre_availability,data$genre)
data_genre_availability = data_genre_availability %>% select(-c(genre))

#Our final data sets
data_genre_merge <- merge(data,data_genre_availability,by=c("title","release_year")) %>% select(-c(genre))
data_country_merge <- merge(data,data_country_availability,by=c("title","release_year")) %>% select(-c(country_availability))

final_data_country = pivot_longer(data_country_merge,
                                  !c(title,release_year,genre,series_or_movies,hidden_gem_score,run_time,director,
                                     writer,imdb_scrore,awards_received,awards_nominated,box_office,summary,
                                     imdb_vote,poster,release_netflix_year)
                                  ,names_to = "country",values_to = "is_country")

data_pivot_genre=pivot_longer(data_genre_merge, c(Crime,Comedy,Drama,Animation,Short,Action,Adventure,
                                                  Music,Thriller,Biography,Documentary,Mystery,Horror,
                                                  `Sci-Fi`,Family,Romance,Musical,Fantasy,`Film-Noir`,
                                                  `Reality-TV`,`Talk-Show`,`Game-Show`,News,Sport,War,
                                                  History,Adult,Western),
                              names_to = "genre", values_to = "is_genre")
#Remove tampon variables
rm(data_country_availability,data_genre_availability,data_genre_sep,df,vecteur_genre,all_country_availability,clean_multiple_values,data_country_merge,data_genre_merge)

ggplot(data, aes(x=`imdb_vote`)) + geom_histogram(bins=10)+
  #scale_x_continuous(limits=c(0, 700000))+
  #scale_y_continuous(limits=c(0, 1000))



ggplot(data, aes(x=factor(release_year),y=`box_office`)) +
  theme(axis.text.x = element_text(angle = 90,vjust=0.5)) +
  xlab("Release year")+
  ylab("Box office moyen")+
  stat_summary(fun=mean,geom="line",size=0.3, color="red",aes(group=1))+
  scale_x_discrete(breaks = scales::pretty_breaks(n = 10))


ggplot(tips2, aes(x = "", y = perc,fill = genre.factor)) +
  geom_bar(stat = "identity",color="white")+
  coord_polar("y",start=0)+
  geom_text(aes(label = paste(round(perc / sum(perc) * 100, 1), "%","\n", genre)),size=tips2$perc/4.5,
            position = position_stack(vjust = 0.55)) +
  ggtitle("Domination of the different genres")+
  theme(plot.title = element_text(hjust=0.5,size=10),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid=element_blank(),
        panel.border=element_blank(),
        legend.title=element_text(hjust=0.5))+
  guides(fill=guide_legend(reverse=TRUE))+
  scale_fill_discrete(name="Genres")


ggplot(mapdata,aes(x=long,y=lat,group=group))+
  geom_polygon(aes(fill=hidden_gem_score),color="black")+
  ggtitle("Moyenne du Score Hidden Gem selon les Pays")+
  scale_fill_gradient(name="Hidden Gem Score",low="orange",high="purple",na.value="grey50")+
  theme(axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank())
