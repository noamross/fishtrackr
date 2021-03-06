library(tidyverse)
library(assertr)
library(ybp)

context("columns")

# original data example
d <- all69khz_grouped
d <- dplyr::filter(d, TagID == 2841)

test_that("original columns carried over test", {
  expect_equal(ncol(fishpaths(d, d$TagID, d$Station)), 11)
})


# data with fewer columns example

d <- all69khz_grouped
d <- dplyr::filter(d, TagID == 2841)
d2 <- fishpaths(d, d$TagID, d$Station) # full

d_trunc <- dplyr::select(d, DateTimeUTC, TagID, Station, Rkm)
d3 <- fishpaths(d_trunc, d_trunc$TagID, d_trunc$Station) #truncated columns

test_that("fewer columns but same arrival and departure output", {
  expect_identical(d2$arrival, d3$arrival)
  expect_true(ncol(d3) < ncol(d2))
})

test_that("correct columns added after function call", {
  expect_equal(ncol(fishpaths(d_trunc, d_trunc$TagID, d_trunc$Station)),
               ncol(d_trunc) + 2 )
})

d <- all69khz_grouped
d <- dplyr::filter(d, TagID == 2841)
d_extra <- d
d_extra$extra_column <- 1
d_extra <- fishpaths(d_extra, d_extra$TagID, d_extra$Station)

test_that("fewer columns but same arrival and departure output", {
  expect_identical(d_extra$arrival, d_extra$arrival)
  expect_true(ncol(d_extra) > ncol(d))
})
