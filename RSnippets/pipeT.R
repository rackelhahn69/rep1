crps <-
  # test
  rawd %>% 
  corpus(text_field="artc") %T>% 
  {(clct <- textstat_collocations(., min_count=100))} %>% 
  tokens(what="word") %>% 
  tokens_compound(clct, concatenator="_")
