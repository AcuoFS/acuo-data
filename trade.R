library('xlsx')
library('RNeo4j')
library('igraph')
library('visNetwork')

# Loading the data

data = read.xlsx2("CCS v1 0 62_Final_locked.xlsx", sheetIndex=6, startRow=4)

data = data[-1,]
data = data[-1,]

print(unique(data$Product.Type))

# Loading the graph

graph = startGraph("http://localhost:7474/db/data/")
clear(graph)
Y

# Adding constraints of id uniqueness

addConstraint(graph, "Client", "idclient")
addConstraint(graph, "Account", "idaccount")
for (x in unique(data$Product.Type)) {   # Each product type is a separate node type
  if (x != '') {
    print(x)
    addConstraint(graph, x, "idtrade")
  }
}

# Creating nodes and relations from each line. Thanks to the latter constraint, a node is only created if it doesn't already exist.

for (i in 12:15) {
  row = data[i,]
  if (toString(row$Client.Account.ID) != '' & toString(row$USI) != '') {
    client = getOrCreateNode(graph, "Client", idclient=toString(row$Client.Account.ID), name=toString(row$Client.Account.Legal.Name))
    trade = getOrCreateNode(graph, toString(row$Product.Type), idtrade=toString(row$USI))
    rel = createRel(client, "TRADES", trade)
    if (row$Trade.Direction == "B") {
      rel = createRel(client, "BUYS", trade)
    } else if (row$Trade.Direction == "S") {
      rel = createRel(client, "SELLS", trade)
    }
  }
}

a = "IRSCUST8"
b = "CCCIRS4314667"

fquery <- function(x, y) {
  z1 = paste("MATCH (:Client {idclient:'", x, "'})-[:TRADES]->(t:IRS {idtrade:'", y, "'})", sep='')
  z2 = paste(z1, "return t.idtrade as result", sep = "\n ")
  return(z2)
}

print(cypher(graph, fquery(a,b)))

# Uncomment the rest of the code to visualise the graph as a whole (requires lib igraph and visNetwork).

#query2 = "
#MATCH (c:Client)-[:TRADES]->(t:IRS)
#return c.idclient AS from, t.idtrade AS to
#"

#edges = cypher(graph, query2)

#nodes = data.frame(id=unique(c(edges$from, edges$to)))
#nodes$label = nodes$id

#visNetwork(nodes, edges)
