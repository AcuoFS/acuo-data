library('xlsx')
library('RNeo4j')
#library('igraph')
#library('visNetwork')

# Loading the data

data = read.xlsx2("CCS_v1_0_62_Final_locked.xlsx", sheetIndex=6, startRow=4)

data = data[-1,]
data = data[-1,]

print(unique(data$Product.Type))

# Loading the graph

graph = startGraph("http://neo4j:7474/db/data")
clear(graph)
Y

# Adding constraints of id uniqueness

addConstraint(graph, "Client", "idclient")
addConstraint(graph, "Account", "idaccount")
addConstraint(graph, "CCP", "nameccp")
addConstraint(graph, "FCM", "idfcm")
addConstraint(graph, "Agreement", "idagree")
for (x in unique(data$Product.Type)) {   # Each product type is a separate node type
  if (x != '') {
    print(x)
    addConstraint(graph, x, "idtrade")
  }
}

# Creating nodes and relations from each line. Thanks to the latter constraint, a node is only created if it doesn't already exist.

for (i in 10:15) {
  row = data[i,]
  if (toString(row$Client.Account.ID) != '' & toString(row$USI) != '') {
    client = getOrCreateNode(graph, "Client", idclient=toString(row$Client.Account.LEI), name=toString(row$Client.Account.Legal.Name))
    if (toString(row$Product.Type) == 'IRS') {
      trade = getOrCreateNode(graph, 'IRS', idtrade=toString(row$USI)) 
    }
    if (toString(row$Product.Type) == 'IRS') {
      trade = getOrCreateNode(graph, 'IRS', idtrade=toString(row$USI), ) 
    }
    agreement = getOrCreateNode(graph, "Agreement", idagree=toString(row$UTI))
    traderel = createRel(client, "POSITIONS_ON", trade)
    tradegree = createRel(trade, "FOLLOWS", agreement)
    margin = createRel(client, "DELIVERS_MARGIN_ACCORDING_TO", agreement)
#    clearel = createRel(ccp, "CLEARS", trade)
#    delmarg = createRel(client, "MUST_DELIVER_MARGIN", fcm)
#    transmarg = createRel(fcm, "TRANSMITS_MARGIN", ccp)
#    rm(client, trade, ccp, fcm, traderel, clearel, delmarg, transmarg)
    rm(client, trade, agreement, traderel, tradegree, margin)
  }
}

a = "1234567ABCD8E9FGHJ12"
b = "CCCIRS4306267"

fquery <- function(x, y) {
  z1 = paste("MATCH (:Client {idclient:'", x, "'})-[:POSITIONS_ON]->(t:IRS {idtrade:'", y, "'})", sep='')
  z2 = paste(z1, "return t.idtrade as result", sep = "\n ")
  return(z2)
}

print(cypher(graph, fquery(a,b)))

# Uncomment the rest of the code to visualise the graph as a whole (requires lib igraph and visNetwork).

#query2 = "
#MATCH (c:Client)-[:POSITIONS_ON]->(t:IRS)
#return c.idclient AS from, t.idtrade AS to
#"

#edges = cypher(graph, query2)

#nodes = data.frame(id=unique(c(edges$from, edges$to)))
#nodes$label = nodes$id

#visNetwork(nodes, edges)

