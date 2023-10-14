$version: "2"
namespace app

use alloy#simpleRestJson

@simpleRestJson
service App {
    version: "0.0.1",
    operations: [GetFxRate]
}

string Currency

structure GetFxRateInput {
  @required
  currency0: Currency

  @required
  currency1: Currency
}

structure GetFxRateOutput {
  @required
  rate: Double
}

@http(method: "POST", uri: "/api/fxrate", code: 200)
operation GetFxRate {
  input: GetFxRateInput
  output: GetFxRateOutput
}
  
