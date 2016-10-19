library(RNeo4j)
library(RUnit)

# I want to test that my IRS have the correct properties:

test.propirs = function() {
  propquery1 = "MATCH (t:IRS {id:'irsvt1'}) return t.clearingDate as d"
  checkEquals(cypher(buildDataBase(), propquery1)$d, '29/07/15')
  propquery2 = "MATCH (t:IRS {id:'irsft2'}) return t.maturity as e"
  checkEquals(cypher(buildDataBase(), propquery2)$e, '16/12/20')
  propquery3 = "MATCH (t:IRS {id:'irsvt3'}) return t.legPay as f"
  checkEquals(cypher(buildDataBase(), propquery3)$f, 'Fixed')
  propquery4 = "MATCH (t:IRS {id:'irsvt4'}) return t.notional as g"
  checkEquals(cypher(buildDataBase(), propquery4)$g, 5000000)
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
  propquery17 = "MATCH (t:IRS {id:'irsvt2'}) return t.markToMarket as t"
  checkEquals(cypher(buildDataBase(), propquery17)$t, -54082.03)
  propquery18 = "MATCH (t:IRS {id:'irsft3'}) return t.nextCouponPaymentDate as u"
  checkEquals(cypher(buildDataBase(), propquery18)$u, '21/12/16')
}

# I want to check that my CDS have the correct properties:

test.propcds = function() {
  propquery1 = "MATCH (t:CDS {id:'cdst1'}) return t.clearingDate as a"
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
  checkEquals(cypher(buildDataBase(), propquery9)$i, 0.6)
  propquery10 = "MATCH (t:CDS {id:'cdst5'}) return t.seniority as j"
  checkEquals(cypher(buildDataBase(), propquery10)$j, 'SB')
  propquery11 = "MATCH (t:CDS {id:'cdst1'}) return t.markToMarket as k"
  checkEquals(cypher(buildDataBase(), propquery11)$k, -10000)
}

# I want to test that my NDFs have the correct properties:

test.propndf = function() {
  propquery1 = "MATCH (t:NDF {id:'ndft1'}) return t.clearingDate as a"
  checkEquals(cypher(buildDataBase(), propquery1)$a, '03/05/14')
  propquery2 = "MATCH (t:NDF {id:'ndft2'}) return t.buySell as b"
  checkEquals(cypher(buildDataBase(), propquery2)$b, 'B')
  propquery3 = "MATCH (t:NDF {id:'ndft3'}) return t.currencySettlement as c"
  checkEquals(cypher(buildDataBase(), propquery3)$c, 'USD')
  propquery4 = "MATCH (t:NDF {id:'ndft4'}) return t.currencyUnderlying as d"
  checkEquals(cypher(buildDataBase(), propquery4)$d, 'KRW')
  propquery5 = "MATCH (t:NDF {id:'ndft5'}) return t.notionalInUnderlying as e"
  checkEquals(cypher(buildDataBase(), propquery5)$e, 10004)
  propquery6 = "MATCH (t:NDF {id:'ndft1'}) return t.agreedFXRate as f"
  checkEquals(cypher(buildDataBase(), propquery6)$f, 6.7)
  propquery7 = "MATCH (t:NDF {id:'ndft2'}) return t.fixingDate as g"
  checkEquals(cypher(buildDataBase(), propquery7)$g, '04/05/15')
  propquery8 = "MATCH (t:NDF {id:'ndft3'}) return t.fixingRateToday as h"
  checkEquals(cypher(buildDataBase(), propquery8)$h, 67)
  propquery9 = "MATCH (t:NDF {id:'ndft4'}) return t.cashSettlement as i"
  checkEquals(cypher(buildDataBase(), propquery9)$i, -3126)
}

# I want to test that my FX singles have the correct properties:

test.propfxsi = function() {
  propquery1 = "MATCH (t:FXSI {id:'fxsi1'}) return t.clearingDate as a"
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
  checkEquals(cypher(buildDataBase(), propquery6)$f, "18/05/13")
  propquery7 = "MATCH (t:FXSI {id:'fxsi2'}) return t.markToMarket as g"
  checkEquals(cypher(buildDataBase(), propquery7)$g, -78)
}

# I want to test that my FX swaps have the correct properties:

test.propfxsw = function() {
  propquery1 = "MATCH (t:FXSW {id:'fxsw1'}) return t.clearingDate as a"
  checkEquals(cypher(buildDataBase(), propquery1)$a, '18/05/12')
  propquery2 = "MATCH (t:FXSW {id:'fxsw2'}) return t.baseCurrency as b"
  checkEquals(cypher(buildDataBase(), propquery2)$b, 'EUR')
  propquery3 = "MATCH (t:FXSW {id:'fxsw3'}) return t.counterCurrency as c"
  checkEquals(cypher(buildDataBase(), propquery3)$c, 'GBP')
  propquery4 = "MATCH (t:FXSW {id:'fxsw4'}) return t.notionalBaseCurrency as d"
  checkEquals(cypher(buildDataBase(), propquery4)$d, 10003)
  propquery5 = "MATCH (t:FXSW {id:'fxsw5'}) return t.nearRate as e"
  checkEquals(cypher(buildDataBase(), propquery5)$e, 0.15)
  propquery6 = "MATCH (t:FXSW {id:'fxsw1'}) return t.forwardPoints as f"
  checkEquals(cypher(buildDataBase(), propquery6)$f, 0.2)
  propquery7 = "MATCH (t:FXSW {id:'fxsw2'}) return t.nearDate as g"
  checkEquals(cypher(buildDataBase(), propquery7)$g, '24/05/12')
  propquery8 = "MATCH (t:FXSW {id:'fxsw3'}) return t.farDate as h"
  checkEquals(cypher(buildDataBase(), propquery8)$h, '01/07/12')
  propquery9 = "MATCH (t:FXSW {id:'fxsw4'}) return t.markToMarket as i"
  checkEquals(cypher(buildDataBase(), propquery9)$i, 18)
}

