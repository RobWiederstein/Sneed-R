library(stringr)
a <- c("a", "b", "c")
a <- paste (a[1], a[2], a[3], sep = "")
a <- letters[1:3]
a <- paste (a, collapse = "")
a <- strsplit(a, split = "", fixed = T)
a <- letters[1:3]
a <- unlist(str_split(a, pattern = ""))

file <- paste (getwd(), "frost.txt",
               sep = "/"
)
f <- scan (file = file, 
              what = "character",
              blank.lines.skip = T,
              n = 100,
              skip = 0,
              sep = "\n",
              strip.white = T
)

extr1 <- unlist(str_extract_all(f, pattern = "Then(.*?)black"))

j <- paste (j, collapse = " ")

gregexpr("servant", j)

noquote(strsplit("A text I want to display with spaces", NULL)[[1]])

x <- c(as = "asfef", qu = "qwerty", "yuiop[", "b", "stuff.blah.yech")
# split x on the letter e
strsplit(x, "e")
