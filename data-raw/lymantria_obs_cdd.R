## code to prepare `lymantria_obs_cdd` dataset goes here

library(rinat)
library(dplyr)
library(lubridate)
library(purrr)
library(daymetr)
library(tidyr)
library(magrittr)
source("R/utils_helpers.R")
source("R/fct_helpers.R")

bounds <- c(30,-90,50,-50)

ld_dat <- get_inat_obs(taxon_name = "Lymantria dispar", bounds = bounds, maxresults=10000)

ld_dat2 <- ld_dat %>%
  select(datetime, common_name, observed_on, longitude, latitude) %>%
  make_julian_year("datetime", datetime = T) %>%
  filter(year < 2022)

lymantria_obs_cdd <- ld_dat2 %>%
  add_siteyear_cdd()

usethis::use_data(lymantria_obs_cdd, overwrite = TRUE, internal = T)



