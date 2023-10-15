$version: "2"

namespace app

use alloy#simpleRestJson

@simpleRestJson
service App {
    version: "0.0.1"
    operations: [GetFxRate]
}

string Currency

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

@http(method: "POST", uri: "/api/fxrate", code: 200)
operation GetFxRate {
    input: CurrencyPair
    output: FxRate
}
