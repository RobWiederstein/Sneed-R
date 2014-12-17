read_file <- function (justice){
  justice <- "boyle"
  justice <- tolower(justice)
  file <- paste (getwd(), paste(justice, "txt", sep = "."), sep = "/")
  author <- scan(file = file, 
                      what = "character",
                      blank.lines.skip = T,
                      n = 100000,
                      skip = 20,
                      sep = "\n",
                      strip.white = T)

}

justice_number_cases <- function(justice, number){
  a <- NULL
  cases <- NULL
  number <- number:1
  for (i in seq_along(number)){
    if (number[i] < 10){a <- paste("00", number[i], sep = "")}else{
      if (number[i] < 100){a <- paste("0", number[i], sep = "")}else{
        a <- as.character(number[i])
      }  
    }
    cases[i] <- paste(justice, a, sep = "_")
  }
  cases
}

divide_into_cases  <- function(){
  begin <- grep("^\\(Cite as: (.*)\\)$", author, value = F)
  end   <- (grep("^END OF DOCUMENT$", author, value = F))
  begin <- begin[1:length(end)]
  file_name <- justice_number_cases(justice, length(begin)) #function call
  dir.create(justice)
    for(i in 1:length(file_name)) {
      mycase <- paste (author[begin[i]: end[i]], collapse = " ")
      file <- paste(getwd(), justice, file_name[i], sep = "/") #create "test" directory
      write(mycase, file = file)
  }
}

strip_headnotes    <- function(){
  path  <- paste(getwd(), "test", sep = "/")
  files_in <- list.files(path = path)  #all files?? what if other files in directory?
  files_out <- paste (files_in, "-out.txt", sep = "") 
  i     <- NULL
  for(i in seq(along = files_in)) { # start for loop with numeric or character vector;
                                  # numeric vector is often more flexible
    x <- scan(paste(path, files_in[i], sep = "/"), what = "character", sep = "\n")
    x <- gsub("\\(Cite as:(.*)BOYLE\\.", "", x) #lop off front end of case
    x <- gsub("Ky.App.(.*)END OF DOCUMENT", "", x) #lop off back end of case
    file <- paste(getwd(), "corpus", files_out[i], sep = "/")
    write (x, file = file)
  }
}

rm (file, boyle)
divide_into_cases()
strip_headnotes()
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

##################################
# set up file names using WL numbers--get to author_"Westlaw number"
####################################
cite <- grep("^\\(Cite as: (.*)\\)$", boyle, value = T)
cite
cite <- gsub("\\(Cite as: ", "", cite)
cite
cite <- gsub("^[0-9L](.*)Ky.\\), ", "", cite)
cite
cite <- gsub ("\\(Ky.\\)\\)", "", cite)
cite
cite[609] <- "1809 WL 1416"
cite[251] <- "1816 WL 1613"
cite

library (gdata)
cite <- trim (cite)
cite 
library(stringr)
cite <- str_split(cite, pattern = " ")
temp <- unlist(cite)
temp <- temp[seq(3, length(temp), by = 3)]
temp[nchar(temp)==3] <- paste("0", temp [nchar(temp)==3], sep = "")




lapply()
a <- paste("0", a[which(nchar(a)==1)], sep = "")

