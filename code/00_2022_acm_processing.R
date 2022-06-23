library(here)
library(janitor)
library(tidyverse)

acm_2022 <- read.delim2(here("raw_data/2022_all_cause_mortality_provisional.txt")) %>% 
  clean_names() %>% 
  select(-c(notes)) %>% 
  rename(county_name =  "residence_county") %>% 
  separate(county_name, into = c("county_name", "state"), sep = ", ") %>%
  mutate(county_name = str_remove_all(string = county_name, pattern = " County")) %>% 
  rename(county_code = "residence_county_code") %>% 
  write_csv(file.path(here("raw_data/2022_all_cause_mortality_provisional.csv")))
