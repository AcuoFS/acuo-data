library('RNeo4j')

source('R/buildDB.R')

expectedCall <- function(graph) {
  query = readLoad('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/load/expVMBilateral.load')
  print(query)
  list = cypher(graph, query)
  return(list)
}

graph = expectedCall(graph)