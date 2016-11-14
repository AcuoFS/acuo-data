library('RNeo4j')

source('R/buildDB.R')

notificationTime <- function() {
  query = readLoad('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/load/notificationtime.load')
  list = cypher(graph, query)
  return(list)
}