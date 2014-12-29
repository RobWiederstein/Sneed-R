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




# set up file names--Author_Westlaw Number
justice_number_cases <- function(justice = "boyle"){
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

#split download into cases and save
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
#get rid of headnotes since they are added by publisher
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
  files_in <- list.files(path = path, pattern = ".txt$")  #all files ending in ".txt"
  files_out <- paste (files_in, "-out1.txt", sep = "")
  omit.case <- NULL
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

#Corpus built for justice boyle.  Run it with Stylo.
#library (stylo)
#a <- stylo()
#b <- classify()

