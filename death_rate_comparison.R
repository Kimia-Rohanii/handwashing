#loading the datasets 
library(here)
library(tidyverse)
hospital<- read.csv(here("Data","hospital_data.csv"))
clinic<-read.csv(here("Data","clinic_data.csv"))

glimpse(hospital)
glimpse(clinic)
#what are the death rates in the both datasets
clinic<- clinic%>% mutate(death_rate= deaths/births)
hospital<-hospital%>% mutate(death_rate= deaths/ births)

#what was the the average death rate for the years befroe handwashing was introduced in 1847?
clinic$year <- as.numeric(clinic$year)
rate_by_clinic_pre_handwashing<- clinic%>%
  group_by(clinic) %>% filter(year < 1847)%>% 
  summarize(avg_rate= mean(death_rate))

# What were the average death rates in the Vienna General Hospital both before and after pathological autopsies were introduced in 1823?
rate_by_autopsies_introduced <- hospital %>% 
  filter(hospital=="Vienna") %>% 
  mutate(autopsies_introduced= year >= 1823) %>%
  group_by(autopsies_introduced) %>%
  summarize( avg_rate= mean(death_rate) )
