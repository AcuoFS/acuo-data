library(RNeo4j)
library(RUnit)

# Relationships

test.relvmb = function() {
#  today = format(as.POSIXlt(Sys.time(), tz="GMT"), "%d/%m/%y")
  today = '28/11/16'
  query1 = paste("MATCH (mc:MarginCall {id:'", today, "-a2-Variation'})-[:STEMS_FROM]->(a:Agreement) RETURN a.id as r", sep='')
  checkEquals(cypher(graph, query1)$r, 'a2')
  query2 = paste("MATCH (mc:MarginCall {id:'", today, "-a3-Variation'})-[:DIRECTED_TO]->(e:LegalEntity) RETURN e.id as r", sep='')
  checkEquals(cypher(graph, query2)$r, 'e2')
  query3 = paste("MATCH (mc:MarginCall {id:'", today, "-a6-Variation'})-[:SENT_FROM]->(e:LegalEntity) RETURN e.id as r", sep='')
  checkEquals(cypher(graph, query3)$r, 'e8')
}

# Properties

test.propvmb = function() {
#  today = format(as.POSIXlt(Sys.time(), tz="GMT"), "%d/%m/%y")
#  tomorrow = format(as.POSIXlt(Sys.time()+3600*24, tz="GMT"), "%d/%m/%y")
  today = '28/11/16'
  tomorrow = '29/11/16'
  query1 = paste("MATCH (mc:MarginCall {id:'", today, "-a7-Variation'}) RETURN mc.valuationDate as r", sep='')
  checkEquals(cypher(graph, query1)$r, today)
  query2 = paste("MATCH (mc:MarginCall {id:'", today, "-a10-Variation'}) RETURN mc.callDate as r", sep='')
  checkEquals(cypher(graph, query2)$r, tomorrow)
  query3 = paste("MATCH (mc:MarginCall {id:'", today, "-a2-Variation'}) RETURN mc.callType as r", sep='')
  checkEquals(cypher(graph, query3)$r, 'Variation')
  query4 = paste("MATCH (mc:MarginCall {id:'", today, "-a3-Variation'}) RETURN mc.callAmount as r", sep='')
  checkEquals(cypher(graph, query4)$r, 969000)
  query5 = paste("MATCH (mc:MarginCall {id:'", today, "-a2-Variation'}) RETURN mc.deliveryAmount as r", sep='')
  checkEquals(cypher(graph, query5)$r, 4955500)
  query6 = paste("MATCH (mc:MarginCall {id:'", today, "-a6-Variation'}) RETURN mc.returnAmount as r", sep='')
  checkEquals(cypher(graph, query6)$r, 179000)
  query7 = paste("MATCH (mc:MarginCall {id:'", today, "-a10-Variation'}) RETURN mc.collateralValue as r", sep='')
  checkEquals(cypher(graph, query7)$r, -950000)
  query8 = paste("MATCH (mc:MarginCall {id:'", today, "-a2-Variation'}) RETURN mc.exposure as r", sep='')
  checkEquals(cypher(graph, query8)$r, 36010503)
}


