$version: "2"

namespace exampleservice

use alloy#simpleRestJson

@simpleRestJson
service SimpleService {
    version: "0.0.1"
    operations: [ImAlive, GetFxRate]
}

string Currency

structure ImAliveResp {
    @required
    resp: String
}

@documentation("FOR/DOM currency pair")
structure CurrencyPair {
    @required
    @documentation("Foreign currency")
    ccy0: Currency
    @required
    @documentation("Domestic currency")
    ccy1: Currency
}

structure FxRate {
    @required
    rate: Double
}

@http(method: "GET", uri: "/api/alive", code: 200)
operation ImAlive {
    output: ImAliveResp
}

@http(method: "POST", uri: "/api/fxrate", code: 200)
operation GetFxRate {
    input: CurrencyPair
    output: FxRate
}
