//
//  ShopViewModel.swift
//  FortniteShopApp
//
//  Created by Archichil on 19.08.24.
//

import Foundation

final class ShopViewModel: ObservableObject {
    
    @Published var sortedShop: SortedShop = SortedShop()
    
    let url = "https://fortniteapi.io/v2/shop/?lang=en&fields=,"
    
    init() {
        loadShop()
        
    }
    
    @MainActor
    func fetchShop() async throws {
        let jsonDecoder = JSONDecoder()
        guard let url = URL(string: url) else {
            print("DEBUG: Invalid URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(ApiKeys.FortniteApiIo.rawValue, forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("DEBUG: Invalid response from API")
            return
        }
        guard let shop = try? jsonDecoder.decode(Shop.self, from: data) else {
            print("DEBUG: Can't decode data")
            return
        }
        self.sortedShop = shop.toSortedShop()
    }
    
    func loadShop() {
        Task(priority: .medium) {
            try await fetchShop()
            
        }
    }
}
