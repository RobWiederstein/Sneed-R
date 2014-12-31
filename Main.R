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
#place into "corpus" directory for stylometry
copy_case_to_corpus("boyle", size = 10, seed = 15)
copy_case_to_corpus("mills", size = 10, seed = 15)
copy_case_to_corpus("owsley", size = 10, seed = 15)

#Compare writing styles of justices with Stylo.
library (stylo)
a <- stylo()

#Identify if "Sneed" authored pamphlet
b <- classify()

#remove "justice" directories & "corpus" and "primary_set"
clean_up()










