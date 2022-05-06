#' helpers
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#'@import dplyr
#'
#' @noRd

add_siteyear_cdd <- function(data, ub = 120, lb = 50){

  left_join(data,
            get_siteyear_cdd(data = data, ub = ub, lb = lb),
            by = c("latitude", "longitude",
                   "year", "julian_day"))
}

match_cdd_obs_site <- function(obs_data, site_curve){
  obs_data %>%
    mutate(site_cdd_index = findInterval(cdd, site_curve[["cdd"]]),
           site_cdd_match = ifelse(site_cdd_index == 0, 0,
                                   site_curve[["cdd"]][site_cdd_index]),
           site_date_match = ifelse(site_cdd_index == 0, min(site_curve[["date"]]) - days(1),
                                    site_curve[["date"]][site_cdd_index]) %>%
             as_date()) %>%
    select(-site_cdd_index)
}
