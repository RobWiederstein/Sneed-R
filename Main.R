###############boyle#########################
  source("clean_boyle.R")
  justice_number_cases()
  divide_into_cases()
  strip_headnotes()
  check_dissent()  #still messed up won't delete files! Change from "check" to "discard"
  rm(list = ls())
