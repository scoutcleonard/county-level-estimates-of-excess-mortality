library(here)
library(janitor)
library(tidyverse)

acm_2011_2019 <- read.delim2(here("raw_data/acm_2011-2019.txt")) %>% 
  clean_names() %>% 
  select(-c(notes)) %>% 
  separate(county, into = c("county", "state"), sep = ", ") %>% 
  #mutate(death_offset = ) %>% 
  group_by(county_code) %>% 
  mutate(death_rate_lag1 = c(crude_rate[-1], NA)) %>% 
  ungroup() %>% 
  write_csv(file.path(here("raw_data/2022_all_cause_mortality_provisional.csv")))
