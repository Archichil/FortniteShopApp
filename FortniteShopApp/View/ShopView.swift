//
//  ShopView.swift
//  FortniteShopApp
//
//  Created by Archichil on 19.08.24.
//

import SwiftUI

struct ShopView: View {
    
    @ObservedObject private var viewModel = ShopViewModel()
    
    var body: some View {
//        VStack {}
        NavigationStack {
            ScrollView {
                ForEach(viewModel.sortedShop.sections) { section in
                    Section(header: 
                                Text(section.sectionName)
                                    .font(.title2)
                                    .bold()) {
                        let columns = [GridItem(.flexible()), GridItem(.flexible())]
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(section.items, id: \.offerId) { item in
                                ShopItemView(item: item)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Daily Shop")
        }
    }
}

#Preview {
    ShopView()
}
