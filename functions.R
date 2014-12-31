#read data in
load_cases <- function(justice){
  justice <- tolower(justice)
  check.name <- c("boyle" , "mills", "owsley")
  if (any(justice == check.name)) {
    file <- paste (getwd(), "data", paste(justice, "txt", sep = "."), sep = "/")
    author <- scan(file = file, 
                   what = "character",
                   blank.lines.skip = T,
                   skip = 20,
                   sep = "\n",
                   strip.white = T)
      
    }else{ 
      print(c("must match:", check.name), quote = F)
  }
}
#get Westlaw numbers to name cases
case_cite <- function(cases){
  cite <- grep("^\\(Cite as: (.*)\\)$", cases, value = T)
  pattern <- "18[0123][0-9].WL.(.*)\\(K"
  x <- regexpr(pattern, cite)
  cite <- substring(cite, x, x + attr(x, "match.length") - 1)
  library(gdata)
  cite <- trim(gsub("\\(K", "", cite))
  cite
}

#Paste a "0" to case names to make the same length
same_cite_length <- function(cite){
  library (stringr)
  cite <- str_split(cite, pattern = " ")
  i <- NULL
  for(i in 1:length(cite)) {
    if(nchar(cite[[i]][3])==3){
      cite[[i]][3] <- paste("0", cite[[i]][3], sep = "")
    }
  }
  i <- NULL
  for(i in 1:length(cite)) {
    cite[[i]] <- paste(cite[[i]][1], cite[[i]][2], cite[[i]][3], collapse = "")
  }
  cite <- unlist (cite)
  cite <- gsub (" ", "", cite)
  print(cite)
}

#split large download into individual cases and save
divide_into_cases  <- function(justice = "boyle"){
  author <- load_cases(justice)
  begin <- grep("^\\(Cite as: (.*)\\)$", author, value = F)
  end   <- (grep("^END OF DOCUMENT$", author, value = F))
  begin <- begin[1:length(end)]
  file_name <- paste(justice, same_cite_length(case_cite(load_cases(justice))), sep = "_")
  file_name <- file_name[1:length(end)]
  dir.create(justice)               #create directory
    for(i in 1:length(file_name)) {
      mycase <- paste (author[begin[i]: end[i]], collapse = " ")
      file <- paste(getwd(), justice, file_name[i], sep = "/") #create directory
      write(mycase, file = file)
  }
}
#double check boyle as author.  Westlaw had 612.  Narrowed to 592.
confirm_boyle_author <- function(){
  patterns <- c("opinion of the Court by Chief Justice Boyle", "opinion of the court, by ch. j. boyle",
                "opinion of the court by judge boyle", "opinion of the court by chief justice boyle",
                "chief justice boyle delivered the opinion of the court", "opinion of the court, by judge boyle",
                "judge boyle delivered the opinion of the court", "judge boyle delivered the determination of the court",
                "following opinion was delivered by Chief Justice Boyle")
  justice <- "boyle"
  path  <- paste(getwd(), justice, sep = "/")
  files_in <- list.files(path = path, pattern = paste("^", justice, sep = ""))
  i  <- NULL
  j  <- NULL
  keep.case <- NULL
  for (i in seq(along = files_in)){
    for(j in seq(along = patterns)){
      x <- scan(paste(path, files_in[i], sep = "/"), what = "character", sep = "\n")
      if(grepl(patterns[j], x, ignore.case = T) == T){
        keep.case <- append(keep.case, files_in[i])
        print(files_in[i])
      }else{
        next(j)}
    }
    next(j)
  }
  keep.case <- unique(keep.case)
  unlink(paste(path, setdiff(files_in, keep.case), sep = "/"))
}

#eliminate headnotes since they are added by publisher
strip_headnotes    <- function(justice = "boyle"){
  path  <- paste(getwd(), justice, sep = "/")
  files_in <- list.files(path = path, pattern = paste("^", justice, sep = "")) #all files??
  files_out <- paste (files_in, "-out.txt", sep = "") 
  i     <- NULL
  for(i in seq(along = files_in)) {
    x <- scan(paste(path, files_in[i], sep = "/"), what = "character", sep = "\n")
    x <- gsub("\\(Cite as:(.*)BOYLE\\.", "", x) #lop off front end of case
    x <- gsub("Ky.App.(.*)END OF DOCUMENT", "", x) #lop off back end of case
    file <- paste(getwd(), justice, files_out[i], sep = "/")
    write (x, file = file)
    unlink(paste(path, files_in[i], sep = "/"))
  }
}

#eliminate dissents and concurrences because they are written
#by different authors
cut_dissent_concur <- function(justice = "boyle"){
  path  <- paste(getwd(), justice, sep = "/")
  files_in <- list.files(path = path, pattern = ".txt$")  #all files ending in ".txt"
  omit.case <- NULL
  i     <- NULL
  for(i in seq(along = files_in)){
    x <- scan(paste(path, files_in[i], sep = "/"), what = "character", sep = "\n")
    if(length (grep ("concur", x, ignore.case = T)) >= 1 |
         length (grep ("dissent", x, ignore.case = T)) >= 1){
      omit.case <- append(omit.case, files_in[i], after = length(omit.case))}else{
      next (i)
      }
    omit.case <- paste(path, omit.case, sep = "/")
    file.remove(omit.case)  
  }
  print(length(list.files(path = path)))
}
#take cases from each justice to determine who wrote Sneed
copy_case_to_primary_set <- function(justice, size = 25, seed = 1234){
  set.seed(seed)
  justice <- tolower(justice)
  path_justice <- paste(getwd(), justice, sep = "/")
  path_primary_set <- paste(getwd(), "primary_set", sep = "/")
  justice_cases <- list.files(path = path_justice)
  random_case <- sample(justice_cases, size = size)
  path_justice_case <- paste(path_justice, random_case, sep = "/")
  path_primary_set_case <- paste(path_primary_set, random_case, sep = "/")
  file.copy(from = path_justice_case, to = path_primary_set_case)
}

#build corpus to compare justice's writing styles
copy_case_to_corpus <- function(justice, size = 25, seed = 1234){
  set.seed(seed)
  justice <- tolower(justice)
  path_justice <- paste(getwd(), justice, sep = "/")
  path_corpus <- paste(getwd(), "corpus", sep = "/")
  justice_cases <- list.files(path = path_justice)
  random_case <- sample(justice_cases, size = size)
  path_justice_case <- paste(path_justice, random_case, sep = "/")
  path_corpus_case <- paste(path_corpus, random_case, sep = "/")
  file.copy(from = path_justice_case, to = path_corpus_case)
}

#remove "justice" directories & "corpus" and "primary_set"
clean_up <- function(){
  temp <- c("boyle", "mills", "owsley", "corpus", "primary_set")
  dir_paths <- paste(getwd(), temp, sep = "/")
  file.remove(list.files(dir_paths, full.names = T))
  unlink (dir_paths[1:3], recursive = T)
}
