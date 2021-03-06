library(RNeo4j)
library(RUnit)

# I want to test whether my paths have the correct length

test.pathLength = function() {
  path1 = "MATCH p = (m:MarginCall {id:'mc2'})-[:FIRST]->(:Step)-[:NEXT*]->(:Step)<-[:LAST]-(m) RETURN LENGTH(p) as l"
  checkEquals(cypher(graph, path1)$l, 6)
  path2 = "MATCH p = (m:MarginCall {id:'mc3'})-[:FIRST]->(:Step)-[:NEXT*]->(:Step)<-[:LAST]-(m) RETURN LENGTH(p) as l"
  checkEquals(cypher(graph, path2)$l, 3)
  path3 = "MATCH p = (m:MarginCall {id:'mc6'})-[:FIRST]->(:Step)-[:NEXT*]->(:Step)<-[:LAST]-(m) RETURN LENGTH(p) as l"
  checkEquals(cypher(graph, path3)$l, 3)
  path4 = "MATCH p = (m:MarginCall {id:'mc5'})-[:FIRST]->(:Step)-[:NEXT*]->(:Step)<-[:LAST]-(m) RETURN LENGTH(p) as l"
  checkEquals(cypher(graph, path4)$l, 6)
  path5 = "MATCH p = (m:MarginCall {id:'mc8'})-[:FIRST]->(:Step)-[:NEXT*]->(:Step)<-[:LAST]-(m) RETURN LENGTH(p) as l"
  checkEquals(cypher(graph, path5)$l, 6)
}

test.marginCallProperties = function() {
  prop1 = "MATCH (m:MarginCall {id:'mc1'}) RETURN m.valuationDate as r"
  checkEquals(cypher(graph, prop1)$r, '24/10/16')
  prop2 = "MATCH (m:MarginCall {id:'mc2'}) RETURN m.callDate as r"
  checkEquals(cypher(graph, prop2)$r, '25/10/16')
  prop3 = "MATCH (m:MarginCall {id:'mc3'}) RETURN m.callType as r"
  checkEquals(cypher(graph, prop3)$r, 'Variation')
  prop4 = "MATCH (m:MarginCall {id:'mc4'}) RETURN m.callAmount as r"
  checkEquals(cypher(graph, prop4)$r, 100)
  prop5 = "MATCH (m:MarginCall {id:'mc5'}) RETURN m.returnAmount as r"
  checkEquals(cypher(graph, prop5)$r, 0)
  prop6 = "MATCH (m:MarginCall {id:'mc8'}) RETURN m.deliverAmount as r"
  checkEquals(cypher(graph, prop6)$r, 300000)
  prop7 = "MATCH (m:MarginCall {id:'mc9'}) RETURN m.collateralValue as r"
  checkEquals(cypher(graph, prop7)$r, 9000000)
  prop8 = "MATCH (m:MarginCall {id:'mc10'}) RETURN m.pendingCollateral as r"
  checkEquals(cypher(graph, prop8)$r, 0)
  prop9 = "MATCH (m:MarginCall {id:'mc11'}) RETURN m.exposure as r"
  checkEquals(cypher(graph, prop9)$r, -10000000)
  prop10 = "MATCH (m:MarginCall {id:'mc4'}) RETURN m.IMRole as r"
  checkEquals(cypher(graph, prop10)$r, 'Pledgor')
  prop11 = "MATCH (m:MarginCall {id:'mc5'}) RETURN m.assetsSettled as r"
  checkEquals(cypher(graph, prop11)$r, 'US912796HW25|GBP|37833100|46625H100')
  prop12 = "MATCH (m:MarginCall {id:'mc8'}) RETURN m.settledQuantities as r"
  checkEquals(cypher(graph, prop12)$r, '10000')
  prop13 = "MATCH (m:MarginCall {id:'mc4'}) RETURN m.markToMarketClient as r"
  checkEquals(cypher(graph, prop13)$r, 9957500)
  prop14 = "MATCH (m:MarginCall {id:'mc7'}) RETURN m.collateralBalanceClient as r"
  checkEquals(cypher(graph, prop14)$r, 150000)
  prop15 = "MATCH (m:MarginCall {id:'mc4'}) RETURN m.disputeReasonCode as r"
  checkEquals(cypher(graph, prop15)$r, '9008')
  prop16 = "MATCH (m:MarginCall {id:'mc7'}) RETURN m.cancelReasonCode as r"
  checkEquals(cypher(graph, prop16)$r, '9999')
  prop17 = "MATCH (m:MarginCall {id:'mc5'}) RETURN m.pledgedAssets as r"
  checkEquals(cypher(graph, prop17)$r, NA)
  prop18 = "MATCH (m:MarginCall {id:'mc8'}) RETURN m.quantitiesPledged as r"
  checkEquals(cypher(graph, prop18)$r, NA)
}

test.quantities = function() {
  qty1 = "MATCH (:CustodianAccount {id:'cust2'})-[h:HOLDS]->(:Asset{id:'GBP'}) RETURN h.settledQuantities as q"
  checkEquals(cypher(graph, qty1)$q, 30000)
  qty2 = "MATCH (:CustodianAccount {id:'cust1'})-[h:HOLDS]->(:Asset{id:'US912796HW25'}) RETURN h.pledgedQuantities as q"
  checkEquals(cypher(graph, qty2)$q, 0)
  qty3 = "MATCH (:CustodianAccount {id:'cust3'})-[h:HOLDS]->(:Asset{id:'37833100'}) RETURN h.settledQuantities as q"
  checkEquals(cypher(graph, qty3)$q, 200)
  qty4 = "MATCH (:CustodianAccount {id:'cust4'})-[h:HOLDS]->(:Asset{id:'46625H100'}) RETURN h.pledgedQuantities as q"
  checkEquals(cypher(graph, qty4)$q, 0)
}
