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
        return "Price: \(coin.pricingData.USD.price)$"
    }
    
    var marketCapLabel: String {
        return "Market Cap: \(Int(self.coin.pricingData.USD.market_cap))$"
    }

    var percentChange1h: Double {
        return round(self.coin.pricingData.USD.percent_change_1h * 1000) / 1000
    }
    
    var percentChange24h: Double {
        return round(self.coin.pricingData.USD.percent_change_24h * 100) / 100
    }
    
    var percentChange7d: Double {
        return round(self.coin.pricingData.USD.percent_change_7d * 100) / 100
    }
    
    var symbol: String {
        return "\(coin.symbol)"
    }
    
    var lastUpdated: String {
        let dateString = coin.lastUpdated
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MM-dd-yyyy HH:mm"
            let outputString = outputFormatter.string(from: date)
            return "Last updated: \(outputString)"
        } else {
            return "Last updated: \(dateString)"
        }
    }
    
    func goToCoinMarketCap() {
        if let url = URL(string: "https://coinmarketcap.com") {
            UIApplication.shared.open(url)
        }
    }
}
