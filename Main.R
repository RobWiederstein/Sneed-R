########################################
# Stylometry Project--Achilles Sneed
# Rob Wiederstein
# December 29, 2014
########################################
source("functions.R")

#build boyle corpus
divide_into_cases("boyle")
strip_headnotes("boyle")
cut_dissent_concur("boyle")

#build mills corpus
divide_into_cases("mills")
strip_headnotes("mills")
cut_dissent_concur("mills")

#build owsley corpus
divide_into_cases("owsley")
strip_headnotes("owsley")
cut_dissent_concur("owsley")

#take 25 random cases from each justice
#for classify () in "primary_set" & compare to Sneed
copy_case_to_primary_set("boyle")
copy_case_to_primary_set("mills")
copy_case_to_primary_set("owsley")

#take 25 random cases from each justice and
#place into "corpus" director for stylometry


