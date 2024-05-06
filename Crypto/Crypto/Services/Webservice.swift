//
//  Webserice.swift
//  Crypto
//
//  Created by Necati Alperen IŞIK on 6.05.2024.
//

import Foundation
import Alamofire

final class Webservice {
    
    private let apiURL : String = "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins"
    
    func fetchCoins(completion: @escaping (Result<[Coin], Error>) -> Void) {
        AF.request(apiURL).responseDecodable(of: CoinResponse.self) { response in
            switch response.result {
            case .success(let coinResponse):
                completion(.success(coinResponse.data.coins))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
}
