library("RUnit")
library("RNeo4j")

# I want to test whether the correct amount of nodes was created:

test.node.num = function(){
  nodenum.query1 = "match (n:Asset) return count(n) AS c"
  checkEquals(cypher(graph,nodenum.query1)$c,75)
  
  nodenum.query2 = "match (n:AssetCategory) return count(n) AS c"
  checkEquals(cypher(graph,nodenum.query2)$c,39)
  
  nodenum.query3 = "match (n:Custodian) return count(n) AS c"
  checkEquals(cypher(graph,nodenum.query3)$c,2)
  
  nodenum.query4 = "match (n:CustodianAccount) return count(n) AS c"
  checkEquals(cypher(graph,nodenum.query4)$c,11)
  
  nodenum.query5 = "match (n:Account) return count(n) AS c"
  checkEquals(cypher(graph,nodenum.query5)$c,10)
}

# I want to test whether the relationships I created are correct:
test.rel.num =function(){
  relnum.query1 = "match (a)-[r:IS_IN]->(b) return count(r) as c"
  checkEquals(cypher(graph,relnum.query1)$c,37)
  
  relnum.query2 = "match (a)-[r:IS_ELIGIBLE_UNDER]->(b) return count(r) as c"
  checkEquals(cypher(graph,relnum.query2)$c,546)
  
  relnum.query3.1 = "match (a)-[r:IS_AVAILABLE_FOR]->(b)<--(e:LegalEntity)<--(c:Client {id:'c1'}) return count(r) as c"
  checkEquals(cypher(graph,relnum.query3.1)$c,285)
  
  relnum.query3.2 = "match (a)-[r:IS_AVAILABLE_FOR]->(b)<--(e:LegalEntity)<--(c:Client {id:'c2'}) return count(r) as c"
  checkEquals(cypher(graph,relnum.query3.2)$c,0)
  
  relnum.query4 = "match (a)-[r:POSSESSES]->(b) return count(r) as c"
  checkEquals(cypher(graph,relnum.query4)$c,75)
  
  relnum.query5 = "match (a)-[r:ACCESSES]->(b) return count(r) as c"
  checkEquals(cypher(graph,relnum.query5)$c,32)
  
  relnum.query6 = "match (a)-[r:HOLDS]->(b) return count(r) as c"
  checkEquals(cypher(graph,relnum.query6)$c,75)
  
  relnum.query7 = "match (a)-[r:MANAGES]->(b) return count(r) as c"
  checkEquals(cypher(graph,relnum.query7)$c,16)
}

test.path.num = function(){
  pathnum.query1 = "MATCH (as:Asset)-[i:IS_IN]->()-[r:IS_ELIGIBLE_UNDER]->(a{id:'a1'}) WHERE as.type = 'CASH' RETURN count(i) as c"
  checkEquals(cypher(graph,pathnum.query1)$c,8)
  
  pathnum.query2 = "MATCH (as:Asset)-[i:IS_IN]->()-[r:IS_ELIGIBLE_UNDER]->(a{id:'a1'}) WHERE as.type='EQUITY' RETURN count(i) as c"
  checkEquals(cypher(graph,pathnum.query2)$c,6)
  
  pathnum.query3 = "MATCH (as:Asset)-[i:IS_IN]->()-[r:IS_ELIGIBLE_UNDER]->(a{id:'a1'}) WHERE as.type IN ['TBILL','BILL','TNOTE','NOTE','TBOND','BOND'] RETURN count(i) as c"
  checkEquals(cypher(graph,pathnum.query3)$c,23)
  
  pathnum.query4 = "MATCH (as:Asset)-[i:IS_IN]->()-[r:IS_ELIGIBLE_UNDER]->(a{id:'a1'}) WHERE as.ACUOCategory IN ['MM Instruments','Sovereign Bonds'] RETURN count(i) as c"
  checkEquals(cypher(graph,pathnum.query3)$c,23)
  
}


