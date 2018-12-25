library("shiny")

shinyServer(function(input, output) {
  
  source("main.R")
  
  output$poem_lookup = renderUI({
    
    keywd = as.character(input$keyword_lookup)
    poem = paste_together(get_poem(keywd, multiple = input$if_multiple))
    tags$blockquote(poem)
    
  })
  
  output$pinyin_lookup = renderUI({
    
    keywd = as.character(input$keyword_lookup)
    poem = paste_together(get_poem(keywd, multiple = input$if_multiple))
    tags$blockquote(py(poem, sep = " "))
    
  })
  
  output$poem_compose = renderUI({
    
    general_dict <<- "NA"
    keywd = as.character(input$keyword_compose)
    
    if(nchar(keywd) == 0){
      return(NULL)
    }
    
    word_count = input$word_count
    sent_count = input$sent_count
    data_base = paste_together(get_poem(keywd, multiple = TRUE), with = "")
    general_dict <<- make_dict(data_base)
    poem = paste_together(create.rand.poem(char = word_count, sent = sent_count), with = "\n")
    poem_with_pinyin = py(poem, sep = " ")
    tags$blockquote(names(poem_with_pinyin), tags$br(), poem_with_pinyin)
    
  })  
  
  
})

