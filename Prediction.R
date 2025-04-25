# Load necessary library
library(tm)

# Load pre-computed n-gram models
bigram <- readRDS(file = "data/final_bigram.Rda")
trigram <- readRDS(file = "data/final_trigram.Rda")
fourgram <- readRDS(file = "data/final_fourgram.Rda")

# Function to predict the next word based on input text
nextWordPredictor <- function(inputTxt) {

  # Check if the input text is not empty
  if (nchar(inputTxt) > 0) {
    # Clean the input text: lowercase, remove numbers, punctuation, and extra whitespace
    inputTxt <- tolower(inputTxt)
    inputTxt <- removeNumbers(inputTxt)
    inputTxt <- removePunctuation(inputTxt)
    inputTxt <- stripWhitespace(inputTxt)

    # Split the input text into a list of words
    inputList <- unlist(strsplit(inputTxt, " "))

    # Print the tokenized input words (for debugging)
    # print(inputList)

    # Get the number of words in the input
    numWords <- length(inputList)

    # Print the number of input words (for debugging)
    # print(numWords)

    # Helper function to find bigram predictions
    runBigram <- function(word) {
      if (word %in% bigram$terms$one) {
        return(bigram[bigram$terms$one == word, ]$terms$two)
      } else {
        return(character(0))
      }
    }

    # Helper function to find trigram predictions
    runTrigram <- function(words) {
      if (all(words %in% trigram$terms[1:2])) {
        return(trigram[trigram$terms$one == words[1] &
                         trigram$terms$two == words[2], ]$terms$three)
      } else {
        return(character(0))
      }
    }

    # Helper function to find fourgram predictions
    runFourgram <- function(words) {
      if (all(words %in% fourgram$terms[1:3])) {
        return(fourgram[fourgram$terms$one == words[1] &
                          fourgram$terms$two == words[2] &
                          fourgram$terms$three == words[3], ]$terms$four)
      } else {
        return(character(0))
      }
    }

    # Predict based on the number of input words using a back-off strategy
    if (numWords >= 3) {
      # Try fourgram prediction
      word1 <- inputList[numWords - 2]
      word2 <- inputList[numWords - 1]
      word3 <- inputList[numWords]
      predList <- runFourgram(c(word1, word2, word3))

      # Back-off to trigram if no fourgram prediction
      if (length(predList) == 0) {
        predList <- runTrigram(c(word2, word3))
      }

      # Back-off to bigram if no trigram prediction
      if (length(predList) == 0) {
        predList <- runBigram(word3)
      }
    } else if (numWords == 2) {
      # Try trigram prediction
      word1 <- inputList[1]
      word2 <- inputList[2]
      predList <- runTrigram(c(word1, word2))

      # Back-off to bigram if no trigram prediction
      if (length(predList) == 0) {
        predList <- runBigram(word2)
      }
    } else if (numWords == 1) {
      # Try bigram prediction
      predList <- runBigram(inputList[1])
    } else {
      # If no input words, return an empty character vector
      predList <- character(0)
    }

    # Return the top n predictors
    n <- 4
    top_predictors_count <- length(predList)

    if (top_predictors_count >= n) {
      predList <- head(predList, n)
    }

    return(as.character(predList))
  } else {
    # Return an empty string if the input text is empty
    return("")
  }
}
