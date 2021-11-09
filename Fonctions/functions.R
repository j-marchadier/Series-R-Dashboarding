clean_multiple_values <- function(list_id,data_values,col_needed){
  for (i in list_id){
    v <- data_values %>% 
      add_column(name = if_else(grepl(i, col_needed, fixed=TRUE), 
                                TRUE, FALSE)) %>%
      dplyr::select(name)
    data_values[, i] <- v
  }
  data_values
}