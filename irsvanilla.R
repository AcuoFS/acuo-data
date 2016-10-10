library('RNeo4j')

graph = startGraph("http://neo4j:7474/db/data")
clear(graph)
Y

readload <- function(path) {
  query = paste(readLines(path), collapse="\n")
  return (query)
}

query1 = readload('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/client.load')

cypher(graph, query1)

query2 = readload('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/agreement.load')

cypher(graph, query2)

query3 = readload('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/entity.load')

cypher(graph, query3)

query4 = readload('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/irsvanilla.load')

cypher(graph, query4)

#linkquery <- function(fromId, toId, rel) {
#  query = paste("MATCH (n), (m)  WHERE (n)-[:", rel, "]->(m)  RETURN n.", fromId, " AS from, m.", toId, " AS to", sep='')
#}

#edges = cypher(graph, linkquery(fromId="tradeID", toId="agreementID", rel="FOLLOWS"))
#edges = rbind(edges, cypher(graph, linkquery(fromId="clientID", toId="agreementID", rel="DELIVERS_MARGIN_ACC_TO")))
#edges = rbind(edges, cypher(graph, linkquery(fromId="clientID", toId="entityID", rel="OWNS")))
#edges = rbind(edges, cypher(graph, linkquery(fromId="entityID", toId="tradeID", rel="POSITIONS_ON")))

#nodes = data.frame(id=unique(c(edges$from, edges$to)))
#nodes$label = nodes$id

#visNetwork(nodes, edges)
