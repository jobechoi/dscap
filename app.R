server <- function(input, output) {
  library(stringr)
  library(quanteda)
  
  checkit <- function(pentagram){
  
    ngrams<- readRDS(gzcon(url("https://s3.amazonaws.com/coursera-ds/dgrams.rds")))
    
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
    
    paste(pentagram, guess, collapse = " ")
    
    
  }
  
  # if(length(input$guess)>0) {
    output$value <- renderPrint({ gsub("NA", "", checkit(trimws(input$guess, which = "both"))) })
  # }
}

ui <- fluidPage(
  # Copy the line below to make a text input box
  textInput("guess", 
            label = h3("Guess the word up to the 6th one...")),
  hr(),
  fluidRow(column(3, textOutput("value")))
)

shinyApp(ui = ui, server = server)