//
//  Item.swift
//  FortniteShopApp
//
//  Created by Archichil on 19.08.24.
//

import Foundation

struct Item: Decodable {
    let result: Bool
    let item: ItemInfo
}

struct ItemInfo: Decodable {
    let type: Rarity
    let rarity: Rarity
    let releaseDate: String
    let lastAppearance: String
    let introduction: Introduction
    let displayAssets: [DisplayAssets]
    let shopHistory: [String]
}

struct Introduction: Decodable {
    let chapter, season, text: String
}
