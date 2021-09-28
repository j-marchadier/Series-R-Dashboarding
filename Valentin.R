source("./packages.R")
data <- read_csv("All_Streaming_Shows.csv")
data=as_tibble(data)
#On split ici la colonne Genre en deux colonnes distinctes genre_1 et genre_2
data=separate(data,Genre,c("genre_1","genre_2"),",",TRUE)
#Il y avait des années dans la catégorie genre, on les remplace donc par NA car elles n'avaient aucune raison d'être ici.
data=mutate(data,genre_2=ifelse(substr(genre_2,1,1)=='1' |substr(genre_2,1,1)=='2',NA,genre_2))
class(data)
view(head(data))

data=separate(data,'Streaming Platform',c("streaming_platform1","streaming_platform2","streaming_platform3"),",",TRUE)

df_non_na=filter(data$streaming_platform2,!if_any(everything(),is.na))
view(df_non_na)
typeof(data$streaming_platform3)




# essais <- data %>%
#   rename("Streaming_plateform" = "Streaming Platform") %>%
#   mutate(nb_plateforme = length(str_split(data$`Streaming Platform`,",")[[1]]))

# essais$nb_plateforme
# str_split(data$`Streaming Platform`[3],",")
# length(str_split(data$`Streaming Platform`[15],",")[[1]])
# view(head(essais))
# length(str_split(data$`Streaming Platform`[3], ',')[[1]])
