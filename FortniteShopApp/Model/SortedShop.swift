//
//  SortedShop.swift
//  FortniteShopApp
//
//  Created by Archichil on 19.08.24.
//

import Foundation

struct SortedShop {
    let sections: [SortedSection]
}

struct SortedSection {
    let sectionName: String
    let items: [ShopItem]
}
