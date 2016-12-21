library(RNeo4j)
library(RUnit)

# I want to test whether the asset has the correct status

test.assetStatus = function() {
  
  query1 <- "match (a:AssetSegment) return count(a) as c"
  checkEquals(cypher(graph,query1)$c,7)
  
  query2 <- "match (ca:CustodianAccount)-[r:RECEIVES]->(a:AssetSegment) return count(r) as c"
  checkEquals(cypher(graph,query2)$c,3)
  
  query3 <- "match (ca:CustodianAccount)-[r:SENDS]->(a:AssetSegment) return count(r) as c"
  checkEquals(cypher(graph,query3)$c,4)
  
  query4 <- "match (a:AssetSegment)-[r:TO]->(ca:CustodianAccount) return count(r) as c"
  checkEquals(cypher(graph,query4)$c,4)
  
  query5 <- "match (a:AssetSegment)-[r:FROM]->(ca:CustodianAccount) return count(r) as c"
  checkEquals(cypher(graph,query5)$c,3)
  
  query6 <- "match (a:AssetSegment)-[r:TO_FULFILL]->(mc:MarginCall) return count(r) as c"
  checkEquals(cypher(graph,query6)$c,4)
  
  query7 <- "match (a:AssetSegment)-[r:FROM_CALLING]->(mc:MarginCall) return count(r) as c"
  checkEquals(cypher(graph,query7)$c,3)
  
  query8 <- "match (a:AssetSegment {id:'DE0001104636-CustodianAccount1A-mc1'}) return a.quantities as q"
  checkEquals(cypher(graph,query8)$q,1000000)
  
  query9 <- "match (a:AssetSegment {id:'DE0001141604-CustodianAccount1A-mc39'}) return a.quantities as q"
  checkEquals(cypher(graph,query9)$q,2000000)
  
  query10 <- "match (a:AssetSegment {id:'CAD-CustodianAccount1E-mc1'}) return a.status as s"
  checkEquals(cypher(graph,query10)$s,'Departed')
  
  query11 <- "match (a:AssetSegment {id:'CHF-CustodianAccount1E-mc39'}) return a.status as s"
  checkEquals(cypher(graph,query11)$s,'Arriving')
  
  query12 <- "match (a:AssetSegment {id:'CAD-CustodianAccount1E-mc1'}) return a.status as s"
  checkEquals(cypher(graph,query12)$s,'Departed')
  
  query13 <- "match (a:AssetSegment {id:'USD-CustodianAccount1E-mc2'}) return a.subStatus as s"
  checkEquals(cypher(graph,query13)$s,NA)
  
  query14 <- "match (a:AssetSegment {id:'CAD-CustodianAccount1E-mc1'}) return a.subStatus as s"
  checkEquals(cypher(graph,query14)$s,'In-Flight')
  
  query15 <- "match (a:AssetSegment {id:'USD-CustodianAccount1E-mc2'}) return a.earmarkedQuantities as e"
  checkEquals(cypher(graph,query15)$e,NA)
  
  query16 <- "match (a:AssetSegment {id:'CHF-CustodianAccount1E-mc39'}) return a.earmarkedQuantities as e"
  checkEquals(cypher(graph,query16)$e,0)
  
  query17 <- "match (a:AssetSegment {id:'DE0001104636-CustodianAccount1A-mc1'}) return a.assetId as ai"
  checkEquals(cypher(graph,query17)$ai,'DE0001104636')
  
  query18 <- "match (a:AssetSegment {id:'CHF-CustodianAccount1E-mc39'}) return a.assetId as ai"
  checkEquals(cypher(graph,query18)$ai,'CHF')
}
