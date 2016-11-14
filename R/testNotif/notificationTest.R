library(RNeo4j)
library(RUnit)

# I want to test whether the correct time is return in scenario 1 and 2, as well as NA in a margin call that is not 24 hours from now.

test.notif = function() {
  # I first want to modify the database in order to have margin calls coming today
  whoopsTooLate = format(as.POSIXlt(Sys.time(), tz="GMT") - 600, "%D %R") # Ten minutes ago, format 'dd/mm/yy HH:mm'
  soon = format(as.POSIXlt(Sys.time(), tz="GMT") + 36000, "%D %R")  # Ten hours from now, same format
  notSoSoon = format(as.POSIXlt(Sys.time(), tz="GMT") + 90000, "%D %R") # Twenty-five hours from now, same format
  query1 = paste("MATCH (m:MarginCall) WHERE m.id = 'mc9' SET m.notificationTime =", whoopsTooLate, sep='')
  query2 = paste("MATCH (m:MarginCall) WHERE m.id = 'mc10' SET m.notificationTime =", soon, sep='')
  query3 = paste("MATCH (m:MarginCall) WHERE m.id = 'mc11' SET m.notificationTime =", notSoSoon, sep='')
  cypher(graph, query1)  # mc9-mc11 were created for this specific occasion. Changing them won't corrupt the graph.
  cypher(graph, query2)
  cypher(graph, query3)
  scen1 = "MATCH (m:MarginCall {id:'mc9'}) RETURN m.notificationTime as t" 
  checkEquals(cypher(graph, scen1)$t, NA)
  scen2 = "MATCH (m:MarginCall {id:'mc10'}) RETURN m.notificationTime as t" 
  checkEquals(cypher(graph, scen1)$t, soon)
  scen3 = "MATCH (m:MarginCall {id:'mc11'}) RETURN m.notificationTime as t"
  checkEquals(cypher(graph, scen3)$t, NA)
}
