library("shiny")

shinyUI(fluidPage(

  theme = shinythemes::shinytheme(theme = "flatly"),
  
  titlePanel("Ribose Keyword Poet"),
  
  navbarPage("",
             
             tabPanel("Lookup",
                      
                      sidebarLayout(
                        sidebarPanel(
                          textInput("keyword_lookup", "Input your Keyword", value = ""),
                          tags$p("Input the keyword of the poem to find the best match...\n"),
                          radioButtons("if_multiple", "Multiple Output Allowance", 
                                       choiceNames = list("Single Output", "Multiple Output"),
                                       choiceValues = list(FALSE, TRUE))
                        ),
                        mainPanel(
                          tags$h3("Output"),
                          uiOutput("poem_lookup"),
                          tags$br(),
                          tags$h3("Output in Pinyin"),
                          uiOutput("pinyin_lookup")
                        )
                      )
                      
             ),
             
             tabPanel("Compose",
                      
                      sidebarLayout(
                        sidebarPanel(
                          textInput("keyword_compose", "Input your Keyword", value = ""),
                          tags$p("Input the keyword to start Ribose's composition...\n"),
                          numericInput("word_count", "Number of words for each sentence",
                                       value = 5,
                                       min = 5,
                                       max = 10,
                                       step = 1),
                          numericInput("sent_count", "Number of sentences for the poem",
                                       value = 4,
                                       min = 2,
                                       max = 20,
                                       step = 2)
                          
                        ),
                        mainPanel(
                          tags$h3("Output"),
                          uiOutput("poem_compose")
                          
                        )
                      )
                      
             ),
             
             tabPanel("About",
                      
                      tags$blockquote("Ribose keyword poet is an AI poet based on Internet crawling technique. 
                                      Ribose can help user lookup poems from online sources as well automatically 
                                      compose poems based on given source. The logistics behind poem composition 
                                      is still under development."),
                      tags$blockquote("Granted with absolute confidence, artificial intelligence and machine 
                                      learning started from being a mere statistics computing technique but rapidly
                                      changed the way we look at them as well as the way we look at our world. Poems,
                                      fragments of language blessed with amazing human intelligence and beauty, 
                                      have long been perceived as unduplicatable by machines and any other sources
                                      of intelligence other than that of human. However, as AI progressively blurring
                                      the boundary between Human and Machine intelligence, a lot less assumptions 
                                      can be made these days about the privilege of human intelligence. Ribose keyword 
                                      poet, a vanguard of digitalization of poems and composition of such, is taking 
                                      a small step forward this one. "),
                      tags$blockquote("Ribose gets its name from its prototypical language R and Verbose. Moreover,
                                      ribose is also a Biochemistry terminology referring to a generally stable five-carbon
                                      cyclic structure. Ribose in Biochemistry is one of the most fundamental carbon 
                                      structures essential to gene regulation. Altogether, the name suggests the bionic
                                      nature of this algorithm."),
                      tags$blockquote("The team of Ribose is, and always will be, open to interested developers.
                                      This project is completely open source under MIT license. Project Repository:
                                      https://github.com/Broccolito/Keyword_poet")
                      
             )
             
  )
  
  
))
