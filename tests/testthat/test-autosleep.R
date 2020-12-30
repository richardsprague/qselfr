test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

sleep_raw <- autosleep_sleep_raw("AutoSleep-raw.csv")
sleep <- autosleep_sleep_df("AutoSleep-raw.csv")

sleep_legacy_raw <- autosleep_sleep_raw("AutoSleep 2020.csv")

test_that("Autosleep Raw Read: waketime is a datetime", {
  expect_equal(sleep_raw[["waketime"]][5],lubridate::as_datetime("2020-11-26 04:33:00 UTC"))
})

test_that("Autosleep Raw Read: fromDate is a char", {
  expect_type(sleep_raw[["fromDate"]][5],"character")
})

test_that("Autosleep_read_df: TST is correct", {
  expect_equal(sleep[["TST"]][10],8)
})

test_that("Autosleep Legacy: waketime is a datetime", {
  expect_equal(sleep_legacy_raw[["waketime"]][5],lubridate::as_datetime("2019-03-27 05:48:00 UTC"))
})
