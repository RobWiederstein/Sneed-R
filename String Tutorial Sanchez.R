#chapter 1
data(USArrests)
states <- row.names(USArrests)
substr(x = states, start = 1, stop = 4)
states2 <- abbreviate(states)
names (states2) <- NULL
grep("k", states, value = T)
grep("w", states, value = T)
hist(nchar(states))
positions_a <- gregexpr("a", states, ignore.case = T)
num_a <- sapply(positions_a, function(x) ifelse(x[1] > 0,
                                                length(x),0))
num_a
library (stringr)
str_count(states, "a")
str_count(tolower(states), "a")

vowels = c("a", "e", "i", "o", "u")
num_vowels <- vector(mode = "integer", length = 5)
for (j in seq_along(vowels)){
  num_aux = str_count(tolower(states), vowels[j])
  num_vowels[j] = sum(num_aux)
}
names (num_vowels) <- vowels
num_vowels

#chapter 2
char_vector <- character(5) #5 empty strings
example <- character (0) #empty character vector
example[1] <- "first"
example[4] <- "fourth"
example #R fills gaps with "NA"
a <- pi

#chapter 3
#print
a <- matrix(rnorm(12), 3, 4)
print (format(a, digits = 2))
print (format(a))
print (format(a), nsmall = 2)
format (c (6, 12.1), nsmall = 4)
format (c(6, 12.1), digits = 4)
format (c(6, 12.1), digits = 4, nsmall = 4)
#by defaul R pads the strings with spaces to make them the same length
print(format (1000000, big.mark = ",")) #??

toString(17000)
#substr
substr("abcdef", start = 2, stop = 4)
a <- "may the force be with you"
a <- unlist (str_split(a, pattern = " "))
substr(a, 2, 3) <- ":)"



text <- c("one word", "a sentence", "you and me", "three two one")
pat <- "one"
regexpr(pat, text)   #as vector
regexec(pat, text)   #as list
gregexpr(pat, text)  #as list
#handy function to extract matched term from Spector
x <- regexpr(pat, text)
substring (text, x, x + attr(x, "match.length") -1)
regexpr(pat, c(text, NA))
