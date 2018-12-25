#Double check required packages
if(!require("jiebaR")){
  install.packages("jiebaR")
  library("jiebaR")
}
if(!require("jiebaRD")){
  install.packages("jiebaRD")
  library("jiebaRD")
}

#Build NLP dictionaries
wk = worker()
wktag = worker(type = "tag")

#Make a general dictionary
make_dict = function(content){
  
  paste_together = function(string_vec){
    if(any(!is.vector(string_vec), !is.character(string_vec))){
      stop("Illegal input value...")
    }
    res_string = ""
    for(i in string_vec){
      res_string = paste0(res_string, i)
    }
    return(res_string)
  }
  
  content = paste_together(content)
  
  
  #Get the tag of words from the worker dictionary
  gettag = function(string){
    while(!all(exists("wktag"),exists("wk"))){
      library(jiebaR)
      wk = jiebaR::worker()
      wktag = jiebaR::worker(type = "tag")
    }
    if(length(wk[string]) == 1){
      return(names(wktag[string]))
    }else{
      return("x")
    }
  }
  
  #Make a general dictionary
  mkdict.total = function(content){
    dict = data.frame(word = wk[content], tag = names(wktag[content]))
    return(dict)
  }
  
  #Make a dictionary for nouns
  mkdict.n = function(dict){
    if(dim(dict)[2] == 2){
      dict.n = vector()
      n = 1
      for(i in 1:dim(dict)[1]){
        tag = dict[i,2]
        if(any(tag == c("r",
                        "n",
                        "x",
                        "ns",
                        "s",
                        "i",
                        "b",
                        "uv",
                        "nz",
                        "nrt"
        ))){
          dict.n[n] = as.character(dict[i,1])
          n = n + 1
        }
      }
      dict.n = gsub("\\d","",dict.n)
      dict.n = dict.n[!is.na(dict.n)]
      return(dict.n)
    }else{
      return(FALSE)
    }
  }
  
  #Make a dictionary for verbs
  mkdict.v = function(dict){
    if(dim(dict)[2] == 2){
      dict.n = vector()
      n = 1
      for(i in 1:dim(dict)[1]){
        tag = dict[i,2]
        if(any(tag == c("v",
                        "x",
                        "d",
                        "p",
                        "c",
                        "zg"
        ))){
          dict.n[n] = as.character(dict[i,1])
          n = n + 1
        }
      }
      dict.n = gsub("\\d","",dict.n)
      dict.n = dict.n[!is.na(dict.n)]
      return(dict.n)
    }else{
      return(FALSE)
    }
  }
  
  #Make a dictionary for adjectives
  mkdict.a = function(dict){
    if(dim(dict)[2] == 2){
      dict.n = vector()
      n = 1
      for(i in 1:dim(dict)[1]){
        tag = dict[i,2]
        if(any(tag == c("a",
                        "t",
                        "n"
        ))){
          dict.n[n] = as.character(dict[i,1])
          n = n + 1
        }
      }
      dict.n = gsub("\\d","",dict.n)
      dict.n = dict.n[!is.na(dict.n)]
      return(dict.n)
    }else{
      return(FALSE)
    }
  }
  
  #Get rid of the numbers in the content
  content = gsub("\\d","",content) 
  
  #Make a general dictionary with several different modules
  dict.total = mkdict.total(content = content)
  dict.noun = mkdict.n(dict.total)
  dict.verb = mkdict.v(dict.total)
  dict.adj = mkdict.a(dict.total)
  
  dict.noun.one = dict.noun[nchar(dict.noun) == 1]
  dict.noun.two = dict.noun[nchar(dict.noun) == 2]
  dict.noun.three = dict.noun[nchar(dict.noun) == 3]
  dict.noun.four = dict.noun[nchar(dict.noun) == 4]
  
  dict.verb.one = dict.verb[nchar(dict.verb) == 1]
  dict.verb.two = dict.verb[nchar(dict.verb) == 2]
  dict.verb.three = dict.verb[nchar(dict.verb) == 3]
  dict.verb.four = dict.verb[nchar(dict.verb) == 4]
  
  dict.adj.one = dict.adj[nchar(dict.adj) == 1]
  dict.adj.two = dict.adj[nchar(dict.adj) == 2]
  dict.adj.three = dict.adj[nchar(dict.adj) == 3]
  dict.adj.four = dict.adj[nchar(dict.adj) == 4]
  
  scanned.noun = length(dict.noun)
  scanned.noun.unique = length(unique(dict.noun))
  scanned.verb = length(dict.verb)
  scanned.verb.unique = length(unique(dict.verb))
  scanned.adj = length(dict.adj)
  scanned.adj.unique = length(unique(dict.adj))
  
  #Store the modules in a list
  general_dictionary = list(
    
    dict.total = dict.total,
    dict.noun = dict.noun,
    dict.verb = dict.verb,
    dict.adj = dict.adj,
    
    dict.noun.one = dict.noun.one,
    dict.noun.two = dict.noun.two,
    dict.noun.three = dict.noun.three ,
    dict.noun.four = dict.noun.four,
    
    dict.verb.one = dict.verb.one,
    dict.verb.two = dict.verb.two,
    dict.verb.three = dict.verb.three,
    dict.verb.four = dict.verb.four,
    
    dict.adj.one = dict.adj.one,
    dict.adj.two = dict.adj.two,
    dict.adj.three = dict.adj.three,
    dict.adj.four = dict.adj.four,
    
    scanned.noun = scanned.noun,
    scanned.noun.unique = scanned.noun.unique,
    scanned.verb = scanned.verb,
    scanned.verb.unique = scanned.verb.unique,
    scanned.adj = scanned.adj,
    scanned.adj.unique = scanned.adj.unique
    
  )
  
  return(general_dictionary)
  
}

