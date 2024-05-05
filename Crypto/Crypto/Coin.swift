//
//  Coin.swift
//  Crypto
//
//  Created by Necati Alperen IŞIK on 6.05.2024.
//

import Foundation

struct Coin: Decodable {
    let symbol, name: String?
    let iconURL: String?
    let marketCap, price: String?
    let change: String?
    let rank: Int?
    let coinrankingURL: String?


    enum CodingKeys: String, CodingKey {
        case symbol, name
        case iconURL = "iconUrl"
        case marketCap, price,change, rank
        case coinrankingURL = "coinrankingUrl"
    }
}
