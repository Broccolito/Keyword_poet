rm(list = ls())

if(!require("rstudioapi")){
  install.packages("rstudioapi")
  library("rstudioapi")
}
if(!require("pinyin")){
  install.packages("pinyin")
  library("pinyin")
}
if(!require("rvest")){
  install.packages("rvest")
  library("rvest")
}
if(!require("shiny")){
  install.packages("shiny")
  library("shiny")
}
if(!require("stringi")){
  install.packages("stringi")
  library("stringi")
}

get_directory = function(){
  args <- commandArgs(trailingOnly = FALSE)
  file <- "--file="
  rstudio <- "RStudio"
  match <- grep(rstudio, args)
  if(length(match) > 0){
    return(dirname(rstudioapi::getSourceEditorContext()$path))
  }else{
    match <- grep(file, args)
    if (length(match) > 0) {
      return(dirname(normalizePath(sub(file, "", args[match]))))
    }else{
      return(dirname(normalizePath(sys.frames()[[1]]$ofile)))
    }
  }
}

wd = get_directory()
setwd(wd)

source("fileoperation.R")
source("get_poem.R")
source("make_dict.R")
source("compose.R")
source("adv_compose.R")



ui <- fluidPage(
  
  titlePanel("Keyword Poet"),
  
  navbarPage("",
           
           tabPanel("Lookup",
                    
                    sidebarLayout(
                      sidebarPanel(
                        textInput("keyword", "Input your Keyword", value = ""),
                        tags$p("Input the keyword of the poem to find the best match...\n"),
                        radioButtons("if_multiple", "Multiple Output Allowance", 
                                     choiceNames = list("Single Output", "Multiple Output"),
                                     choiceValues = list(FALSE, TRUE))
                      ),
                      mainPanel(
                        tags$h3("Output"),
                        uiOutput("poem")
                      )
                    )
                    
                    ),
           
           tabPanel("Compose"
                    
                    
                    
                    
                    )
           
           
           
           )
  

)

server <- function(input, output, session) {
  
  output$poem = renderUI({
    
    keywd = as.character(input$keyword)
    tags$blockquote(
      paste_together(get_poem(keywd, multiple = input$if_multiple))
      )
    
   })
  
}

shinyApp(ui, server)

