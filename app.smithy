$version: "2"
namespace app

use alloy#simpleRestJson

@simpleRestJson
service App {
    version: "0.0.1",
    operations: [GetRandomCities, GetPopuationOfCity]
}

structure City {
  @required
  name: String, 

  @required
  country: String
}

list Cities {
  member: City
}

structure GetPopulationInput {
  @required
  city: City
}

structure GetPopulationOutput {
  @required
  population: Double
}

structure RandomCities {
  @required
  cities: Cities
}

@http(method: "GET", uri: "/api/cities", code: 200)
operation GetRandomCities {
  output: RandomCities
}

@http(method: "POST", uri: "/api/population", code: 200)
operation GetPopuationOfCity {
  input: GetPopulationInput
  output: GetPopulationOutput
}
  
