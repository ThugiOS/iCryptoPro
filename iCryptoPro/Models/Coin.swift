//
//  Coin.swift
//  iCryptoPro
//
//  Created by Никитин Артем on 14.06.23.
//

import Foundation

struct Coin {
    
    let id: Int
    let name: String
    let max_supply: Int?
    let cmc_rank: Int
    let quote: Quote
    
    var logoURL: URL? {
        return URL(string: "https://s2.coinmarketcap.com/static/img/coins/200x200/1.png")
    }
    
    struct Quote {
        let USD: USD
        
        struct USD {
            let price: Double
            let market_cap: Double
        }
    }
}

extension Coin {
    
    public static func getMockArray() -> [Coin] {
        return [
            Coin(id: 1, name: "Bitcoin", max_supply: 200, cmc_rank: 1, quote: Quote(USD: Quote.USD(price: 50_000, market_cap: 1_000_000))),
            Coin(id: 2, name: "Ethereum", max_supply: nil, cmc_rank: 2, quote: Quote(USD: Quote.USD(price: 2000, market_cap: 500_000))),
            Coin(id: 3, name: "Monero", max_supply: nil, cmc_rank: 3, quote: Quote(USD: Quote.USD(price: 200, market_cap: 250_000))),
        ]
    }
}
