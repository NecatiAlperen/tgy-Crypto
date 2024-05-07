//
//  Coin.swift
//  Crypto
//
//  Created by Necati Alperen IŞIK on 6.05.2024.
//

import Foundation


struct CoinResponse: Codable {
    let status: String
    let data: CoinData
}

struct CoinData: Codable {
    let coins: [Coin]
}

struct Coin: Codable {
    let uuid: String?
    let symbol: String?
    let name: String?
    let iconUrl: String?
    let marketCap: String?
    let price: String?
    let change: String
    let rank: Int?
    let coinrankingURL: String?

    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name
        case iconUrl = "iconUrl"
        case marketCap, price, change, rank
        case coinrankingURL = "coinrankingUrl"
    }
}

