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
                 '/recipientInfo.load',
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
                 '/custodian.load',
                 '/custodianAccount.load',
                 '/custodianAsset.load',
                 '/margincall/initmc.load')

  for (i in 1:10) {
    load.name <- c(load.name, paste('/margincall/info', toString(i), '.load', sep=''))
  }
  
  load.constr <- c('/loadconstraint/account.load', 
                   '/loadconstraint/agreement.load',
                   '/loadconstraint/asset.load',
                   '/loadconstraint/client.load',
                   '/loadconstraint/legalentity.load',
                   '/loadconstraint/custodian.load',
                   '/loadconstraint/custodianAccount.load',
                   '/loadconstraint/margincall.load',
                   '/loadconstraint/trade.load')

  load.name <- c(load.constr,paste('/load',load.name,sep=""), ('/notificationtime.load'))
  
  load.preurl<-'https://raw.githubusercontent.com/AcuoFS/acuo-data/master'
  
  load.url<-paste(load.preurl,sep='',load.name)
  
  load.query<-list()
  
  for(i in 1:length(load.name)){
    load.query[i] <- readload(load.url[i])
    cypher(graph,load.query[[i]])
  }
  
  return(graph)
}

graph = buildDataBase()