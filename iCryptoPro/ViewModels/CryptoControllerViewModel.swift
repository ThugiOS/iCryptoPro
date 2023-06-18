//
//  CryptoControllerViewModel.swift
//  iCryptoPro
//
//  Created by Никитин Артем on 15.06.23.
//

import UIKit

class CryptoControllerViewModel {
    
    // MARK: - Variables
    let coin: Coin
    
    // MARK: - Initializer
    init(coin: Coin) {
        self.coin = coin

    }
    
    // MARK: - Computed Properties
    var rankLabel: String {
        return "Rank: \(self.coin.rank)"
    }
    
    var priceLabel: String {
        return "Price: $\(self.coin.pricingData.USD.price) USD"
    }
    
    var marketCapLabel: String {
        return "Market Cap: $\(self.coin.pricingData.USD.market_cap) USD"
    }
    
    var maxSupplyLabel: String {
        
        if let maxSupply = self.coin.maxSupply {
            return "Rank: \(maxSupply)"
        } else {
            return "error text"
        }
    }
}
