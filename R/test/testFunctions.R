library(RNeo4j)
library(RUnit)

# I want to test whether the correct amount of nodes was created:

test.numnode = function() {
	numnodequery = "MATCH (n) return count(distinct(n)) AS c"
	checkEquals(cypher(buildDataBase(), numnodequery)$c, 21)
}

# I want to test whether the correct amount of relationships was created:

test.numrel = function() {
  numnodequery = "MATCH (m)-[r]->(n) return count(distinct(r)) AS c"
  checkEquals(cypher(buildDataBase(), numnodequery)$c, 34)
}

# I want to test whether the relationships I created are correct:

test.rel = function() {
  relquery1 = "MATCH (c:Client {id:'c1'})-[r]->(e:LegalEntity {id:'e1'}) return type(r) as rel1"
  checkEquals(cypher(buildDataBase(), relquery1)$rel1, 'MANAGES')
  relquery2 = "MATCH (c:Client {id:'c1'})-[r]->(e:LegalEntity {id:'e5'}) return type(r) as rel2"
  checkEquals(cypher(buildDataBase(), relquery2)$rel2, NULL)
  relquery3 = "MATCH (i:IRS {id:'irsvt1'})-[r]->(a:Agreement {id:'a1'}) return type(r) as rel3"
  checkEquals(cypher(buildDataBase(), relquery3)$rel3, 'FOLLOWS')
  relquery4 = "MATCH (i:IRS {id:'irsft1'})-[r]->(a:Agreement {id:'a5'}) return type(r) as rel4"
  checkEquals(cypher(buildDataBase(), relquery4)$rel4, NULL)
  relquery5 = "MATCH (c:Client {id:'c2'})-[r]->(a:Agreement {id:'a3'}) return type(r) as rel5"
  checkEquals(cypher(buildDataBase(), relquery5)$rel5, 'DELIVERS_MARGIN_ACC_TO')
  relquery6 = "MATCH (c:Client {id:'c2'})-[r]->(a:Agreement {id:'a1'}) return type(r) as rel6"
  checkEquals(cypher(buildDataBase(), relquery6)$rel6, NULL)
  relquery7 = "MATCH (e:LegalEntity {id:'e5'})-[r]->(i:IRS {id:'irsft5'}) return type(r) as rel7"
  checkEquals(cypher(buildDataBase(), relquery7)$rel7, 'POSITIONS_ON')
  relquery8 = "MATCH (e:LegalEntity {id:'e2'})-[r]->(i:IRS {id:'irsvt4'}) return type(r) as rel8"
  checkEquals(cypher(buildDataBase(), relquery8)$rel8, NULL)
  relquery9 = "MATCH (e:LegalEntity {id:'e1'})-[r]->(a:Agreement {id:'a1'}) return type(r) as rel9"
  checkEquals(cypher(buildDataBase(), relquery9)$rel9, 'SIGNS')
  relquery10 = "MATCH (e:LegalEntity {id:'e2'})-[r]->(a:Agreement {id:'a4'}) return type(r) as rel10"
  checkEquals(cypher(buildDataBase(), relquery10)$rel10, NULL)
}

# I want to test whether I can find a trade with a client ID and a trade ID, and if there is an error when the client's ID is not related to the trade

test.id = function() {
  idquery1 = "MATCH (:Client {id:'c1'})-[:MANAGES]->(:LegalEntity)-[:POSITIONS_ON]->(t:IRS {id:'irsvt1'}) return t.id as a"
  checkEquals(cypher(buildDataBase(), idquery1)$a, 'irsvt1')
  idquery2 = "MATCH (:Client {id:'c2'})-[:MANAGES]->(:LegalEntity)-[:POSITIONS_ON]->(t:IRS {id:'irsvt1'}) return t.id as b"
  checkEquals(cypher(buildDataBase(), idquery2)$b, NULL)
}

# I want to test that my IRS have the correct properties

test.prop = function() {
  propquery1 = "MATCH (t:IRS {id:'irsvt1'}) return t.date as d"
  checkEquals(cypher(buildDataBase(), propquery1)$d, '29/07/15')
  propquery2 = "MATCH (t:IRS {id:'irsft2'}) return t.maturity as e"
  checkEquals(cypher(buildDataBase(), propquery2)$e, '16/12/20')
  propquery3 = "MATCH (t:IRS {id:'irsvt3'}) return t.legClient as f"
  checkEquals(cypher(buildDataBase(), propquery3)$f, 'Fixed')
  propquery4 = "MATCH (t:IRS {id:'irsvt4'}) return t.notionalReceive as g"
  checkEquals(cypher(buildDataBase(), propquery4)$g, 5000000)
  propquery5 = "MATCH (t:IRS {id:'irsft5'}) return t.notionalPay as h"
  checkEquals(cypher(buildDataBase(), propquery5)$h, -1000000)
  propquery6 = "MATCH (t:IRS {id:'irsft1'}) return t.currencyReceive as i"
  checkEquals(cypher(buildDataBase(), propquery6)$i, 'USD')
  propquery7 = "MATCH (t:IRS {id:'irsvt2'}) return t.currencyPay as j"
  checkEquals(cypher(buildDataBase(), propquery7)$j, 'USD')
  propquery8 = "MATCH (t:IRS {id:'irsvt3'}) return t.fixedRate as k"
  checkEquals(cypher(buildDataBase(), propquery8)$k, 2.5)
  propquery9 = "MATCH (t:IRS {id:'irsvt4'}) return t.indexFloat as l"
  checkEquals(cypher(buildDataBase(), propquery9)$l, 'USD-LIBOR-BBA')
  propquery10 = "MATCH (t:IRS {id:'irsvt5'}) return t.tenorFloat as m"
  checkEquals(cypher(buildDataBase(), propquery10)$m, '3M')
  propquery11 = "MATCH (t:IRS {id:'irsvt1'}) return t.resetFreq as n"
  checkEquals(cypher(buildDataBase(), propquery11)$n, '3M')
  propquery12 = "MATCH (t:IRS {id:'irsvt2'}) return t.payFreqReceive as o"
  checkEquals(cypher(buildDataBase(), propquery12)$o, '6M')
  propquery13 = "MATCH (t:IRS {id:'irsft3'}) return t.payFreqPay as p"
  checkEquals(cypher(buildDataBase(), propquery13)$p, '3M')
  propquery14 = "MATCH (t:IRS {id:'irsft4'}) return t.indexPay as q"
  checkEquals(cypher(buildDataBase(), propquery14)$q, 'USD-LIBOR-BBA')
  propquery15 = "MATCH (t:IRS {id:'irsft5'}) return t.tenorReceive as r"
  checkEquals(cypher(buildDataBase(), propquery15)$r, '3M')
  propquery16 = "MATCH (t:IRS {id:'irsft1'}) return t.resetFreqPay as s"
  checkEquals(cypher(buildDataBase(), propquery16)$s, '3M')
}
