if(!require("pinyin")){
  install.packages("pinyin")
  library("pinyin")
}

#Get the Pinyin spell of the string
getpinyin = function(Char){
  return(py(char = Char, sep = " "))
}

#Return the yun of the string
getyun = function(char){
  charpinyin = getpinyin(Char = char)
  charpinyin = unlist(strsplit(charpinyin,""))
  for(i in 1:length(charpinyin)){
    if(any(charpinyin[i] == c("a","e","i","o","u"))){
      temyun = charpinyin[i:length(charpinyin)];break
    }
  }
  yun = ""
  for(i in 1:length(temyun)){
    yun = paste(yun,temyun[i],sep = "")
  }
  return(yun)
}

#Choose a word between a randomly samled noun or adjective
wordbutverb = function(){
  stopifnot(exists("wk"))
  stopifnot(exists("wktag"))
  selection = c(FALSE,TRUE)
  choice = sample(selection,1)
  if(choice){
    newput = sample(general_dict$dict.noun,1)
  }else if(!choice){
    newput = sample(general_dict$dict.adj,1)
  }
  return(newput)
}

create.sent = function(n = 5){
  stopifnot(exists("wk"))
  stopifnot(exists("wktag"))
  again = TRUE
  while(again){
    verb = sample(general_dict$dict.verb,1)
    nadj = wordbutverb()
    while(nchar(nadj) + nchar(verb) > n){
      nadj = wordbutverb()
    }
    if(nchar(nadj) + nchar(verb) == n){
      temsent = c(nadj,verb)
      again = FALSE
    }else{
      temsent = c(nadj,verb)
      again = TRUE
    }
  }
  temsent = sample(temsent,length(temsent),replace = FALSE)
  sent = ""
  for(i in 1:length(temsent)){
    sent = paste(sent,temsent[i],sep = "")
  }
  return(sent)
}

print.rand.poem = function(char = 5,sent = 4){
  stopifnot(exists("wk"))
  stopifnot(exists("wktag"))
  for(i in 1:sent){
    print(create.sent(char))
  }
}
