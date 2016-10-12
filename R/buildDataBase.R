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
  
  query3 = readload('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/load/legalentity.load')
  
  cypher(graph, query3)
  
  query4 = readload('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/load/irsvanilla.load')
  
  cypher(graph, query4)

  query5 = readload('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/load/irsfloatfloat.load')
  
  cypher(graph, query5)
    
  return (graph)
}

graph = buildDataBase()
