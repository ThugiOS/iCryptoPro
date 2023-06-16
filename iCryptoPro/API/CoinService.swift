//
//  CoinService.swift
//  iCryptoPro
//
//  Created by Никитин Артем on 16.06.23.
//

import Foundation

enum CoinServiceError: Error {
    case serverError(CoinError)
    case unknown(String = "An unknown error occurred.")
    case decodingError(String = "Error parsing server response.")
}

class CoinService {
    static func fetchCoins(with endpoint: Endpoint,
                           complection: @escaping (Result<[Coin], CoinServiceError>)->Void) {
        guard let request = endpoint.request else { return }
        
        URLSession.shared.dataTask(with: request) { data, resp, error in
            if let error = error {
                complection(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                do {
                    let coinError = try JSONDecoder().decode(CoinError.self, from: data ?? Data())
                    complection(.failure(.serverError(coinError)))
                } catch let error {
                    complection(.failure(.unknown()))
                    print(error.localizedDescription)
                }
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let coinData = try decoder.decode(CoinArray.self, from: data)
                    complection(.success(coinData.data))
                } catch let error {
                    complection(.failure(.decodingError()))
                    print(error.localizedDescription)
                }
            } else {
                complection(.failure(.unknown()))
            }
        }.resume()
    }
}
