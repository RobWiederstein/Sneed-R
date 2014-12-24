library(stringr)
a <- c("a", "b", "c")
a <- paste (a[1], a[2], a[3], sep = "")
a <- letters[1:3]
a <- paste (a, collapse = "")
a <- strsplit(a, split = "", fixed = T)
a <- letters[1:3]
a <- unlist(str_split(a, pattern = ""))

data(USArrests)
states <- rownames(USArrests)
substr(states, start = 1, stop = 4)
abbreviate(states)
names(states)
state_chars = nchar(states)
states[which(state_chars == max(state_chars))]
grep("^N", states, value = T)
grep("y$", states, value = T)

positions_a <- gregexpr(pattern = "a", text = states, ignore.case = TRUE)
num_a <- sapply(positions_a, function(x) ifelse(x[1] > 0, length(x), 0))
num_a
sum(num_a) #61 "a"s in the names of states
sum (str_count(states, "a"))
sum (str_count(tolower(states), "a")) #61

#vector of vowels
vowels <- c("a", "e", "i", "o", "u")
# vector for storing results
num_vowels = vector(mode = "integer", length = 5)
# calculate number of vowels in each name
for (j in seq_along(vowels)) {
  num_aux = str_count(tolower(states), vowels[j])
  num_vowels[j] = sum(num_aux) }
# add vowel names
names(num_vowels) = vowels
# total number of vowels
num_vowels
# sort them in decreasing order
sort(num_vowels, decreasing = TRUE)

#pct. of total
char_tot <- sum(nchar(tolower(states)))
num_vowels/char_tot

cat(rep("A", 1000), fill = 50)

rot <- function(ch, k = 13) {
  p0 <- function(...) paste(c(...), collapse = "")
  A <- c(letters, LETTERS, " '")
  I <- seq_len(k); chartr(p0(A), p0(c(A[-I], A[I])), ch)
}
pw <- "my secret pass phrase"
(crypw <- rot(pw, 13)) #-> you can send this off

## now ``decrypt'' :
rot(crypw, 54 - 13) # -> the original:
stopifnot(identical(pw, rot(crypw, 54 - 13)))


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
