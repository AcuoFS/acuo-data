library(RNeo4j)
library(RUnit)

# I want to test whether the correct time is return in scenario 1 and 2, as well as NA in a margin call that is not 24 hours from now.

test.notif = function() {
  scen1 = "MATCH (m:MarginCall {id:mc9}) RETURN m.notificationTime as t"
  checkEquals(query(graph, scen1)$t, '10/11/16 12:00')
  scen2 = "MATCH (m:MarginCall {id:mc10}) RETURN m.notificationTime as t"
  checkEquals(query(graph, scen2)$t, '10/11/16 12:00')
  shna = "MATCH (m:MarginCall {id:mc1}) RETURN m.notificationTime as t"
  checkEquals(query(graph, shna)$t, NA)
}
