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
    
    init() {
        self.result = false
        self.fullShop = false
        self.lastUpdate = LastUpdate(date: "", uid: "")
        self.shop = []
    }
}

struct LastUpdate: Decodable {
    let date: String
    let uid: String
}

struct ShopItem: Decodable {
    let mainId: String
    let devName: String
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


extension Shop {
    func toSortedShop() -> SortedShop {
        let groupedItems = Dictionary(grouping: shop) { $0.section.name }
        let sortedSections = groupedItems.map { (sectionName, items) in
            SortedSection(sectionName: sectionName, items: items)
        }
        
        // Sort sections if necessary
        // sortedSections = sortedSections.sorted { $0.sectionName < $1.sectionName }
        return SortedShop(sections: sortedSections)
    }
}

