set.seed(1860)

library(stringr)
library(LaF)
library(quanteda)


t1<- sample_lines("final/en_US/en_US.news.txt", 1000)
t2<- sample_lines("final/en_US/en_US.twitter.txt", 1000)
t3<- sample_lines("final/en_US/en_US.blogs.txt", 1000)

txt<- tolower(c(t1, t2, t3))

intr <- tokens(txt, 
               remove_punct = TRUE,         ## Removing Punctuations
               remove_symbols = TRUE,          ## Removing Symbols
               remove_separators = TRUE,       ## Removing separators
               remove_twitter = TRUE,          ## Removing twitter symbols (e.g. "@" and "#")
               remove_hyphens = TRUE,          ## Removing hyphens
               remove_numbers = TRUE)  

ngrams<-list()

mkgrams <- function(t){
  tokens <- unlist(str_split(t, boundary("word")))
  
  for (i in 1:(length(tokens)-4)) {
    gram <- paste(tokens[i:(i+4)],collapse =" ")
    nxt <- tokens[(i+5)]
    ngrams[[gram]] <<- append(ngrams[[gram]],nxt)
  }
  
  for (i in 1:(length(tokens)-3)) {
    gram <- paste(tokens[i:(i+3)],collapse =" ")
    nxt <- tokens[(i+4)]
    ngrams[[gram]] <<- append(ngrams[[gram]],nxt)
  }
  
  for (i in 1:(length(tokens)-2)) {
    gram <- paste(tokens[i:(i+2)],collapse =" ")
    nxt <- tokens[(i+3)]
    ngrams[[gram]] <<- append(ngrams[[gram]],nxt)
  }
  
  for (i in 1:(length(tokens)-1)) {
    gram <- paste(tokens[i:(i+1)],collapse =" ")
    nxt <- tokens[(i+2)]
    ngrams[[gram]] <<- append(ngrams[[gram]],nxt)
  }
  
  for (i in 1:(length(tokens))) {
    gram <- paste(tokens[i],collapse =" ")
    nxt <- tokens[(i+1)]
    ngrams[[gram]] <<- append(ngrams[[gram]],nxt)
  }
}

saveRDS(ngrams, file="dgrams.rds")

checkit <- function(pentagram){
  lvl <- ""
  guess <- ""
  pl <- unlist(str_split(pentagram, " "))
  
  unigram <- paste(pl[5:length(pl)], collapse = " ")
  bigram <- paste(pl[4:length(pl)], collapse = " ")
  trigram <- paste(pl[3:length(pl)], collapse = " ")
  quadgram <- paste(pl[2:length(pl)], collapse = " ")
  
  if (!is.null(ngrams[[pentagram]])) {
    idx <- sample(1:length(ngrams[[pentagram]]),1)
    guess <- ngrams[[pentagram]][idx]
    lvl <- "pentagram"
  }
  
  if (!is.null(ngrams[[quadgram]])) {
    idx <- sample(1:length(ngrams[[quadgram]]),1)
    guess <- ngrams[[quadgram]][idx]
    lvl <- "quadgram"
  }
  
  if (!is.null(ngrams[[trigram]])){
    idx <- sample(1:length(ngrams[[trigram]]),1)
    guess <- ngrams[[trigram]][idx]
    lvl <- "trigram"
  }    
  
  if (!is.null(ngrams[[bigram]])){
    idx <- sample(1:length(ngrams[[bigram]]),1)
    guess <- ngrams[[bigram]][idx]
    lvl <- "bigram"
  }
  
  if (!is.null(ngrams[[unigram]])){
    idx <- sample(1:length(ngrams[[unigram]]),1)
    guess <- ngrams[[unigram]][idx]
    lvl <- "unigram"
  }
  
  paste(quadgram, guess, ": ", lvl, collapse = " ")
}