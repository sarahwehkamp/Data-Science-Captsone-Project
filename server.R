# server.R

# Source the prediction function script
source("./nextWordPrediction.R", local = TRUE)

# Define the server logic for the Shiny app
shinyServer(function(input, output, session) {

  # Reactive expression that calls the nextWordPredictor function
  prediction <- reactive({
    nextWordPredictor(input$inputTxt)
  })

  # Render the UI for the predicted words as action buttons
  output$words <- renderUI({
    predictWords <- prediction()
    # Assign predicted words to a global variable (not best practice for large apps, but okay for simple ones)
    assign('savedWords', predictWords, envir = .GlobalEnv)
    n <- length(predictWords)

    if (n > 0 && all(nchar(predictWords) > 0)) {
      buttons <- list()
      for (i in 1:n) {
        buttons <- list(buttons, actionButton(inputId = paste("word", i, sep = ""), label = predictWords[i]))
      }
      # Use tagList to render the list of buttons
      tagList(buttons)
    } else {
      # Render an empty tagList if no predictions
      tagList("")
    }
  })

  # Observe event for the first predicted word button
  observeEvent(input$word1, {
    updateTextInput(session, "inputTxt", value = paste(input$inputTxt, get('savedWords', envir = .GlobalEnv)[1]))
  })

  # Observe event for the second predicted word button
  observeEvent(input$word2, {
    updateTextInput(session, "inputTxt", value = paste(input$inputTxt, get('savedWords', envir = .GlobalEnv)[2]))
  })

  # Observe event for the third predicted word button
  observeEvent(input$word3, {
    updateTextInput(session, "inputTxt", value = paste(input$inputTxt, get('savedWords', envir = .GlobalEnv)[3]))
  })

  # Observe event for the fourth predicted word button
  observeEvent(input$word4, {
    updateTextInput(session, "inputTxt", value = paste(input$inputTxt, get('savedWords', envir = .GlobalEnv)[4]))
  })

})
