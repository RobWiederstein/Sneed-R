########################################
# Stylometry Project--Achilles Sneed
# Rob Wiederstein
# December 29, 2014
########################################
source("functions.R")

#build boyle corpus
divide_into_cases("boyle")
strip_headnotes("boyle")
check_dissent("boyle")

#build mills corpus
divide_into_cases("mills")
strip_headnotes("mills")
check_dissent("mills")

#build owsley corpus
divide_into_cases("owsley")
strip_headnotes("owsley")
check_dissent("owsley")

#take 25 random cases from each justice
#for stylo primary set & compare to Sneed


