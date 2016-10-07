library('RNeo4j')

#graph = startGraph("http://neo4j:7474/db/data")
clear(graph)
Y

readload <- function(path) {
  query = paste(readLines(path), collapse="\n")
  return (query)
}

query1 = readload('client.load')

cypher(graph, query1)

query2 = readload('agreement.load')

cypher(graph, query2)

query3 = readload('entity.load')

cypher(graph, query3)

query4 = readload('irsvanilla.load')

cypher(graph, query4)

summary(graph)