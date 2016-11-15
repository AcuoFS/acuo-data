library(RNeo4j)
library(RUnit)

# I want to test whether the correct time is return in scenario 1 and 2, as well as NA in a margin call that is not 24 hours from now.

test.interCutoff = function() {

  query = readLoad('https://raw.githubusercontent.com/AcuoFS/acuo-data/master/load/internalCutoff.load')
  
  checkEquals(cypher(graph,query,callId='mc1')$time,'18:00')
  checkEquals(cypher(graph,query,callId='mc2')$time,'18:01')
  checkEquals(cypher(graph,query,callId='mc3')$time,'18:02')
  checkEquals(cypher(graph,query,callId='mc10')$time,NULL)
  checkEquals(cypher(graph,query,callId='mc11')$time,NULL)
}
