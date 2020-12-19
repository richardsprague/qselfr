# cronometer.r


#' @title Cronometer dataframe
#' @description  Return dataframe for all cronometer data
#' @param pathname path to the raw Cronometer.csv file
#' @importFrom magrittr %>%
#' @import lubridate
#' @import readr
#' @import dplyr
#' @export
cronometer_df <- function(pathname = getwd()) {

  cronometer_raw <-
    readr::read_csv(pathname) %>%
    transmute(
      day = Day, #lubridate::mdy(Day),
      time = Time, #lubridate::hm(Time),
      timestamp = (as_datetime(day)+time) %>% force_tz(tzone = Sys.timezone()),
      kcal = `Energy (kcal)`,
      carbs = `Carbs (g)`,
      net_carbs = `Net Carbs (g)`
    )

  cronometer_df <- cronometer_raw

  cronometer_df %>% add_column(user_id = 1234)

}

