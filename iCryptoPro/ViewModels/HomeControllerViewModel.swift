//
//  HomeControllerViewModel.swift
//  iCryptoPro
//
//  Created by Никитин Артем on 16.06.23.
//

import Foundation

class HomeControllerViewModel {
    var onCoinsUpdated: (()->Void)?
    var onErrorMessage: ((CoinServiceError)->Void)?
    
    private(set) var coins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
    init() {
        self.fetchCoins()
    }
    
    public func fetchCoins() {
        let endPoint = Endpoint.fetchCoins()
        
        CoinService.fetchCoins(with: endPoint) { [weak self] result in
            switch result {
            case .success(let coins):
                self?.coins = coins
                print("DEBUG PRINT:", "\(coins.count) coins fetched.")
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }

}
