library('RNeo4j')

source('R/buildDB.R')

notificationTime <- function(graph) {
  query = readLoad('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/load/notificationtime.load')
  print(query)
  list = cypher(graph, query)
  return(list)
}

list = notificationTime(graph)