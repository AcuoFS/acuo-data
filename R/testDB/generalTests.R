library(RNeo4j)
library(RUnit)

# I want to test whether the relationships I created are correct:

test.rel = function() {
  relquery1 = "MATCH (c:Client {id:'c1'})-[r]->(e:LegalEntity {id:'e1'}) return type(r) as rel1"
  checkEquals(cypher(graph, relquery1)$rel1, 'MANAGES')
  relquery2 = "MATCH (c:Client {id:'c1'})-[r]->(e:LegalEntity {id:'e5'}) return type(r) as rel2"
  checkEquals(cypher(graph, relquery2)$rel2, NULL)
  relquery3 = "MATCH (t:IRS {id:'irsvt1'})-[r]->(a:Agreement {id:'a1'}) return type(r) as rel3"
  checkEquals(cypher(graph, relquery3)$rel3, 'FOLLOWS')
  relquery4 = "MATCH (t:IRS {id:'irsft1'})-[r]->(a:Agreement {id:'a5'}) return type(r) as rel4"
  checkEquals(cypher(graph, relquery4)$rel4, NULL)
  relquery5 = "MATCH (c:Client {id:'c2'})-[r]->(a:Agreement {id:'a28'}) return type(r) as rel5"
  checkEquals(cypher(graph, relquery5)$rel5, 'DELIVERS_MARGIN_ACC_TO')
  relquery6 = "MATCH (c:Client {id:'c2'})-[r]->(a:Agreement {id:'a11'}) return type(r) as rel6"
  checkEquals(cypher(graph, relquery6)$rel6, NULL)
  relquery7 = "MATCH (acc:Account {id:'acc10'})-[r]->(t:IRS {id:'irsft5'}) return type(r) as rel7"
  checkEquals(cypher(graph, relquery7)$rel7, 'POSITIONS_ON')
  relquery8 = "MATCH (acc:Account {id:'acc39'})-[r]->(t:OPT {id:'optv1'}) return type(r) as rel8"
  checkEquals(cypher(graph, relquery8)$rel8, NULL)
  relquery9 = "MATCH (e:LegalEntity {id:'e1'})-[r]->(a:Agreement {id:'a1'}) return type(r) as rel9"
  checkEquals(cypher(graph, relquery9)$rel9, 'SIGNS')
  relquery10 = "MATCH (e:LegalEntity {id:'e1'})-[r]->(a:Agreement {id:'a4'}) return type(r) as rel10"
  checkEquals(cypher(graph, relquery10)$rel10, NULL)
  relquery11 = "MATCH (e:LegalEntity {id:'e5'})-[r]->(acc:Account {id:'acc10'}) return type(r) as rel11"
  checkEquals(cypher(graph, relquery11)$rel11, 'HAS')
  relquery12 = "MATCH (e:LegalEntity {id:'e2'})-[r]->(acc:Account {id:'acc7'}) return type(r) as rel12"
  checkEquals(cypher(graph, relquery12)$rel12, NULL)
}

# I want to test whether I can find a trade with a client ID and a trade ID, and if there is an error when the client's ID is not related to the trade:

test.id = function() {
  idquery1 = "MATCH (:Client {id:'c1'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'irsvt5'}) return t.id as a"
  checkEquals(cypher(graph, idquery1)$a, 'irsvt5')
  idquery2 = "MATCH (:Client {id:'c1'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'cdst2'}) return t.id as a"
  checkEquals(cypher(graph, idquery2)$a, 'cdst2')
  idquery4 = "MATCH (:Client {id:'c2'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'ndft4'}) return t.id as d"
  checkEquals(cypher(graph, idquery4)$d, 'ndft4')
  idquery5 = "MATCH (:Client {id:'c1'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'fxsi1'}) return t.id as e"
  checkEquals(cypher(graph, idquery5)$e, 'fxsi1')
  idquery6 = "MATCH (:Client {id:'c1'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'fxsw2'}) return t.id as f"
  checkEquals(cypher(graph, idquery6)$f, 'fxsw2')
  idquery7 = "MATCH (:Client {id:'c1'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'optv3'}) return t.id as g"
  checkEquals(cypher(graph, idquery7)$g, 'optv3')
  idquery8 = "MATCH (:Client {id:'c2'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'optb3'}) return t.id as h"
  checkEquals(cypher(graph, idquery8)$h, 'optb3')
  idquery9 = "MATCH (:Client {id:'c1'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'fra4'}) return t.id as i"
  checkEquals(cypher(graph, idquery9)$i, 'fra4')
  idquery10 = "MATCH (:Client {id:'c2'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'zcs5'}) return t.id as j"
  checkEquals(cypher(graph, idquery10)$j, 'zcs5')
  idquery11 = "MATCH (:Client {id:'c1'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'swopt1'}) return t.id as k"
  checkEquals(cypher(graph, idquery11)$k, 'swopt1')
}

# I want to test whether Entities, Agreements and the SIGNS relationship have the correct properties

test.agree = function() {
  query1 = "MATCH (e:LegalEntity {id:'e1'}) RETURN e.holidayZone as r"
  checkEquals(cypher(graph, query1)$r, 'London')
  query2 = "MATCH (e:LegalEntity {id:'e7'}) RETURN e.holidayZone as r"
  checkEquals(cypher(graph, query2)$r, 'Singapore')
  query3 = "MATCH (:LegalEntity{id:'e1'})-[s:SIGNS]->(:Agreement {id:'a2'}) RETURN s.MTA as r"
  checkEquals(cypher(graph, query3)$r, 2500)
  query4 = "MATCH (:LegalEntity{id:'e7'})-[s:SIGNS]->(:Agreement {id:'a3'}) RETURN s.MTA as r"
  checkEquals(cypher(graph, query4)$r, 2500)
  query5 = "MATCH (:LegalEntity{id:'e3'})-[s:SIGNS]->(:Agreement {id:'a6'}) RETURN s.initialMarginBalance as r"
  checkEquals(cypher(graph, query5)$r, 1505)
  query6 = "MATCH (:LegalEntity{id:'e9'})-[s:SIGNS]->(:Agreement {id:'a7'}) RETURN s.initialMarginBalance as r"
  checkEquals(cypher(graph, query6)$r, 1406)
  query7 = "MATCH (:LegalEntity{id:'e5'})-[s:SIGNS]->(:Agreement {id:'a10'}) RETURN s.variationMarginBalance as r"
  checkEquals(cypher(graph, query7)$r, 1050)
  query8 = "MATCH (:LegalEntity{id:'e7'})-[s:SIGNS]->(:Agreement {id:'a11'}) RETURN s.variationMarginBalance as r"
  checkEquals(cypher(graph, query8)$r, -1000)
}






