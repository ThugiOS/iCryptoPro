//
//  ViewCryptoControllerViewModel.swift
//  iCryptoPro
//
//  Created by Никитин Артем on 15.06.23.
//

import UIKit

class ViewCryptoControllerViewModel {
    
    var onImageLoaded: ((UIImage?)->Void)?
    
    // MARK: - Variables
    let coin: Coin
    
    // MARK: - Initializer
    init(coin: Coin) {
        self.coin = coin
        self.loadImage()
    }
    
    private func loadImage() {
        
        DispatchQueue.global().async { [weak self] in
            if let logoURL = self?.coin.logoURL,
               let imageData = try? Data(contentsOf: logoURL),
               let logoImage = UIImage(data: imageData) {
                self?.onImageLoaded?(logoImage)
            }
        }
    }
    
    // MARK: - Computed Properties
    var rankLabel: String {
        return "Rank: \(self.coin.cmc_rank)"
    }
    
    var priceLabel: String {
        return "Price: $\(self.coin.quote.USD.price) USD"
    }
    
    var marketCapLabel: String {
        return "Market Cap: $\(self.coin.quote.USD.market_cap) USD"
    }
    
    var maxSupplyLabel: String {
        
        if let maxSupply = self.coin.max_supply {
            return "Rank: \(maxSupply)"
        } else {
            return "error text"
        }
    }
}
