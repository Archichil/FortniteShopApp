//
//  ShopView.swift
//  FortniteShopApp
//
//  Created by Archichil on 19.08.24.
//

import SwiftUI

struct ShopView: View {
    
    @ObservedObject private var viewModel = ShopViewModel()
    @State private var scrollToID: UUID?

    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
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
                            .id(section.id)
                    }
                }
                .onChange(of: scrollToID, { _, newValue in
                    if let id = newValue {
                        withAnimation {
                            proxy.scrollTo(id, anchor: .top)
                        }
                    }
                })
            }
            .toolbar(content: {
                Menu("Scroll To") {
                    ForEach(viewModel.sortedShop.sections) { section in
                        Button(action: { scrollToSection(section.id) }, label: {
                            Text(section.sectionName)
                        })
                    }
                }
            })
            .navigationTitle("Daily Shop")
        }
    }
    
    private func scrollToSection(_ id: UUID) {
        scrollToID = id
    }
}

#Preview {
    ShopView()
}
