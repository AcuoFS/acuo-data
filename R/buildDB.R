library('RNeo4j')

buildDataBase = function() {
  readload <- function(path) {
    query = paste(readLines(path), collapse="\n")
    return (query)
  }

  graph = startGraph("http://neo4j:7474/db/data")
#  graph = startGraph("http://localhost:7474/db/data/")
  
  clear(graph,input=FALSE)
  
  load.name <- c('/client.load',
                 '/legalentity.load',
                 '/account.load',
                 '/agreement.load',
                 '/cds.load',
                 '/irsvanilla.load', 
                 '/irsfloatfloat.load', 
                 '/ndf.load', 
                 '/fxsi.load', 
                 '/fxsw.load',
                 '/optionsvanilla.load', 
                 '/optionsbarrier.load', 
                 '/fra.load',
                 '/zcs.load', 
                 '/swaption.load',
                 '/assetCategory.load',
                 '/assetInventory.load')
  
  l = length(load.name) - 2
  
  load.constr = vector(length=l)
  
  for(i in 1:l) {
    load.constr[i] = paste('constraint', load.name[i], sep='')
  }
  
  load.name = c(load.name, load.constr)

  load.preurl<-'https://raw.githubusercontent.com/AcuoFS/acuo-data/master/load'
  
  load.url<-paste(load.preurl,sep='',load.name)
  
  load.query<-list()
  
  for(i in 1:length(load.name)){
    load.query[i] <- readload(load.url[i])
    cypher(graph,load.query[[i]])
  }
  
  return(graph)
}

graph = buildDataBase()