test.rel.type = function(){
  
  rel.query1 = "match (ac:AssetCategory)-[r]->(ag:Agreement {id:'a1'}) 
  where ac.name='US-TBILL' and ac.currency='USD' and ac.maturityLb=0 and ac.maturityUp=1
  return type(r) as rel1"
  checkEquals(cypher(graph,rel.query1)$rel1, 'IS_ELIGIBLE_UNDER')
  
  rel.query2 = "match (ac:AssetCategory)-[r]->(ag:Agreement {id:'a1'}) 
  where ac.name='US-EQUITY-S&P500' and ac.currency='USD' and ac.ticker='JPM'
  return type(r) as rel2"
  checkEquals(cypher(graph,rel.query2)$rel2, 'IS_ELIGIBLE_UNDER')
  
  rel.query3 = "match (ac:AssetCategory)-[r]->(ag:Agreement {id:'a2'}) 
  where ac.name='US-EQUITY-S&P500' and ac.currency='USD' and ac.ticker='APPL'
  return type(r) as rel3"
  checkEquals(cypher(graph,rel.query3)$rel3, NULL)  
  
  rel.query4 = "match (a:Asset)-[r]->(ac:AssetCategory)-->(ag:Agreement {id:'a1'}) where a.id='SG3260987684' return type(r) as rel4"
  checkEquals(cypher(graph,rel.query4)$rel4, 'IS_IN')
  
  rel.query5 = "match (a:Asset)-[r]->(ac:AssetCategory)-->(ag:Agreement {id:'a2'}) where a.id='DE0001137461' return type(r) as rel5"
  checkEquals(cypher(graph,rel.query5)$rel5, NULL)
  
  rel.query6 = "match (c:Client {id:'c1'})-[r]->(a:Asset)  where a.id='GB00BYXK6398'   return type(r) as rel6"
  checkEquals(cypher(graph,rel.query6)$rel6, 'POSSESSES')
  
  rel.query7 = "match (e:LegalEntity {id:'e1'})-[r]->(a:Account {id:'acc1'}) return type(r) as rel7"
  checkEquals(cypher(graph,rel.query7)$rel7, 'HAS')
  
  rel.query8 = "match (acc:Account {id:'acc2'})-[r]->(ca:CustodianAccount)  where ca.id='custac1'  return type(r) as rel8"
  checkEquals(cypher(graph,rel.query8)$rel8, 'ACCESSES')
  
  rel.query9 = "match (acc:Account {id:'acc3'})-[r]->(ca:CustodianAccount)  where ca.id='custac2'   return type(r) as rel9"
  checkEquals(cypher(graph,rel.query9)$rel9, NULL)
  
  rel.query10 = "match (a:Asset)-[r]->(ag:Agreement {id:'a8'})  where UPPER(a.type)='GOLD'   return type(r) as rel10"
  checkEquals(cypher(graph,rel.query10)$rel10, NULL)
  
  rel.query11 = "match (a:Asset)-[r]->(ag:Agreement {id:'a8'})  where UPPER(a.ticker)='JPM'   return type(r) as rel11"
  checkEquals(cypher(graph,rel.query11)$rel11, NULL)
  
  rel.query12 = "match (ca:CustodianAccount {id:'custac1'})-[r]->(a:Asset)  where a.id='DE0001104636'   return type(r) as rel12"
  checkEquals(cypher(graph,rel.query12)$rel12, 'HOLDS')
  
  rel.query13 = "match (ca:CustodianAccount {id:'custac3'})-[r]->(a:Asset)  where a.id='HK0000191137'   return type(r) as rel13"
  checkEquals(cypher(graph,rel.query13)$rel13, NULL)
  
  rel.query14 = "match (c:Custodian {id:'cust1'})-[r]->(ca:CustodianAccount {id:'custac1'})   return type(r) as rel14"
  checkEquals(cypher(graph,rel.query14)$rel14, 'MANAGES')
  
  rel.query15 = "match (c:Custodian {id:'cust1'})-[r]->(ca:CustodianAccount {id:'custac4'})   return type(r) as rel15"
  checkEquals(cypher(graph,rel.query15)$rel15, 'MANAGES')
  
  rel.query16 = "match (c:Custodian {id:'cust2'})-[r]->(ca:CustodianAccount {id:'custac3'})   return type(r) as rel16"
  checkEquals(cypher(graph,rel.query16)$rel16, NULL)
}

# I want to test whether the nodes I created have the appropriate properties:

test.node.prop = function(){
  prop.query1 = "match (a:Asset) where a.id='US46625H1005' return a.ticker as t"
  checkEquals(cypher(graph,prop.query1)$t, 'JPM')  
  
  prop.query2 = "match (a:Asset) where a.id='US46625H1005' return a.currency as q"
  checkEquals(cypher(graph,prop.query2)$q, 'USD')  
  
  prop.query3 = "match (a:Asset) where a.id='US912796HW25' return a.issueDate as i"
  checkEquals(cypher(graph,prop.query3)$i, '12/10/2015')
  
  prop.query4 = "match (a:Asset) where a.id='US912796HW25' return a.maturityDate as m"
  checkEquals(cypher(graph,prop.query4)$m, '06/09/2016')
  
  prop.query5 = "match (a:Asset) where a.id='US912796JE09' return a.type as t"
  checkEquals(cypher(graph,prop.query5)$t, 'TBILL')
  
  prop.query6 = "match (a:Asset) where a.id='US912796JE09' return a.timeToMaturityYears as t"
  checkEquals(round(cypher(graph,prop.query6)$t,1), 0.2)
  
  prop.query7 = "match (a:Asset) where a.id='GBP' and a.type='CASH' return a.name as n"
  checkEquals(cypher(graph,prop.query7)$n, 'British Pound')
  
  prop.query8 = "match (c:Custodian) where c.id='cust1' return c.name as n"
  checkEquals(cypher(graph,prop.query8)$n, 'custodian1')
  
  prop.query9 = "match (c:CustodianAccount) where c.id='custac1' return c.name as n"
  checkEquals(cypher(graph,prop.query9)$n, 'custac1')
  
  prop.query10 = "match (c:CustodianAccount) where c.id='custac2' return c.region as n"
  checkEquals(cypher(graph,prop.query10)$n, 'region101')
  
  prop.query11 = "match (c:CustodianAccount) where c.id='custac8' return c.region as n"
  checkEquals(cypher(graph,prop.query11)$n, 'region103')
  
}


