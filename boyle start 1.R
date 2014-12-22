#read data in
file <- paste (getwd(), paste("boyle", "txt", sep = "."), sep = "/")
author <- scan(file = file, 
                      what = "character",
                      blank.lines.skip = T,
                      n = 100000,
                      skip = 20,
                      sep = "\n",
                      strip.white = T)



justice_number_cases <- function(justice = "boyle"){
  # set up file names using WL numbers--get to author_"Westlaw number"
  cite <- grep("^\\(Cite as: (.*)\\)$", author, value = T)
  cite <- gsub("\\(Cite as: ", "", cite)
  cite <- gsub("^[0-9L](.*)Ky\\.\\), ", "", cite)
  cite <- gsub ("\\(Ky\\.\\)\\)", "", cite)
  cite[609] <- "1809 WL 1416"
  cite[251] <- "1816 WL 1613"
  library (gdata)
  cite <- trim (cite)
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
  cite <- paste("boyle", cite, sep = "_")
}

divide_into_cases  <- function(justice = "boyle"){
  begin <- grep("^\\(Cite as: (.*)\\)$", author, value = F)
  end   <- (grep("^END OF DOCUMENT$", author, value = F))
  begin <- begin[1:length(end)]
  file_name <- cite #function call
  file_name <- file_name[1:length(end)]
  dir.create("boyle")
    for(i in 1:length(file_name)) {
      mycase <- paste (author[begin[i]: end[i]], collapse = " ")
      file <- paste(getwd(), "boyle", file_name[i], sep = "/") #create "test" directory
      write(mycase, file = file)
  }
}

strip_headnotes    <- function(justice = "boyle"){
  path  <- paste(getwd(), "boyle", sep = "/")
  files_in <- list.files(path = path, pattern = "^boyle")  #all files?? what if other files in directory?
  files_out <- paste (files_in, "-out.txt", sep = "") 
  i     <- NULL
  for(i in seq(along = files_in)) { # start for loop with numeric or character vector;
                                  # numeric vector is often more flexible
    x <- scan(paste(path, files_in[i], sep = "/"), what = "character", sep = "\n")
    x <- gsub("\\(Cite as:(.*)BOYLE\\.", "", x) #lop off front end of case
    x <- gsub("Ky.App.(.*)END OF DOCUMENT", "", x) #lop off back end of case
    file <- paste(getwd(), "boyle", files_out[i], sep = "/")
    write (x, file = file)
  }
}

check_dissent <- function(justice = "boyle"){
  path  <- paste(getwd(), "boyle", sep = "/")
  files_in <- list.files(path = path, pattern = ".txt$")  #all files?? what if other files in directory?
  files_out <- paste (files_in, "-out1.txt", sep = "")
  omit.case <- NULL
  keep.case <- NULL
  i     <- NULL
  for(i in seq(along = files_in)) { # start for loop with numeric or character vector;
    # numeric vector is often more flexible
    x <- scan(paste(path, files_in[i], sep = "/"), what = "character", sep = "\n")
    if(length (grep ("concur", x, ignore.case = T)) >= 1 |
         length (grep ("dissent", x, ignore.case = T)) >= 1){
      omit.case <- append(omit.case, files_in[i], after = length(omit.case))}else{
      next (i)
      }
    omit.case <- paste(path, omit.case, sep = "/")
    file.remove(omit.case)  
  }
}





rm (file, author)
#we have a corpus!! Is it any good?  Run it with Stylo.
library (stylo)
a <- stylo()
b <- classify()


x <- scan(paste(path, files[1], sep = "/"), what = "character", sep = "\n")

x
#check for dissent or concurrence and either delete or
y <- regexpr("Court of Appeals of Kentucky" ,x)
court <- substring(x, y, y + attr(y, "match.length")-1)
y <- regexpr("(OPINION(.*)BOYLE.)|(CHIEF JUSTICE BOYLE)", x)



#skip to next file

#begin with delivered the opinion of the court

#end with before end of document

files <- list.files(path = paste(getwd(), "test", sep = "/"))
path <- paste(getwd(), "test", sep = "/")
cite <- NULL
court <- NULL
judge <- NULL
date <-  NULL
corpus <- NULL
plaintiff <- NULL
defendant <- NULL
i <- NULL
for(i in seq(along=files)) { # start for loop with numeric or character vector;
                             # numeric vector is often more flexible
  x <- scan(paste(path, files[i], sep = "/"), what = "character", sep = "\n")
  y <- regexpr("Court of Appeals of Kentucky" ,x)
  court[i] <- substring(x, y, y + attr(y, "match.length")-1)
  y <- regexpr("(OPINION(.*)BOYLE.)|(CHIEF JUSTICE BOYLE)", x)
  judge[i] <- substring(x, y, y + attr(y, "match.length")-1)
  y <- regexpr("([Jj]an|[Ff]eb|[Mm]ar|[Aa]pr|[Mm]ay|[Jj]un|[Jj]ul|[Aa]ug|
[Ss]ep|[Oo]ct|[Nn]ov|[Dd]ec)..\\d?\\d,\\s18\\d\\d", x)
  date[i] <- substring(x, y, y + attr(y, "match.length")-1)
  y <- regexpr("((OPINION(.*)BOYLE.)|(CHIEF JUSTICE BOYLE))(.*)END OF DOCUMENT", x)
  corpus[i] <- substring(x, y, y + attr(y, "match.length")-1)
  y <- regexpr("ky\\.([^.]*)\\.", x)
  plaintiff[i] <- substring(x, y, y + attr(y, "match.length")-1)
  y <- regexpr("v\\.([^,]*)\\.", x)
  defendant[i] <- substring(x, y, y + attr(y, "match.length")-1)
  print(files[i], quote=F)
  
}
  
  x <- data.frame(x, sum=apply(x, 1, sum), mean=apply(x, 1, mean)) # calculates sum and mean for each data frame
  assign(files[i], x) # generates data frame object and names it after content in variable 'i'
  print(files[i], quote=F) # prints loop iteration to screen to check its status
  write.table(x, paste(files[i], c(".out"), sep=""), quote=FALSE, sep="\t", col.names = NA) 
}

ls()

