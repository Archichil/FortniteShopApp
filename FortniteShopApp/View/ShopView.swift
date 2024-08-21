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
    @State var searchText: String = ""

    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        ForEach(viewModel.sortedShop.sections) { section in
                            Button(action: {
                                withAnimation {
                                    scrollToSection(section.id)
                                }
                            }) {
                                Text(section.sectionName)
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.all, 10)
                }
                
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(viewModel.sortedShop.sections) { section in
                            Section(header:
                                        Text(section.sectionName)
                                        .font(.title2)
                                        .bold()) {
                                let columns = [GridItem(.flexible()), GridItem(.flexible())]
                                
                                LazyVGrid(columns: columns, spacing: 20) {
                                    ForEach(section.items, id: \.devName) { item in
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
            }
            .navigationTitle("Shop")
            .searchable(text: $searchText)
        }
    }
    
    private func scrollToSection(_ id: UUID) {
        scrollToID = id
    }
}

#Preview {
    ShopView()
}