# I want to test whether the relationships I created have the appropriate properties:

test.rel.prop = function(){ 
  prop.query1.1 = "match (c:Client {id:'c1'})-[p:POSSESSES]->(a:Asset) where a.id='US0970231058' return all(x in collect(p) where exists(x.quantities)) as q"
  checkEquals(cypher(graph,prop.query1.1)$q, TRUE)
  
  prop.query1.2 = "match (c:Client {id:'c1'})-[p:POSSESSES]->(a:Asset) where a.id='GB0002374006' return all(x in collect(p) where exists(x.availableQuantities)) as q"
  checkEquals(cypher(graph,prop.query1.2)$q, TRUE)
  
  prop.query1.3 = "match (c:Client {id:'c1'})-[p:POSSESSES]->(a:Asset) where a.id='SG1V61937297' return all(x in collect(p) where exists(x.opptCost)) as q"
  checkEquals(cypher(graph,prop.query1.3)$q, TRUE)
  
  prop.query1.4 = "match (c:Client {id:'c1'})-[p:POSSESSES]->(a:Asset) where a.id='US4592001014' return all(x in collect(p) where exists(x.internalCost)) as q"
  checkEquals(cypher(graph,prop.query1.4)$q, TRUE)
  
  prop.query2 = "match (c:Client {id:'c2'})-[p:POSSESSES]->(a:Asset) where a.id='US912796HW25' return all(x in collect(p) where exists(x.pledgedQuantities)) as q"
  checkEquals(cypher(graph,prop.query2)$q, TRUE)
  
  #  prop.query3 = "match (ac:AssetCategory)-[is:IS_ELIGIBLE_UNDER]->(a:Agreement {id:'a1'}) where ac.currency='GBP' and ac.type='Cash' return is.haircut as h"
  #  checkEquals(cypher(graph,prop.query3)$h, 0)
  
  #  prop.query4 = "match (ac:AssetCategory)-[is:IS_ELIGIBLE_UNDER]->(a:Agreement {id:'a1'}) where ac.ticker='JPM' return is.FXHaircut as h"
  #  checkEquals(cypher(graph,prop.query4)$h, 0)
  
  #  prop.query5 = "match (c:CustodianAccount {id:'custac5'})-[ac:HOLDS]->(a:Asset {id:'USD'}) return ac.quantities as q"
  #  checkEquals(cypher(graph,prop.query5)$q, 20000000)
  
  prop.query6 = "match (c:CustodianAccount {id:'custac4'})-[ac:HOLDS]->(a:Asset {id:'JPY'}) return ac.businessTimeFrom as t"
  checkEquals(cypher(graph,prop.query6)$t, '09:07')
  
  prop.query7 = "match (c:CustodianAccount {id:'custac5'})-[ac:HOLDS]->(a:Asset {id:'CAD'}) return ac.businessTimeTo as t"
  checkEquals(cypher(graph,prop.query7)$t, '21:14')
  
  prop.query8 = "match (e:LegalEntity {id:'e1'})-[s:SIGNS]->(ag:Agreement {id:'a1'}) return s.recipientAddress as add"
  checkEquals(cypher(graph,prop.query8)$add, 'address1')
  
  prop.query9 = "match (e:LegalEntity {id:'e5'})-[s:SIGNS]->(ag:Agreement {id:'a10'}) return s.recipientRegion as r"
  checkEquals(cypher(graph,prop.query9)$r, 'region10')  
  
  prop.query10 = "match (e:LegalEntity {id:'e2'})-[s:SIGNS]->(ag:Agreement {id:'a13'}) return s.businessTimeFrom as t"
  checkEquals(cypher(graph,prop.query10)$t, '08:12')  
  
  prop.query11 = "match (e:LegalEntity {id:'e3'})-[s:SIGNS]->(ag:Agreement {id:'a55'}) return s.businessTimeTo as t"
  checkEquals(cypher(graph,prop.query11)$t, '18:54')
  
  prop.query12 = "match (e:LegalEntity {id:'e2'})-[s:SIGNS]->(ag:Agreement {id:'a33'}) return s.recipientId as r"
  checkEquals(cypher(graph,prop.query12)$r, 'recp33')  
  
  
}




