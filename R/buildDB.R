library('RNeo4j')

buildDataBase = function() {
  readload <- function(path) {
    query = paste(readLines(path), collapse="\n")
    return (query)
  }

#  graph = startGraph("http://neo4j:7474/db/data")
  graph = startGraph("http://localhost:7474/db/data/")
  
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
                 '/assetInventory.load',
                 '/margincall/initmc.load')

  for (i in 1:10) {
    load.name <- c(load.name, paste('/margincall/info', toString(i), '.load', sep=''))
  }
  
  load.name <- c(load.name, ('/notificationtime.load'))
  
  load.constr <- c('constraint/account.load', 
                   'constraint/agreement.load',
                   'constraint/asset.load',
                   'constraint/client.load',
                   'constraint/legalentity.load',
                   'constraint/margincall.load',
                   'constraint/trade.load')
  
  load.name = c(load.constr, load.name)

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