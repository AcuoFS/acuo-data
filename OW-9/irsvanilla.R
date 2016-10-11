library('RNeo4j')

buildIRSVanilla = function() {
  readload <- function(path) {   # This function isn't tested, but there's not point in loading it several times. 
    query = paste(readLines(path), collapse="\n")
    return (query)
  }
  
  graph = startGraph("http://neo4j:7474/db/data")
  clear(graph, input=FALSE)
  
  query1 = readload('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/OW-9/client.load')
  
  cypher(graph, query1)
  
  query2 = readload('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/OW-9/agreement.load')
  
  cypher(graph, query2)
  
  query3 = readload('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/OW-9/entity.load')
  
  cypher(graph, query3)
  
  query4 = readload('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/OW-9/irsvanilla.load')
  
  cypher(graph, query4)
  
  return (graph)
}

#graph = buildIRSVanilla()

#query = "MATCH (c:Client {clientID:'c1'})-[r]->(e:Entity {entityID:'e5'}) return type(r) as rel"

#print(cypher(graph, query))



#fquery <- function(x, y) {
#  z1 = paste("MATCH (:Client {clientID:'", x, "'})-[:OWNS]->(:Entity)-[:POSITIONS_ON]->(t {tradeID:'", y, "'})", sep='')
#  z2 = paste(z1, "return t.tradeID as result", sep = "\n ")
#  return(z2)
#}

#print(cypher(graph, fquery(client, trade)))

#query = "MATCH (n) return count(distinct(n))"

#print(cypher(graph, query))

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
