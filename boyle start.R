file <- paste (getwd(), "boyle1.txt",
               sep = "/"
               )
boyle <- scan(file = file, 
              what = "character",
              blank.lines.skip = T,
              n = 1000,
              skip = 31,
              sep = "\n",
              strip.white = T
              )
boyle[1:50]

boyle1 <- paste(boyle, sep = " ", collapse = "")


readLines(con = file, n = 25, ok = TRUE, warn = TRUE,
          encoding = "unknown", skipNul = TRUE)

r <- scan ("jesus.txt",
           what = "character",
           skip = 0,
           sep = "\n",
           blank.lines.skip = FALSE)  #interesting
r
r1 <- scan ("jesus.txt",
           what = "character",
           skip = 2,
           sep = " ")  #interesting

setdiff (r, r1)
b <- scan ("boyle.txt",
           what = "character",
           skip = 0,
           sep = "\n")

scan(file = "boyle.txt", 
     what = "character", 
     n = -1, 
     sep = "",
     quote = if(identical(sep, "\n")) "" else "'\"", dec = ".",
     skip = 0, 
     na.strings = "NA",
     flush = FALSE, 
     fill = FALSE, 
     strip.white = FALSE,
     quiet = FALSE, 
     blank.lines.skip = TRUE, 
     multi.line = TRUE,
     comment.char = "", 
     allowEscapes = FALSE,
     fileEncoding = "", 
     encoding = "unknown", 
     text, 
     skipNul = FALSE)

