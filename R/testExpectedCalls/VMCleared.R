library(RNeo4j)
library(RUnit)

# Relationships

test.relvmb = function() {
#  today = format(as.POSIXlt(Sys.time(), tz="GMT"), "%d/%m/%y")
  today = '28/11/16'
  query1 = paste("MATCH (mc:MarginCall {id:'", today, "-a1-p1-Variation'})-[:STEMS_FROM]->(a:Agreement) RETURN a.id as r", sep='')
  checkEquals(cypher(graph, query1)$r, 'a1')
  query2 = paste("MATCH (mc:MarginCall {id:'", today, "-a4-p4-Variation'})-[:DIRECTED_TO]->(e:LegalEntity) RETURN e.id as r", sep='')
  checkEquals(cypher(graph, query2)$r, 'fcm2')
  query3 = paste("MATCH (mc:MarginCall {id:'", today, "-a5-p5-Variation'})-[:SENT_FROM]->(e:LegalEntity) RETURN e.id as r", sep='')
  checkEquals(cypher(graph, query3)$r, 'fcm3')
  query1 = paste("MATCH (mc:MarginCall {id:'", today, "-a8-p8-Variation'})-[:RELATED_TO]->(a:Agreement) RETURN a.id as r", sep='')
  checkEquals(cypher(graph, query1)$r, 'p8')
}

test.propvmb = function() {
#  today = format(as.POSIXlt(Sys.time(), tz="GMT"), "%d/%m/%y")
#  tomorrow = format(as.POSIXlt(Sys.time()+3600*24, tz="GMT"), "%d/%m/%y")
  today = '28/11/16'
  tomorrow = '29/11/16'
  query1 = paste("MATCH (mc:MarginCall {id:'", today, "-a9-p9-Variation'}) RETURN mc.valuationDate as r", sep='')
  checkEquals(cypher(graph, query1)$r, today)
  query2 = paste("MATCH (mc:MarginCall {id:'", today, "-a1-p1-Variation'}) RETURN mc.callDate as r", sep='')
  checkEquals(cypher(graph, query2)$r, tomorrow)
  query3 = paste("MATCH (mc:MarginCall {id:'", today, "-a4-p4-Variation'}) RETURN mc.callType as r", sep='')
  checkEquals(cypher(graph, query3)$r, 'Variation')
  query4 = paste("MATCH (mc:MarginCall {id:'", today, "-a5-p5-Variation'}) RETURN mc.callAmount as r", sep='')
  checkEquals(cypher(graph, query4)$r, 170000)
  query5 = paste("MATCH (mc:MarginCall {id:'", today, "-a8-p8-Variation'}) RETURN mc.direction as r", sep='')
  checkEquals(cypher(graph, query5)$r, 'IN')
  query6 = paste("MATCH (mc:MarginCall {id:'", today, "-a9-p9-Variation'}) RETURN mc.callAmount as r", sep='')
  checkEquals(cypher(graph, query6)$r, -285000)
  query7 = paste("MATCH (mc:MarginCall {id:'", today, "-a9-p9-Variation'}) RETURN mc.currency as r", sep='')
  checkEquals(cypher(graph, query7)$r, 'USD')
}
