library('RNeo4j')

buildDataBase = function() {
  readload <- function(path) {
    query = paste(readLines(path), collapse="\n")
    return (query)
  }
  
  graph = startGraph("http://neo4j:7474/db/data")
  clear(graph, input=FALSE)
  
  query1 = readload('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/load/client.load')
  
  cypher(graph, query1)
  
  query2 = readload('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/load/agreement.load')
  
  cypher(graph, query2)
  
  query3 = readload('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/load/entity.load')
  
  cypher(graph, query3)
  
  query4 = readload('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/load/irsvanilla.load')
  
  cypher(graph, query4)
  
  return (graph)
}
