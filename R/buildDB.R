library('RNeo4j')

readLoad <- function(path) {
  query = paste(readLines(path), collapse="\n")
  return (query)
}

buildDataBase = function() {

#  graph = startGraph("http://neo4j:7474/db/data")
  graph = startGraph("http://localhost:7474/db/data/")
  
  clear(graph,input=FALSE)
  
  load.name <- c('/load/client.load',
                 '/load/legalentity.load',
                 '/load/account.load',
                 '/load/agreement.load',
                 '/load/cds.load',  
                 '/load/irs.load', 
                 '/load/ndf.load', 
                 '/load/fxsi.load', 
                 '/load/fxsw.load',
                 '/load/optionsvanilla.load', 
                 '/load/optionsbarrier.load', 
                 '/load/fra.load',
                 '/load/zcs.load', 
                 '/load/swaption.load',
                 '/load/recipientInfo.load',
                 '/load/assetCategory.load',
                 '/load/assetInventory.load', 
                 '/load/custodian.load',
                 '/load/custodianAccount.load',
                 '/load/custodianAsset.load',
                 '/load/margincall/initmc.load')

  for (i in 1:10) {
    load.name <- c(load.name, paste('/load/margincall/info', toString(i), '.load', sep=''))
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

  load.name <- c(load.constr,load.name)
  
  load.preurl<-'https://raw.githubusercontent.com/AcuoFS/acuo-data/master'
  
  load.url<-paste(load.preurl,sep='',load.name)
  
  load.query<-list()
  
  for(i in 1:length(load.name)){
    load.query[i] <- readLoad(load.url[i])
    cypher(graph,load.query[[i]])
  }
  
  return(graph)
}

graph = buildDataBase()
