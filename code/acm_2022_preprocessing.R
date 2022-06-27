library(here)
library(janitor)
library(tidyverse)

acm_2022 <- read.delim2(here("raw_data/acm_2022.txt")) %>% 
  clean_names() %>% 
  select(-c(notes)) %>% 
  separate(residence_county, into = c("county", "state"), sep = ", ") %>% 
  #mutate(death_offset = ) %>% 
  rename("county_code" = residence_county_code) %>% 
  mutate(year = "2022")

acm_2021 <- read.delim2(here("raw_data/acm_2021.txt")) %>% 
  clean_names() %>% 
  select(-c(notes)) %>% 
  separate(residence_county, into = c("county", "state"), sep = ", ") %>% 
  #mutate(death_offset = ) %>% 
  rename("county_code" = residence_county_code) %>% 
  rename()

acm_2021_2022 <- rbind(acm_2021, acm_2022) %>% 
  group_by(county_code) %>% 
  mutate(death_rate_lag1 = c(crude_rate[-1], NA)) %>% 
  ungroup() %>% 
  filter(year == 2022) %>% 
  write_csv(file.path(here("raw_data/acm_2021-2022_provisional.csv")))
