library(RNeo4j)
library(RUnit)

# I want to test whether the correct amount of nodes was created:

test.numnode = function() {
  numnodequery = "MATCH (n) return count(distinct(n)) AS c"
  checkEquals(cypher(buildDataBase(), numnodequery)$c, 109)
}

# I want to test whether the correct amount of relationships was created:

test.numrel = function() {
  numnodequery = "MATCH (m)-[r]->(n) return count(distinct(r)) AS c"
  checkEquals(cypher(buildDataBase(), numnodequery)$c, 251)
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
  relquery5 = "MATCH (c:Client {id:'c2'})-[r]->(a:Agreement {id:'a23'}) return type(r) as rel5"
  checkEquals(cypher(buildDataBase(), relquery5)$rel5, 'DELIVERS_MARGIN_ACC_TO')
  relquery6 = "MATCH (c:Client {id:'c2'})-[r]->(a:Agreement {id:'a11'}) return type(r) as rel6"
  checkEquals(cypher(buildDataBase(), relquery6)$rel6, NULL)
  relquery7 = "MATCH (acc:Account {id:'acc10'})-[r]->(t:IRS {id:'irsft5'}) return type(r) as rel7"
  checkEquals(cypher(buildDataBase(), relquery7)$rel7, 'POSITIONS_ON')
  relquery8 = "MATCH (acc:Account {id:'acc39'})-[r]->(t:OPT {id:'optv1'}) return type(r) as rel8"
  checkEquals(cypher(buildDataBase(), relquery8)$rel8, NULL)
  relquery9 = "MATCH (e:LegalEntity {id:'e1'})-[r]->(a:Agreement {id:'a1'}) return type(r) as rel9"
  checkEquals(cypher(buildDataBase(), relquery9)$rel9, 'SIGNS')
  relquery10 = "MATCH (e:LegalEntity {id:'e2'})-[r]->(a:Agreement {id:'a4'}) return type(r) as rel10"
  checkEquals(cypher(buildDataBase(), relquery10)$rel10, NULL)
  relquery9 = "MATCH (e:LegalEntity {id:'e1'})-[r]->(a:Agreement {id:'a1'}) return type(r) as rel9"
  checkEquals(cypher(buildDataBase(), relquery9)$rel9, 'SIGNS')
  relquery10 = "MATCH (e:LegalEntity {id:'e2'})-[r]->(a:Agreement {id:'a4'}) return type(r) as rel10"
  checkEquals(cypher(buildDataBase(), relquery10)$rel10, NULL)
  relquery11 = "MATCH (e:LegalEntity {id:'e5'})-[r]->(acc:Account {id:'acc10'}) return type(r) as rel11"
  checkEquals(cypher(buildDataBase(), relquery11)$rel11, 'HAS')
  relquery12 = "MATCH (e:LegalEntity {id:'e2'})-[r]->(acc:Account {id:'acc7'}) return type(r) as rel12"
  checkEquals(cypher(buildDataBase(), relquery12)$rel12, NULL)
}

# I want to test whether I can find a trade with a client ID and a trade ID, and if there is an error when the client's ID is not related to the trade:

test.id = function() {
  idquery1 = "MATCH (:Client {id:'c2'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'irsvt5'}) return t.id as a"
  checkEquals(cypher(buildDataBase(), idquery1)$a, 'irsvt5')
  idquery2 = "MATCH (:Client {id:'c1'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'cdst2'}) return t.id as a"
  checkEquals(cypher(buildDataBase(), idquery2)$a, 'cdst2')
  idquery4 = "MATCH (:Client {id:'c2'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'ndft4'}) return t.id as d"
  checkEquals(cypher(buildDataBase(), idquery4)$d, 'ndft4')
  idquery5 = "MATCH (:Client {id:'c1'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'fxsi1'}) return t.id as e"
  checkEquals(cypher(buildDataBase(), idquery5)$e, 'fxsi1')
  idquery6 = "MATCH (:Client {id:'c1'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'fxsw2'}) return t.id as f"
  checkEquals(cypher(buildDataBase(), idquery6)$f, 'fxsw2')
  idquery7 = "MATCH (:Client {id:'c1'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'optv3'}) return t.id as g"
  checkEquals(cypher(buildDataBase(), idquery7)$g, 'optv3')
  idquery8 = "MATCH (:Client {id:'c2'})-[:MANAGES]->(:LegalEntity)-[:HAS]->(:Account)-[:POSITIONS_ON]->(t {id:'optb3'}) return t.id as h"
  checkEquals(cypher(buildDataBase(), idquery8)$h, 'optb3')
}