# I want to test that my options have the correct properties:

test.propoptions = function() {
  propquery1 = "MATCH (t:OPT {id:'optv1'}) return t.clearingDate as a"
  checkEquals(cypher(buildDataBase(), propquery1)$a, '08/03/14')
  propquery2 = "MATCH (t:OPT {id:'optb2'}) return t.markToMarket as b"
  checkEquals(cypher(buildDataBase(), propquery2)$b, -15)
  propquery3 = "MATCH (t:OPT {id:'optv3'}) return t.expiry as c"
  checkEquals(cypher(buildDataBase(), propquery3)$c, '10/04/14')
  propquery4 = "MATCH (t:OPT {id:'optb4'}) return t.underlyingId as d"
  checkEquals(cypher(buildDataBase(), propquery4)$d, 'US149123BM29')
  propquery5 = "MATCH (t:OPT {id:'optv5'}) return t.currency as e"
  checkEquals(cypher(buildDataBase(), propquery5)$e, 'GBP')
  propquery6 = "MATCH (t:OPT {id:'optb1'}) return t.quantity as f"
  checkEquals(cypher(buildDataBase(), propquery6)$f, 250)
  propquery7 = "MATCH (t:OPT {id:'optv2'}) return t.longShort as g"
  checkEquals(cypher(buildDataBase(), propquery7)$g, 'Short')
  propquery8 = "MATCH (t:OPT {id:'optb3'}) return t.callPut as h"
  checkEquals(cypher(buildDataBase(), propquery8)$h, 'Put')
  propquery9 = "MATCH (t:OPT {id:'optv4'}) return t.strikePrice as i"
  checkEquals(cypher(buildDataBase(), propquery9)$i, 98)
  propquery10 = "MATCH (t:OPT {id:'optb5'}) return t.type as j"
  checkEquals(cypher(buildDataBase(), propquery10)$j, 'European')
  propquery11 = "MATCH (t:OPT {id:'optb1'}) return t.barrierType as k"
  checkEquals(cypher(buildDataBase(), propquery11)$k, 'Up')
  propquery12 = "MATCH (t:OPT {id:'optb2'}) return t.knockType as l"
  checkEquals(cypher(buildDataBase(), propquery12)$l, 'In')
  propquery13 = "MATCH (t:OPT {id:'optb3'}) return t.barrierLevel as m"
  checkEquals(cypher(buildDataBase(), propquery13)$m, 105)
  propquery14 = "MATCH (t:OPT {id:'optb4'}) return t.rebate as n"
  checkEquals(cypher(buildDataBase(), propquery14)$n, NA)
  propquery15 = "MATCH (t:OPT {id:'optb5'}) return t.rebate as o"
  checkEquals(cypher(buildDataBase(), propquery15)$o, 110)
}

# I want to test that my FRAs have the correct properties:

test.propfra = function() {
  propquery1 = "MATCH (t:FRA {id:'fra1'}) return t.clearingDate as a"
  checkEquals(cypher(buildDataBase(), propquery1)$a, '29/06/13')
  propquery2 = "MATCH (t:FRA {id:'fra2'}) return t.maturity as b"
  checkEquals(cypher(buildDataBase(), propquery2)$b, '30/09/13')
  propquery3 = "MATCH (t:FRA {id:'fra3'}) return t.legPay as c"
  checkEquals(cypher(buildDataBase(), propquery3)$c, 'Fixed')
  propquery4 = "MATCH (t:FRA {id:'fra4'}) return t.notional as d"
  checkEquals(cypher(buildDataBase(), propquery4)$d, 15003)
  propquery5 = "MATCH (t:FRA {id:'fra5'}) return t.currency as e"
  checkEquals(cypher(buildDataBase(), propquery5)$e, 'USD')
  propquery6 = "MATCH (t:FRA {id:'fra1'}) return t.agreedRate as f"
  checkEquals(cypher(buildDataBase(), propquery6)$f, 1.03)
  propquery7 = "MATCH (t:FRA {id:'fra2'}) return t.index as g"
  checkEquals(cypher(buildDataBase(), propquery7)$g, 'USD-LIBOR-BBA')
  propquery8 = "MATCH (t:FRA {id:'fra3'}) return t.indexTenor as h"
  checkEquals(cypher(buildDataBase(), propquery8)$h, '3M')
  propquery9 = "MATCH (t:FRA {id:'fra4'}) return t.markToMarket as i"
  checkEquals(cypher(buildDataBase(), propquery9)$i, 3)
}


















