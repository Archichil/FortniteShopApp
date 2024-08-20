//
//  Shop.swift
//  FortniteShopApp
//
//  Created by Archichil on 15.08.24.
//

import Foundation

struct Shop: Decodable {
    let result: Bool
    let fullShop: Bool
    let lastUpdate: LastUpdate
    let shop: [ShopItem]
}

struct LastUpdate: Decodable {
    let date: String
    let uid: String
}

struct ShopItem: Decodable {
    let mainId: String
    let displayName: String
    let displayDescription: String
    let displayType: String
    let displayAssets: [DisplayAssets]
    let price: Price
    let rarity: Rarity
    let section: ItemSection
}

struct DisplayAssets: Decodable {
    let url: String
    let background: String
    let fullBackground: String
    
    enum CodingKeys: String, CodingKey {
        case url, background
        case fullBackground = "full_background"
    }
}

struct Price: Decodable {
    let regularPrice, finalPrice, floorPrice: Int
}

struct Rarity: Decodable {
    let id, name: String
}

struct ItemSection: Decodable {
    let name: String
}
