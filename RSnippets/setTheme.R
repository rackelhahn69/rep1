# Standard-Theme für ggplot festlegen
theme_bw() %+replace%
  theme(panel.border=element_blank(),
        panel.grid.minor=element_blank()) %>% 
  theme_set()
