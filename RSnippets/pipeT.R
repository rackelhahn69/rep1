crps <-
  rawd %>% 
  corpus(text_field="artc") %T>% 
  # geschweifte klammer für den punkt,
  # glatte klammer für das assignment
  {(clct <- textstat_collocations(., min_count=100))} %>% 
  tokens(what="word") %>% 
  tokens_compound(clct, concatenator="_")
