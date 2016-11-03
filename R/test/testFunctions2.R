library("RUnit")
library("RNeo4j")

# I want to test whether the correct amount of nodes was created:

test.node.num = function(){
  nodenum.query1 = "match (n:Asset) return count(n) AS c"
  checkEquals(cypher(graph,nodenum.query1)$c,5)
  
  nodenum.query2 = "match (n:AssetCategory) return count(n) AS c"
  checkEquals(cypher(graph,nodenum.query2)$c,7)
}

# I want to test whether the relationships I created are correct:
test.rel.num =function(){
  relnum.query1 = "match (a)-[r:IS_IN]->(b) return count(r) as c"
  checkEquals(cypher(graph,relnum.query1)$c,5)
  
  relnum.query2 = "match (a)-[r:IS_ELIGIBLE_UNDER]->(b) return count(r) as c"
  checkEquals(cypher(graph,relnum.query2)$c,24)
  
  relnum.query3 = "match (a)-[r:IS_AVAILABLE_FOR]->(b) return count(r) as c"
  checkEquals(cypher(graph,relnum.query3)$c,18)
  
  relnum.query4 = "match (a)-[r:POSSESSES]->(b) return count(r) as c"
  checkEquals(cypher(graph,relnum.query4)$c,9)
  
  relnum.query5 = "match (a)-[r:ACCESSES]->(b) return count(r) as c"
  checkEquals(cypher(graph,relnum.query5)$c,27)
}

test.rel.type = function(){
  
 # rel.query = list()
  rel.query1 = "match (ac:AssetCategory)-[r]->(ag:Agreement {id:'a1'}) 
                where ac.name='U.S. Treasury Bills' and ac.currency='USD' and ac.maturityLb=0 and ac.maturityUp=1
                return type(r) as rel1"
  checkEquals(cypher(graph,rel.query1)$rel1, 'IS_ELIGIBLE_UNDER')
  
  rel.query2 = "match (ac:AssetCategory)-[r]->(ag:Agreement {id:'a1'}) 
                where ac.name='JPM US Equity' and ac.currency='USD' and ac.ticker='JPM'
                return type(r) as rel2"
  checkEquals(cypher(graph,rel.query2)$rel2, 'IS_ELIGIBLE_UNDER')
  
  rel.query3 = "match (ac:AssetCategory)-[r]->(ag:Agreement {id:'a2'}) 
                where ac.name='JPM US Equity' and ac.currency='USD' and ac.ticker='JPM'
                return type(r) as rel3"
  checkEquals(cypher(graph,rel.query3)$rel3, NULL)  
  
  rel.query4 = "match (a:Asset)-[r]->(ac:AssetCategory)-->(ag:Agreement {id:'a1'}) where a.CUSIP='46625H100' return type(r) as rel4"
  checkEquals(cypher(graph,rel.query4)$rel4, 'IS_IN')
  
  rel.query5 = "match (a:Asset)-[r]->(ac:AssetCategory)-->(ag:Agreement {id:'a2'}) where a.CUSIP='46625H100' return type(r) as rel5"
  checkEquals(cypher(graph,rel.query5)$rel5, NULL)
  
  rel.query6 = "match (c:Client {id:'c1'})-[r]->(a:Asset)  where a.CUSIP='46625H100'   return type(r) as rel6"
  checkEquals(cypher(graph,rel.query6)$rel6, 'POSSESSES')
  
  rel.query7 = "match (e:LegalEntity {id:'e1'})-[r]->(a:Account {id:'acc1'}) return type(r) as rel7"
  checkEquals(cypher(graph,rel.query7)$rel7, 'HAS')
  
  rel.query8 = "match (acc:Account {id:'acc2'})-[r]->(a:Asset)  where a.CUSIP='46625H100'  return type(r) as rel8"
  checkEquals(cypher(graph,rel.query8)$rel8, 'ACCESSES')
  
  rel.query9 = "match (acc:Account {id:'acc8'})-[r]->(a:Asset)  where a.CUSIP='46625H100'   return type(r) as rel9"
  checkEquals(cypher(graph,rel.query9)$rel9, NULL)
  
  rel.query10 = "match (a:Asset)-[r]->(ag:Agreement {id:'a8'})  where UPPER(a.type)='GOLD'   return type(r) as rel10"
  checkEquals(cypher(graph,rel.query10)$rel10, 'IS_AVAILABLE_FOR')
  
  rel.query11 = "match (a:Asset)-[r]->(ag:Agreement {id:'a8'})  where UPPER(a.ticker)='JPM'   return type(r) as rel11"
  checkEquals(cypher(graph,rel.query11)$rel11, NULL)
  
  
}

# I want to test whether the nodes I created have the appropriate properties:

test.node.prop = function(){
  prop.query1 = "match (a:Asset) where a.CUSIP='46625H100' return a.ticker as t"
  checkEquals(cypher(graph,prop.query1)$t, 'JPM')  
  
  prop.query2 = "match (a:Asset) where a.CUSIP='46625H100' return a.currency as q"
  checkEquals(cypher(graph,prop.query2)$q, 'USD')  
  
  prop.query3 = "match (a:Asset) where a.ISIN='US912796HW25' return a.issueDate as i"
  checkEquals(cypher(graph,prop.query3)$i, '03/02/2016')
  
  prop.query4 = "match (a:Asset) where a.ISIN='US912796HW25' return a.maturityDate as m"
  checkEquals(cypher(graph,prop.query4)$m, '02/02/2017')
  
  prop.query5 = "match (a:Asset) where a.ISIN='US912796HW25' return a.type as t"
  checkEquals(cypher(graph,prop.query5)$t, 'Tbill')
  
  prop.query6 = "match (a:Asset) where a.ISIN='US912796HW25' return a.timeToMaturity as t"
  checkEquals(round(cypher(graph,prop.query6)$t,1), 0.3)
  
  prop.query7 = "match (a:Asset) where a.currency='GBP' and a.type='Cash' return a.name as n"
  checkEquals(cypher(graph,prop.query7)$n, 'British Pound')
}


# I want to test whether the relationships I created have the appropriate properties:

test.rel.prop = function(){
  prop.query1 = "match (c:Client {id:'c1'})-[p:POSSESSES]->(a:Asset) where a.CUSIP='46625H100' return p.quantities as q"
  checkEquals(cypher(graph,prop.query1)$q, 20000)
  prop.query2 = "match (c:Client {id:'c2'})-[p:POSSESSES]->(a:Asset) where a.ISIN='US912796HW25' return p.quantities as q"
  checkEquals(cypher(graph,prop.query2)$q, 100000)
  prop.query3 = "match (ac:AssetCategory)-[is:IS_ELIGIBLE_UNDER]->(a:Agreement {id:'a1'}) where ac.currency='GBP' and ac.type='Cash' return is.haircut as h"
  checkEquals(cypher(graph,prop.query3)$h, 0)
  prop.query4 = "match (ac:AssetCategory)-[is:IS_ELIGIBLE_UNDER]->(a:Agreement {id:'a1'}) where ac.ticker='JPM' return is.FXHaircut as h"
  checkEquals(cypher(graph,prop.query4)$h, 0)
  
}




