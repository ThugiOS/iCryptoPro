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

struct Coin: Codable {
    let id: Int
    let name: String
    let symbol: String
    let lastUpdated: String
    let rank: Int
    let pricingData: PricingData
    
    var logoURL: URL? {
        return URL(string: "https://s2.coinmarketcap.com/static/img/coins/200x200/\(id).png")
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case symbol = "symbol"
        case lastUpdated = "last_updated"
        case rank = "cmc_rank"
        case pricingData = "quote"
    }
}

struct PricingData: Codable {
    let USD: USD
}

struct USD: Codable {
    let price: Float
    let market_cap: Double
    let percent_change_1h: Double
    let percent_change_24h: Double
    let percent_change_7d: Double
}
