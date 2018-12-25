get_poem = function(keyword, multiple = FALSE){
  
  keyword = as.character(keyword)
  
  if(!require("rvest")){
    install.packages("rvest")
    library("rvest")
  }
  
  get_pozhe = function(){
    return(
      unlist(strsplit(
        (html_nodes(read_html("https://so.gushiwen.org/search.aspx?value=%E7%A7%8B%E5%A4%A9"), 
                    "textarea")[1] %>% as.character())
        , ""))[317]
    )
  }
  pozhe = get_pozhe()
  
  base_url = paste0("https://so.gushiwen.org/search.aspx?value=", keyword)
  
  poem_nodes = html_nodes(read_html(base_url), "textarea")
  
  poems = vector()
  for(i in 1:length(poem_nodes)){
    
    tryCatch({
      poem_node = as.character(poem_nodes[i])
      temp = unlist(strsplit(poem_node, ">"))[2]
      temp = unlist(strsplit(temp, "https"))[1]
      poems[i] = unlist(strsplit(temp, pozhe))[1]
    }, error = function(e){
      return(NULL)
    })
    
  }
  
  if(multiple){
    return(poems[])
  }else{
    return(poems[1])
  }
  
}
