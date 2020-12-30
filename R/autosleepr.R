# autosleepr.r
# functions for working with Tantissa Autosleep Data

# load sleep data


sleep_cols <-
  c(
    "bedtime",
    "waketime",
    "bed",
    "asleep",
    "awake",
    "tillSleep",
    "qualitytime",
    "deep",
    "sleepBPM",
    "hrv",
    "tags",
    "notes"
  )

sleep_cols_full_from_CSV <-
  c(
    "ISO8601",
    "fromDate",
    "toDate",
    "bedtime",
    "waketime",
    "inBed",
    "awake",
    "fellAsleepIn",
    "sessions",
    "asleep",
    "asleepAvg7",
    "efficiency",
    "efficiencyAvg7",
    "quality",
    "qualityAvg7",
    "deep",
    "deepAvg7",
    "sleepBPM",
    "sleepBPMAvg7",
    "dayBPM",
    "dayBPMAvg7",
    "wakingBPM",
    "wakingBPMAvg7",
    "hrv",
    "hrvAvg7",
    "SpO2Avg",	"SpO2Min",	"SpO2Max",
    "tags",
    "notes"

  )

sleep_col_types <- cols(
  .default = col_double(),
  ISO8601 = col_datetime(format = ""),
  fromDate = col_character(),
  toDate = col_character(),
  bedtime = col_datetime(format = "") , #"%m/%d/%y %H:%M"),
  waketime = col_datetime(format = ""), #"%m/%d/%y %H:%M"),
  inBed = col_time(format = ""),
  awake = col_time(format = ""),
  fellAsleepIn = col_time(format = ""),
  asleep = col_time(format = ""),
  asleepAvg7 = col_time(format = ""),
  quality = col_time(format = ""),
  qualityAvg7 = col_time(format = ""),
  deep = col_time(format = ""),
  deepAvg7 = col_time(format = ""),
  SpO2Avg = col_double(),
  SpO2Min = col_double(),
  SpO2Max = col_double(),
  tags = col_character(),
  notes = col_character()
)


#' @title Raw Autosleep dataframe
#' @description  Return Autosleep dataframe in raw form
#' @param pathname path to the raw Autosleep.csv file
#' @importFrom magrittr %>%
#' @import readr
#' @import dplyr
#' @export
autosleep_sleep_raw <- function(pathname = getwd()) {

  r <- readr::read_csv(pathname,
                 # col_names = sleep_cols_full_from_CSV,
                 col_types = sleep_col_types,
                  na = "--")


  return(r)

}

#' @title Autosleep dataframe
#' @description  Return dataframe for all sleep data
#' @param pathname path to the raw Autosleep.csv file
#' @importFrom magrittr %>%
#' @import lubridate
#' @import readr
#' @import dplyr
#' @export
autosleep_sleep_df <- function(pathname = getwd()) {

  as <- autosleep_sleep_raw(pathname) %>%
    transmute(wakeDate = as_date(force_tz(waketime, tz=Sys.timezone())),
              TST = as.numeric(asleep)/3600,
              asleep,
              waketime = force_tz(waketime, tz=Sys.timezone()),
              sleepBPM,
              hrv)

  return(as)
}
