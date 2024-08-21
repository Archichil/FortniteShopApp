//
//  SortedShop.swift
//  FortniteShopApp
//
//  Created by Archichil on 19.08.24.
//

import Foundation

struct SortedShop {
    let sections: [SortedSection]
    
    init(sections: [SortedSection]) {
        self.sections = sections
    }
    
    init() {
        self.sections = []
    }
}

struct SortedSection: Identifiable {
    let sectionName: String
    let items: [ShopItem]
    let id = UUID()
}
