library(RNeo4j)
library(RUnit)

test.statementProperties = function () {
  prop1 = "MATCH (m:MarginStatement {id:'ms1'}) RETURN m.date as r"
  checkEquals(cypher(graph, prop1)$r, '25/10/16 12:00')
  prop2 = "MATCH (m:MarginStatement {id:'ms2'}) RETURN m.interestPayment as r"
  checkEquals(cypher(graph, prop2)$r, 7501)
  prop3 = "MATCH (m:MarginStatement {id:'ms3'}) RETURN m.productCashFlows as r"
  checkEquals(cypher(graph, prop3)$r, 2575002)
  prop4 = "MATCH (m:MarginStatement {id:'ms4'}) RETURN m.PAI as r"
  checkEquals(cypher(graph, prop4)$r, 767)
  prop5 = "MATCH (m:MarginStatement {id:'ms5'}) RETURN m.feesCommissions as r"
  checkEquals(cypher(graph, prop5)$r, 38435)
  prop6 = "MATCH (m:MarginStatement {id:'ms6'}) RETURN m.pendingCash as r"
  checkEquals(cypher(graph, prop6)$r, 0)
  prop7 = "MATCH (m:MarginStatement {id:'ms7'}) RETURN m.pendingNonCash as r"
  checkEquals(cypher(graph, prop7)$r, 0)
  prop8 = "MATCH (m:MarginStatement {id:'ms8'}) RETURN m.direction as r"
  checkEquals(cypher(graph, prop8)$r, 'IN')
  prop9 = "MATCH (m:MarginStatement {id:'ms9'}) RETURN m.unreconCount as r"
  checkEquals(cypher(graph, prop9)$r, 1)
  prop10 = "MATCH (m:MarginStatement {id:'ms10'}) RETURN m.expectedCount as r"
  checkEquals(cypher(graph, prop10)$r, 1)
  prop11 = "MATCH (m:MarginStatement {id:'ms11'}) RETURN m.totalCount as r"
  checkEquals(cypher(graph, prop11)$r, 1)
  prop12 = "MATCH (m:MarginStatement {id:'ms12'}) RETURN m.reconcileCount as r"
  checkEquals(cypher(graph, prop12)$r, 0)
  prop13 = "MATCH (m:MarginStatement {id:'ms13'}) RETURN m.disputeCount as r"
  checkEquals(cypher(graph, prop13)$r, 0)
  prop14 = "MATCH (m:MarginStatement {id:'ms14'}) RETURN m.pledgeCount as r"
  checkEquals(cypher(graph, prop14)$r, 0)
}

test.statementRelationships = function () {
  rel1 = "MATCH (mc:MarginCall {id:'mce11'})-[IS_EXPECTED_IN]->(ms:MarginStatement) RETURN ms.id as r"
  checkEquals(cypher(graph, rel1)$r, 'ms9')
  rel2 = "MATCH (mc:MarginCall {id:'mc1'})-[IS_RECEIVED_IN]->(ms:MarginStatement) RETURN ms.id as r"
  checkEquals(cypher(graph, rel2)$r, 'ms1')
  rel3 = "MATCH (ms:MarginStatement {id:'ms2'})-[:STEMS_FROM]->(a:Agreement) RETURN a.id as r"
  checkEquals(cypher(graph, rel3)$r, 'a2')
  rel4 = "MATCH (ms:MarginStatement {id:'ms3'})-[:DIRECTED_TO]->(c:Client) RETURN c.id as r"
  checkEquals(cypher(graph, rel4)$r, 'c1')
}
