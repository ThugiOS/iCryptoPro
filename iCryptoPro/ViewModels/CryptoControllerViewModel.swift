//
//  CryptoControllerViewModel.swift
//  iCryptoPro
//
//  Created by Никитин Артем on 15.06.23.
//

import UIKit
import Foundation

class CryptoControllerViewModel {
    
    var onCoinsUpdated: (()->Void)?
    var onErrorMessage: ((CoinServiceError)->Void)?
    
    private(set) var allCoins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
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
        return "Price: $\(round(self.coin.pricingData.USD.price * 10000) / 10000)"
    }
    
    var marketCapLabel: String {
        return "Market Cap: $\(Int(self.coin.pricingData.USD.market_cap))"
    }

    var percentChange1h: String {
        return "Percent change 1h:  \(round(self.coin.pricingData.USD.percent_change_1h * 100) / 100) %"
    }
    
    var percentChange24h: String {
        return "Percent change 24h:  \(round(self.coin.pricingData.USD.percent_change_24h * 100) / 100) %"
    }
    
    var percentChange7d: String {
        return "Percent change 7d:  \(round(self.coin.pricingData.USD.percent_change_7d * 100) / 100) %"
    }
}
