library(RNeo4j)
library(RUnit)

# I want to test whether the correct amount of nodes was created:

test.numnode = function() {
	numnodequery = "MATCH (n) return count(distinct(n)) AS c"
	checkEquals(cypher(buildDataBase(), numnodequery)$c, 36)
}

# I want to test whether the correct amount of relationships was created:

test.numrel = function() {
  numnodequery = "MATCH (m)-[r]->(n) return count(distinct(r)) AS c"
  checkEquals(cypher(buildDataBase(), numnodequery)$c, 64)
}

# I want to test whether the relationships I created are correct:

test.rel = function() {
  relquery1 = "MATCH (c:Client {id:'c1'})-[r]->(e:LegalEntity {id:'e1'}) return type(r) as rel1"
  checkEquals(cypher(buildDataBase(), relquery1)$rel1, 'MANAGES')
  relquery2 = "MATCH (c:Client {id:'c1'})-[r]->(e:LegalEntity {id:'e5'}) return type(r) as rel2"
  checkEquals(cypher(buildDataBase(), relquery2)$rel2, NULL)
  relquery3 = "MATCH (t:IRS {id:'irsvt1'})-[r]->(a:Agreement {id:'a1'}) return type(r) as rel3"
  checkEquals(cypher(buildDataBase(), relquery3)$rel3, 'FOLLOWS')
  relquery4 = "MATCH (t:IRS {id:'irsft1'})-[r]->(a:Agreement {id:'a5'}) return type(r) as rel4"
  checkEquals(cypher(buildDataBase(), relquery4)$rel4, NULL)
  relquery5 = "MATCH (c:Client {id:'c2'})-[r]->(a:Agreement {id:'a3'}) return type(r) as rel5"
  checkEquals(cypher(buildDataBase(), relquery5)$rel5, 'DELIVERS_MARGIN_ACC_TO')
  relquery6 = "MATCH (c:Client {id:'c2'})-[r]->(a:Agreement {id:'a1'}) return type(r) as rel6"
  checkEquals(cypher(buildDataBase(), relquery6)$rel6, NULL)
  relquery7 = "MATCH (e:LegalEntity {id:'e5'})-[r]->(t:IRS {id:'irsft5'}) return type(r) as rel7"
  checkEquals(cypher(buildDataBase(), relquery7)$rel7, 'POSITIONS_ON')
  relquery8 = "MATCH (e:LegalEntity {id:'e2'})-[r]->(t:IRS {id:'irsvt4'}) return type(r) as rel8"
  checkEquals(cypher(buildDataBase(), relquery8)$rel8, NULL)
  relquery9 = "MATCH (e:LegalEntity {id:'e1'})-[r]->(a:Agreement {id:'a1'}) return type(r) as rel9"
  checkEquals(cypher(buildDataBase(), relquery9)$rel9, 'SIGNS')
  relquery10 = "MATCH (e:LegalEntity {id:'e2'})-[r]->(a:Agreement {id:'a4'}) return type(r) as rel10"
  checkEquals(cypher(buildDataBase(), relquery10)$rel10, NULL)
  relquery11 = "MATCH (e:LegalEntity {id:'e3'})-[r]->(t:CDS {id:'cdst3'}) return type(r) as rel11"
  checkEquals(cypher(buildDataBase(), relquery11)$rel11, 'POSITIONS_ON')
  relquery12 = "MATCH (t:CDS {id:'cdst4'})-[r]->(a:Agreement {id:'a3'}) return type(r) as rel12"
  checkEquals(cypher(buildDataBase(), relquery12)$rel12, 'FOLLOWS')
  relquery13 = "MATCH (e:LegalEntity {id:'e4'})-[r]->(t:NDF {id:'ndft4'}) return type(r) as rel13"
  checkEquals(cypher(buildDataBase(), relquery13)$rel13, 'POSITIONS_ON')
  relquery14 = "MATCH (t:NDF {id:'ndft5'})-[r]->(a:Agreement {id:'a4'}) return type(r) as rel14"
  checkEquals(cypher(buildDataBase(), relquery14)$rel14, 'FOLLOWS')
  relquery15 = "MATCH (e:LegalEntity {id:'e5'})-[r]->(t:FXSI {id:'fxsi5'}) return type(r) as rel15"
  checkEquals(cypher(buildDataBase(), relquery15)$rel15, 'POSITIONS_ON')
  relquery16 = "MATCH (t:FXSI {id:'fxsi1'})-[r]->(a:Agreement {id:'a1'}) return type(r) as rel16"
  checkEquals(cypher(buildDataBase(), relquery16)$rel16, 'FOLLOWS')
}

# I want to test whether I can find a trade with a client ID and a trade ID, and if there is an error when the client's ID is not related to the trade:

