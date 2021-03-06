library('RNeo4j')

readLoad <- function(path) {
  query = paste(readLines(path), collapse="\n")
  return (query)
}

buildDataBase = function() {
  graph = startGraph("http://margin.acuo.com:7474/db/data/")
#  graph = startGraph("http://localhost:7474/db/data/")
  
  clear(graph,input=FALSE)
  
  load.name <- c('/cypher/firms.load',
                 '/cypher/legalentities.load',
                 '/cypher/clearingHouses.load',
                 '/cypher/fcms.load',
                 '/cypher/tradingAccounts.load',
                 '/cypher/bilateralAgreements.load',
                 '/cypher/clearedAgreements.load',
                 '/cypher/assetCategories.load',
                 '/cypher/custodians.load',
                 '/cypher/custodianAccounts.load',
                 '/cypher/counterpartCustodianAccounts.load',
                 '/cypher/custodianAssets.load',
                 '/cypher/mstatements.load',
                 '/cypher/initmcexp.load',
                 '/cypher/initmc.load',
                 '/cypher/infopres.load',
                 '/cypher/settings.load',
                 '/cypher/assetTransfer.load',
                 '/cypher/currencies.load', 
                 '/cypher/portfolios.load')
  
  load.preurl<-'https://raw.githubusercontent.com/AcuoFS/acuo-data/master/graph-data'
  
  load.url<-paste(load.preurl,sep='',load.name)
  
  load.query<-list()
  
  for(i in 1:length(load.name)) {
    load.query[i] <- readLoad(load.url[i])
    load.query[i] <- gsub('%dataImportLink%', load.preurl, load.query[i])
    print(load.name[i])
    cypher(graph,load.query[[i]])
  }
  return(graph)
}


for (i in 1:10000) {
  graph <- buildDataBase()
  print(Sys.time())
  x = runif(1,0.5,2.0)
  Sys.sleep(x)
}