source("./packages.R")
data <- read_csv("All_Streaming_Shows.csv")
data=as_tibble(data)
#On split ici la colonne Genre en deux colonnes distinctes genre_1 et genre_2
data=separate(data,Genre,c("genre_1","genre_2"),",",TRUE)
#Il y avait des années dans la catégorie genre, on les remplace donc par NA car elles n'avaient aucune raison d'être ici.
data=mutate(data,genre_2=ifelse(substr(genre_2,1,1)=='1' |substr(genre_2,1,1)=='2',NA,genre_2))
view(head(data))