test.id = function() {
  idquery1 = "MATCH (:Client {id:'c1'})-[:MANAGES]->(:LegalEntity)-[:POSITIONS_ON]->(t {id:'irsvt1'}) return t.id as a"
  checkEquals(cypher(buildDataBase(), idquery1)$a, 'irsvt1')
  idquery2 = "MATCH (:Client {id:'c1'})-[:MANAGES]->(:LegalEntity)-[:POSITIONS_ON]->(t {id:'cdst2'}) return t.id as a"
  checkEquals(cypher(buildDataBase(), idquery2)$a, 'cdst2')
  idquery3 = "MATCH (:Client {id:'c2'})-[:MANAGES]->(:LegalEntity)-[:POSITIONS_ON]->(t {id:'irsvt1'}) return t.id as b"
  checkEquals(cypher(buildDataBase(), idquery3)$b, NULL)
  idquery4 = "MATCH (:Client {id:'c2'})-[:MANAGES]->(:LegalEntity)-[:POSITIONS_ON]->(t {id:'ndft3'}) return t.id as d"
  checkEquals(cypher(buildDataBase(), idquery4)$d, 'ndft3')
  idquery5 = "MATCH (:Client {id:'c1'})-[:MANAGES]->(:LegalEntity)-[:POSITIONS_ON]->(t {id:'fxsi1'}) return t.id as e"
  checkEquals(cypher(buildDataBase(), idquery4)$e, 'fxsi1')
}

# I want to test that my IRS have the correct properties:

test.propirs = function() {
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

# I want to check that my CDS have the correct properties:

test.propcds = function() {
  propquery1 = "MATCH (t:CDS {id:'cdst1'}) return t.date as a"
  checkEquals(cypher(buildDataBase(), propquery1)$a, '29/07/15')
  propquery2 = "MATCH (t:CDS {id:'cdst2'}) return t.maturity as b"
  checkEquals(cypher(buildDataBase(), propquery2)$b, '16/12/20')
  propquery3 = "MATCH (t:CDS {id:'cdst3'}) return t.buySellProtection as c"
  checkEquals(cypher(buildDataBase(), propquery3)$c, 'B')
  propquery4 = "MATCH (t:CDS {id:'cdst4'}) return t.currency as d"
  checkEquals(cypher(buildDataBase(), propquery4)$d, 'GBP')
  propquery5 = "MATCH (t:CDS {id:'cdst5'}) return t.underlyingEntity as e"
  checkEquals(cypher(buildDataBase(), propquery5)$e, 'Caterpillar Inc')
  propquery6 = "MATCH (t:CDS {id:'cdst1'}) return t.underlyingAssetId as f"
  checkEquals(cypher(buildDataBase(), propquery6)$f, 'US149123BM26')
  propquery7 = "MATCH (t:CDS {id:'cdst2'}) return t.notional as g"
  checkEquals(cypher(buildDataBase(), propquery7)$g, 10000001)
  propquery8 = "MATCH (t:CDS {id:'cdst3'}) return t.factor as h"
  checkEquals(cypher(buildDataBase(), propquery8)$h, 0.75)
  propquery9 = "MATCH (t:CDS {id:'cdst4'}) return t.couponRate as i"
  checkEquals(cypher(buildDataBase(), propquery9)$i, 6)
}

test.propndf = function() {
  propquery1 = "MATCH (t:NDF {id:'ndft1'}) return t.date as a"
  checkEquals(cypher(buildDataBase(), propquery1)$a, '03/05/14')
  propquery2 = "MATCH (t:NDF {id:'ndft2'}) return t.buySell as b"
  checkEquals(cypher(buildDataBase(), propquery2)$b, 'B')
  propquery3 = "MATCH (t:NDF {id:'ndft3'}) return t.currencySettlement as c"
  checkEquals(cypher(buildDataBase(), propquery3)$c, 'USD')
  propquery4 = "MATCH (t:NDF {id:'ndft4'}) return t.currencyTrade as d"
  checkEquals(cypher(buildDataBase(), propquery4)$d, 'KRW')
  propquery5 = "MATCH (t:NDF {id:'ndft5'}) return t.settlementCurrencyNotional as e"
  checkEquals(cypher(buildDataBase(), propquery5)$e, 10004)
  propquery6 = "MATCH (t:NDF {id:'ndft1'}) return t.agreedFXRate as f"
  checkEquals(cypher(buildDataBase(), propquery6)$f, 6.7)
  propquery7 = "MATCH (t:NDF {id:'ndft2'}) return t.fixingDate as g"
  checkEquals(cypher(buildDataBase(), propquery7)$g, '04/05/15')
  propquery8 = "MATCH (t:NDF {id:'ndft3'}) return t.index as h"
  checkEquals(cypher(buildDataBase(), propquery8)$h, 'i3')
}

test.propfxsi = function() {
  propquery1 = "MATCH (t:FXSI {id:'fxsi1'}) return t.date as a"
  checkEquals(cypher(buildDataBase(), propquery1)$a, '28/03/13')
  propquery2 = "MATCH (t:FXSI {id:'fxsi2'}) return t.baseCurrency as b"
  checkEquals(cypher(buildDataBase(), propquery2)$b, 'EUR')
  propquery3 = "MATCH (t:FXSI {id:'fxsi3'}) return t.counterCurrency as c"
  checkEquals(cypher(buildDataBase(), propquery3)$c, 'GBP')
  propquery4 = "MATCH (t:FXSI {id:'fxsi4'}) return t.baseCurrencyAmount as d"
  checkEquals(cypher(buildDataBase(), propquery4)$d, 1000)
  propquery5 = "MATCH (t:FXSI {id:'fxsi5'}) return t.counterCurrencyAmount as e"
  checkEquals(cypher(buildDataBase(), propquery5)$e, 149)
  propquery6 = "MATCH (t:FXSI {id:'fxsi1'}) return t.paymentDate as f"
  checkEquals(cypher(buildDataBase(), propquery6)$f, "22/05/13")
}











