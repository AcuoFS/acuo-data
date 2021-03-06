library(RNeo4j)
 library(RUnit)
 
 # I want to test that my IRS have the correct properties:
 
 test.propirs = function() {
   propquery1 = "MATCH (t:IRS {id:'irsvt1'}) return t.clearingDate as d"
   checkEquals(cypher(graph, propquery1)$d, '29/07/15')
   propquery2 = "MATCH (t:IRS {id:'irsft2'}) return t.maturity as e"
   checkEquals(cypher(graph, propquery2)$e, '16/12/20')
   propquery3 = "MATCH (:IRS {id:'irsvt3'})-[:PAYS]->(l:Leg) return l.notional as f"
   checkEquals(cypher(graph, propquery3)$f, 7500000)
   propquery4 = "MATCH (:IRS {id:'irsvt4'})-[:RECEIVE]->(l:Leg) return l.currency as f"
   checkEquals(cypher(graph, propquery4)$f, 'USD')
   propquery5 = "MATCH (:IRS {id:'irsvt5'})-[:PAYS]->(l:Leg) return l.type as f"
   checkEquals(cypher(graph, propquery5)$f, 'Floating')
   propquery6 = "MATCH (:IRS {id:'irsft1'})-[:RECEIVE]->(l:Leg) return l.index as f"
   checkEquals(cypher(graph, propquery6)$f, 'USD-LIBOR-BBA')
   propquery7 = "MATCH (:IRS {id:'irsft2'})-[:PAYS]->(l:Leg) return l.indexTenor as f"
   checkEquals(cypher(graph, propquery7)$f, '6M')
   propquery8 = "MATCH (:IRS {id:'irsft3'})-[:RECEIVE]->(l:Leg) return l.resetFrequency as f"
   checkEquals(cypher(graph, propquery8)$f, '3M')
   propquery9 = "MATCH (:IRS {id:'irsft4'})-[:PAYS]->(l:Leg) return l.paymentFrequency as f"
   checkEquals(cypher(graph, propquery9)$f, '3M')
   propquery10 = "MATCH (:IRS {id:'irsft5'})-[:RECEIVE]->(l:Leg) return l.payStart as f"
   checkEquals(cypher(graph, propquery10)$f, '08/01/16')
   propquery11 = "MATCH (:IRS {id:'irsvt1'})-[:PAYS]->(l:Leg) return l.payEnd as f"
   checkEquals(cypher(graph, propquery11)$f, '20/09/23')
   propquery12 = "MATCH (:IRS {id:'irsvt2'})-[:RECEIVE]->(l:Leg) return l.businessDayConvention as f"
   checkEquals(cypher(graph, propquery12)$f, 'MODFOLLOWING')
   propquery13 = "MATCH (:IRS {id:'irsvt3'})-[:PAYS]->(l:Leg) return l.refCalendar as f"
   checkEquals(cypher(graph, propquery13)$f, 'NY')
   propquery14 = "MATCH (:IRS {id:'irsvt4'})-[:PAYS]->(l:Leg) return l.fixedRate as f"
   checkEquals(cypher(graph, propquery14)$f, 1.75)
   propquery15 = "MATCH (:IRS {id:'irsvt5'})-[:RECEIVE]->(l:Leg) return l.nextCouponPaymentDate as f"
   checkEquals(cypher(graph, propquery15)$f, '08/01/16')
   propquery16 = "MATCH (:IRS {id:'irsft1'})-[:PAYS]->(l:Leg) return l.dayCount as f"
   checkEquals(cypher(graph, propquery16)$f, 'ACT/360')
 }
 
 ## I want to check that my CDS have the correct properties:
 #
 ##test.propcds = function() {
 ##  propquery1 = "MATCH (t:CDS {id:'cdst1'}) return t.clearingDate as a"
 ##  checkEquals(cypher(graph, propquery1)$a, '29/07/15')
 ##  propquery2 = "MATCH (t:CDS {id:'cdst2'}) return t.maturity as b"
 ##  checkEquals(cypher(graph, propquery2)$b, '16/12/20')
 ##  propquery3 = "MATCH (t:CDS {id:'cdst3'}) return t.buySellProtection as c"
 ##  checkEquals(cypher(graph, propquery3)$c, 'B')
 ##  propquery4 = "MATCH (t:CDS {id:'cdst4'}) return t.currency as d"
 ##  checkEquals(cypher(graph, propquery4)$d, 'GBP')
 ##  propquery5 = "MATCH (t:CDS {id:'cdst5'}) return t.underlyingEntity as e"
 ##  checkEquals(cypher(graph, propquery5)$e, 'Caterpillar Inc')
 ##  propquery6 = "MATCH (t:CDS {id:'cdst1'}) return t.underlyingAssetId as f"
 ##  checkEquals(cypher(graph, propquery6)$f, 'US149123BM26')
 ##  propquery7 = "MATCH (t:CDS {id:'cdst2'}) return t.notional as g"
 ##  checkEquals(cypher(graph, propquery7)$g, 10000001)
 ##  propquery8 = "MATCH (t:CDS {id:'cdst3'}) return t.factor as h"
 ##  checkEquals(cypher(graph, propquery8)$h, 0.75)
 ##  propquery9 = "MATCH (t:CDS {id:'cdst4'}) return t.couponRate as i"
 ##  checkEquals(cypher(graph, propquery9)$i, 0.6)
 ##  propquery10 = "MATCH (t:CDS {id:'cdst5'}) return t.seniority as j"
 ##  checkEquals(cypher(graph, propquery10)$j, 'SB')
 ##}
 #
 ## I want to test that my NDFs have the correct properties:
 #
 #test.propndf = function() {
 #  propquery1 = "MATCH (t:NDF {id:'ndft1'}) return t.clearingDate as a"
 #  checkEquals(cypher(graph, propquery1)$a, '03/05/14')
 #  propquery2 = "MATCH (t:NDF {id:'ndft2'}) return t.buySell as b"
 #  checkEquals(cypher(graph, propquery2)$b, 'B')
 #  propquery3 = "MATCH (t:NDF {id:'ndft3'}) return t.currencySettlement as c"
 #  checkEquals(cypher(graph, propquery3)$c, 'USD')
 #  propquery4 = "MATCH (t:NDF {id:'ndft4'}) return t.currencyUnderlying as d"
 #  checkEquals(cypher(graph, propquery4)$d, 'KRW')
 #  propquery5 = "MATCH (t:NDF {id:'ndft5'}) return t.notionalInUnderlying as e"
 #  checkEquals(cypher(graph, propquery5)$e, 10004)
 #  propquery6 = "MATCH (t:NDF {id:'ndft1'}) return t.agreedFXRate as f"
 #  checkEquals(cypher(graph, propquery6)$f, 6.7)
 #  propquery7 = "MATCH (t:NDF {id:'ndft2'}) return t.fixingDate as g"
 #  checkEquals(cypher(graph, propquery7)$g, '04/05/15')
 #  propquery8 = "MATCH (t:NDF {id:'ndft3'}) return t.fixingRateToday as h"
 #  checkEquals(cypher(graph, propquery8)$h, 67)
 #  propquery9 = "MATCH (t:NDF {id:'ndft4'}) return t.cashSettlement as i"
 #  checkEquals(cypher(graph, propquery9)$i, -3126)
 #}
 #
 ## I want to test that my FX singles have the correct properties:
 #
 #test.propfxsi = function() {
 #  propquery1 = "MATCH (t:FXSI {id:'fxsi1'}) return t.clearingDate as a"
 #  checkEquals(cypher(graph, propquery1)$a, '28/03/13')
 #  propquery2 = "MATCH (t:FXSI {id:'fxsi2'}) return t.baseCurrency as b"
 #  checkEquals(cypher(graph, propquery2)$b, 'EUR')
 #  propquery3 = "MATCH (t:FXSI {id:'fxsi3'}) return t.counterCurrency as c"
 #  checkEquals(cypher(graph, propquery3)$c, 'GBP')
 #  propquery4 = "MATCH (t:FXSI {id:'fxsi4'}) return t.baseCurrencyAmount as d"
 #  checkEquals(cypher(graph, propquery4)$d, 1000000)
 #  propquery5 = "MATCH (t:FXSI {id:'fxsi5'}) return t.counterCurrencyAmount as e"
 #  checkEquals(cypher(graph, propquery5)$e, 149000)
 #  propquery6 = "MATCH (t:FXSI {id:'fxsi1'}) return t.paymentDate as f"
 #  checkEquals(cypher(graph, propquery6)$f, "18/05/13")
 #}
 #
 ## I want to test that my FX swaps have the correct properties:
 #
 #test.propfxsw = function() {
 #  propquery1 = "MATCH (t:FXSW {id:'fxsw1'}) return t.clearingDate as a"
 #  checkEquals(cypher(graph, propquery1)$a, '18/05/12')
 #  propquery2 = "MATCH (t:FXSW {id:'fxsw2'}) return t.baseCurrency as b"
 #  checkEquals(cypher(graph, propquery2)$b, 'EUR')
 #  propquery3 = "MATCH (t:FXSW {id:'fxsw3'}) return t.counterCurrency as c"
 #  checkEquals(cypher(graph, propquery3)$c, 'GBP')
 #  propquery4 = "MATCH (t:FXSW {id:'fxsw4'}) return t.notionalBaseCurrency as d"
 #  checkEquals(cypher(graph, propquery4)$d, 10000003)
 #  propquery5 = "MATCH (t:FXSW {id:'fxsw5'}) return t.nearRate as e"
 #  checkEquals(cypher(graph, propquery5)$e, 0.15)
 #  propquery6 = "MATCH (t:FXSW {id:'fxsw1'}) return t.forwardPoints as f"
 #  checkEquals(cypher(graph, propquery6)$f, 0.2)
 #  propquery7 = "MATCH (t:FXSW {id:'fxsw2'}) return t.nearDate as g"
 #  checkEquals(cypher(graph, propquery7)$g, '24/05/12')
 #  propquery8 = "MATCH (t:FXSW {id:'fxsw3'}) return t.farDate as h"
 #  checkEquals(cypher(graph, propquery8)$h, '01/07/12')
 #}
 #
 ## I want to test that my Options have the correct properties:
 #
 #test.propOptions = function() {
 #  propquery1 = "MATCH (t:Opt {id:'optv1'}) return t.clearingDate as a"
 #  checkEquals(cypher(graph, propquery1)$a, '08/03/14')
 #  propquery3 = "MATCH (t:Opt {id:'optv3'}) return t.expiry as c"
 #  checkEquals(cypher(graph, propquery3)$c, '10/04/14')
 #  propquery4 = "MATCH (t:Opt {id:'optb4'}) return t.underlyingId as d"
 #  checkEquals(cypher(graph, propquery4)$d, 'US149123BM29')
 #  propquery5 = "MATCH (t:Opt {id:'optv5'}) return t.currency as e"
 #  checkEquals(cypher(graph, propquery5)$e, 'GBP')
 #  propquery6 = "MATCH (t:Opt {id:'optb1'}) return t.quantity as f"
 #  checkEquals(cypher(graph, propquery6)$f, 250)
 #  propquery7 = "MATCH (t:Opt {id:'optv2'}) return t.longShort as g"
 #  checkEquals(cypher(graph, propquery7)$g, 'Short')
 #  propquery8 = "MATCH (t:Opt {id:'optb3'}) return t.callPut as h"
 #  checkEquals(cypher(graph, propquery8)$h, 'Put')
 #  propquery9 = "MATCH (t:Opt {id:'optv4'}) return t.strikePrice as i"
 #  checkEquals(cypher(graph, propquery9)$i, 98)
 #  propquery10 = "MATCH (t:Opt {id:'optb5'}) return t.type as j"
 #  checkEquals(cypher(graph, propquery10)$j, 'European')
 #  propquery11 = "MATCH (t:Opt {id:'optb1'}) return t.barrierType as k"
 #  checkEquals(cypher(graph, propquery11)$k, 'Up')
 #  propquery12 = "MATCH (t:Opt {id:'optb2'}) return t.knockType as l"
 #  checkEquals(cypher(graph, propquery12)$l, 'In')
 #  propquery13 = "MATCH (t:Opt {id:'optb3'}) return t.barrierLevel as m"
 #  checkEquals(cypher(graph, propquery13)$m, 105)
 #  propquery14 = "MATCH (t:Opt {id:'optb4'}) return t.rebate as n"
 #  checkEquals(cypher(graph, propquery14)$n, NA)
 #  propquery15 = "MATCH (t:Opt {id:'optb5'}) return t.rebate as o"
 #  checkEquals(cypher(graph, propquery15)$o, 110)
 #}
 #
 ## I want to test that my FRAs have the correct properties:
 
 test.propfra = function() {
   propquery1 = "MATCH (t:FRA {id:'fra1'}) return t.clearingDate as a"
   checkEquals(cypher(graph, propquery1)$a, '29/06/13')
   propquery2 = "MATCH (t:FRA {id:'fra2'}) return t.maturity as b"
   checkEquals(cypher(graph, propquery2)$b, '30/09/13')
   propquery3 = "MATCH (t:FRA {id:'fra3'}) return t.legPay as c"
   checkEquals(cypher(graph, propquery3)$c, 'Fixed')
   propquery4 = "MATCH (t:FRA {id:'fra4'}) return t.notional as d"
   checkEquals(cypher(graph, propquery4)$d, 15003)
   propquery5 = "MATCH (t:FRA {id:'fra5'}) return t.currency as e"
   checkEquals(cypher(graph, propquery5)$e, 'USD')
   propquery6 = "MATCH (t:FRA {id:'fra1'}) return t.fixedRate as f"
   checkEquals(cypher(graph, propquery6)$f, 1.03)
   propquery7 = "MATCH (t:FRA {id:'fra2'}) return t.index as g"
   checkEquals(cypher(graph, propquery7)$g, 'USD-LIBOR-BBA')
   propquery8 = "MATCH (t:FRA {id:'fra3'}) return t.indexTenor as h"
   checkEquals(cypher(graph, propquery8)$h, '3M')
 }
 #
 ## I want to test that my ZCS have the correct properties:
 #
 #test.propzcs = function() {
 #  propquery1 = "MATCH (t:ZCS {id:'zcs1'}) return t.clearingDate as a"
 #  checkEquals(cypher(graph, propquery1)$a, '10/11/12')
 #  propquery2 = "MATCH (t:ZCS {id:'zcs2'}) return t.maturity as b"
 #  checkEquals(cypher(graph, propquery2)$b, '11/11/14')
 #  propquery3 = "MATCH (t:ZCS {id:'zcs3'}) return t.legPay as c"
 #  checkEquals(cypher(graph, propquery3)$c, 'Floating')
 #  propquery4 = "MATCH (t:ZCS {id:'zcs4'}) return t.notional as d"
 #  checkEquals(cypher(graph, propquery4)$d, 50000)
 #  propquery5 = "MATCH (t:ZCS {id:'zcs5'}) return t.currency as e"
 #  checkEquals(cypher(graph, propquery5)$e, 'USD')
 #  propquery7 = "MATCH (t:ZCS {id:'zcs2'}) return t.fixedRate as g"
 #  checkEquals(cypher(graph, propquery7)$g, 2.3)
 #  propquery8 = "MATCH (t:ZCS {id:'zcs3'}) return t.indexName as h"
 #  checkEquals(cypher(graph, propquery8)$h, 'USD-LIBOR-BBA')
 #  propquery9 = "MATCH (t:ZCS {id:'zcs4'}) return t.indexTenor as i"
 #  checkEquals(cypher(graph, propquery9)$i, '3M')
 #  propquery10 = "MATCH (t:ZCS {id:'zcs5'}) return t.initialIndex as j"
 #  checkEquals(cypher(graph, propquery10)$j, 9999)
 #  propquery11 = "MATCH (t:ZCS {id:'zcs1'}) return t.finalIndex as k"
 #  checkEquals(cypher(graph, propquery11)$k, 10995)
 #}
 #
 ## I want to test that my swaptions have the correct properties:
 #
 #test.propSwopt = function() {
 #  propquery1 = "MATCH (t:Swopt {id:'swopt1'}) return t.clearingDate as a"
 #  checkEquals(cypher(graph, propquery1)$a, '13/11/12')
 #  propquery2 = "MATCH (t:Swopt {id:'swopt2'}) return t.expiry as b"
 #  checkEquals(cypher(graph, propquery2)$b, '14/02/12')
 #  propquery3 = "MATCH (t:Swopt {id:'swopt3'}) return t.longShort as c"
 #  checkEquals(cypher(graph, propquery3)$c, 'Long')
 #  propquery4 = "MATCH (t:Swopt {id:'swopt4'}) return t.type as d"
 #  checkEquals(cypher(graph, propquery4)$d, 'American')
 #  propquery5 = "MATCH (t:Swopt {id:'swopt5'}) return t.swapBeginning as e"
 #  checkEquals(cypher(graph, propquery5)$e, '19/02/12')
 #  propquery6 = "MATCH (t:Swopt {id:'swopt1'}) return t.swapMaturity as f"
 #  checkEquals(cypher(graph, propquery6)$f, '15/02/14')
 #  propquery7 = "MATCH (t:Swopt {id:'swopt2'}) return t.legPay as g"
 #  checkEquals(cypher(graph, propquery7)$g, 'Floating')
 #  propquery8 = "MATCH (t:Swopt {id:'swopt3'}) return t.notional as h"
 #  checkEquals(cypher(graph, propquery8)$h, 20003)
 #  propquery9 = "MATCH (t:Swopt {id:'swopt4'}) return t.currency as i"
 #  checkEquals(cypher(graph, propquery9)$i, 'SGD')
 #  propquery10 = "MATCH (t:Swopt {id:'swopt5'}) return t.fixedRate as j"
 #  checkEquals(cypher(graph, propquery10)$j, 5)
 #  propquery11 = "MATCH (t:Swopt {id:'swopt1'}) return t.index as k"
 #  checkEquals(cypher(graph, propquery11)$k, 'USD-LIBOR-BBA')
 #  propquery12 = "MATCH (t:Swopt {id:'swopt2'}) return t.indexTenor as l"
 #  checkEquals(cypher(graph, propquery12)$l, '3M')
 #  propquery13 = "MATCH (t:Swopt {id:'swopt3'}) return t.resetFreq as m"
 #  checkEquals(cypher(graph, propquery13)$m, '3M')
 #  propquery14 = "MATCH (t:Swopt {id:'swopt4'}) return t.payFreqFloat as n"
 #  checkEquals(cypher(graph, propquery14)$n, '6M')
 #  propquery15 = "MATCH (t:Swopt {id:'swopt5'}) return t.payFreqFixed as o"
 #  checkEquals(cypher(graph, propquery15)$o, '1T')
 #}
 #
