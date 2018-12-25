#rm(list = ls())

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
if(!require("shinythemes")){
  install.packages("shinythemes")
  library("shinythemes")
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

# wd = get_directory()
# setwd(wd)

source("fileoperation.R")
source("get_poem.R")
source("make_dict.R")
source("compose.R")
source("adv_compose.R")
source("ui.R")
source("server.R")
