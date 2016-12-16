library(RNeo4j)
library(RUnit)

# Relationships

test.relvmb = function() {
#  today = format(as.POSIXlt(Sys.time(), tz="GMT"), "%d/%m/%y")
  today = '28/11/16'
  query1 = paste("MATCH (mc:MarginCall {id:'", today, "-a4-p4-Initial'})-[:STEMS_FROM]->(a:Agreement) RETURN a.id as r", sep='')
  checkEquals(cypher(graph, query1)$r, 'a4')
  query2 = paste("MATCH (mc:MarginCall {id:'", today, "-a5-p5-Initial'})-[:DIRECTED_TO]->(e:LegalEntity) RETURN e.id as r", sep='')
  checkEquals(cypher(graph, query2)$r, 'e3')
  query3 = paste("MATCH (mc:MarginCall {id:'", today, "-a8-p8-Initial'})-[:SENT_FROM]->(e:LegalEntity) RETURN e.id as r", sep='')
  checkEquals(cypher(graph, query3)$r, 'e4')
  query1 = paste("MATCH (mc:MarginCall {id:'", today, "-a9-p9-Initial'})-[:RELATED_TO]->(p:Portfolio) RETURN p.id as r", sep='')
  checkEquals(cypher(graph, query1)$r, 'p9')
}

test.propvmb = function() {
#  today = format(as.POSIXlt(Sys.time(), tz="GMT"), "%d/%m/%y")
#  tomorrow = format(as.POSIXlt(Sys.time()+3600*24, tz="GMT"), "%d/%m/%y")
  today = '28/11/16'
  tomorrow = '29/11/16'
  query1 = paste("MATCH (mc:MarginCall {id:'", today, "-a1-p1-Initial'}) RETURN mc.valuationDate as r", sep='')
  checkEquals(cypher(graph, query1)$r, today)
  query2 = paste("MATCH (mc:MarginCall {id:'", today, "-a4-p4-Initial'}) RETURN mc.callDate as r", sep='')
  checkEquals(cypher(graph, query2)$r, tomorrow)
  query3 = paste("MATCH (mc:MarginCall {id:'", today, "-a5-p5-Initial'}) RETURN mc.callType as r", sep='')
  checkEquals(cypher(graph, query3)$r, 'Initial')
  query4 = paste("MATCH (mc:MarginCall {id:'", today, "-a8-p8-Initial'}) RETURN mc.callAmount as r", sep='')
  checkEquals(cypher(graph, query4)$r, 150000)
  query5 = paste("MATCH (mc:MarginCall {id:'", today, "-a9-p9-Initial'}) RETURN mc.direction as r", sep='')
  checkEquals(cypher(graph, query5)$r, 'OUT')
  query6 = paste("MATCH (mc:MarginCall {id:'", today, "-a1-p1-Initial'}) RETURN mc.callAmount as r", sep='')
  checkEquals(cypher(graph, query6)$r, 300000)
  query7 = paste("MATCH (mc:MarginCall {id:'", today, "-a4-p4-Initial'}) RETURN mc.currency as r", sep='')
  checkEquals(cypher(graph, query7)$r, 'USD')
}
