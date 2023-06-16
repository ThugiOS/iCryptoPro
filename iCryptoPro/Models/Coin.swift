//
//  Coin.swift
//  iCryptoPro
//
//  Created by Никитин Артем on 14.06.23.
//

import Foundation

struct CoinArray: Decodable {
    let data: [Coin]
}

struct Coin: Decodable {
    let id: Int
    let name: String
    let maxSupply: Int?
    let rank: Int
    let pricingData: PricingData
    
    var logoURL: URL? {
        return URL(string: "https://s2.coinmarketcap.com/static/img/coins/200x200/\(id).png")
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case maxSupply = "max_supply"
        case rank = "cmc_rank"
        case pricingData = "quote"
    }

}

struct PricingData: Decodable {
    let USD: USD
}

struct USD: Decodable {
    let price: Double
    let marketCap: Double
}


//struct PricingData: Decodable {
//    let price: Double
//    let market_cap: Double
//
//    enum CodingKeys: String, CodingKey {
//        case USD
//        case price
//        case marketCap = "market_cap"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let usd = try container.nestedContainer(keyedBy: CodingKey.self, forKey: .USD)
//        price = try usd.decode(Double.self, forKey: .price)
//        market_cap = try usd.decode(Double.self, forKey: .marketCap)
//    }
//}
