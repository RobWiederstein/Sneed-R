########################################
# Stylometry Project--Achilles Sneed
# Rob Wiederstein
# December 29, 2014
########################################
source("functions.R")

#build boyle corpus
divide_into_cases("boyle")
confirm_boyle_author()
strip_headnotes("boyle")
cut_dissent_concur("boyle")

#build mills corpus
divide_into_cases("mills")
confirm_mills_author()
strip_headnotes("mills")
cut_dissent_concur("mills")

#build owsley corpus
divide_into_cases("owsley")
confirm_owsley_author()
strip_headnotes("owsley")
cut_dissent_concur("owsley")

#take 25 random cases from each justice
#for classify () in "primary_set" & compare to Sneed
copy_case_to_primary_set("boyle", size = 50)
copy_case_to_primary_set("mills", size = 50)
copy_case_to_primary_set("owsley", size = 50)

#take "x" biggest cases to build corpus
biggest_cases_for_corpus("mills", 25)
biggest_cases_for_corpus("owsley", 25)
biggest_cases_for_corpus("boyle", 25)

#take 25 random cases from each justice and
#place into "corpus" directory for stylometry
copy_case_to_corpus("boyle", size = 20, seed = 2)
copy_case_to_corpus("mills", size = 20, seed = 2)
copy_case_to_corpus("owsley", size = 20, seed = 2)

#Compare writing styles of justices with Stylo.
library (stylo)
a <- stylo()

#Identify if "Sneed" authored pamphlet
b <- classify()

#remove "justice" directories & "corpus" and "primary_set"
clean_up()










