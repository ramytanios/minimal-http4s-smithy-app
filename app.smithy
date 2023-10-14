$version: "2"

namespace app

use alloy#simpleRestJson

@simpleRestJson
service App {
    version: "0.0.1"
    operations: [GetFxRate]
}

string Currency

structure CurrencyPair {
    @required
    ccy0: Currency
    @required
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
