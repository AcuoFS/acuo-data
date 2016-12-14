library('RNeo4j')

source('R/buildDB.R')

expectedCall <- function(graph) {
  source = c('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/load/expVMBilateral.load',
             'https://raw.githubusercontent.com/AcuoFS/acuo-data/master/load/expVMCleared.load')
  query = list()
  for (i in 1:length(source)) {
    query[i] <- readLoad(source[i])
    cypher(graph, query[[i]])  
  }
  return(graph)
}

graph <- expectedCall(graph)