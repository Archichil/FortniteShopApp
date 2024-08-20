//
//  ShopItemView.swift
//  FortniteShopApp
//
//  Created by Archichil on 19.08.24.
//

import SwiftUI

struct ShopItemView: View {
    
    let item: ShopItem
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: item.displayAssets.first?.background ?? "")!) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                    Image(systemName: "questionmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))

                }
            }
            VStack {
                Spacer()
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(item.displayName)
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .bold()
                        
                        HStack(spacing: 5) {
                            Image("vbuck")
                                .resizable()
                                .frame(width: 18, height: 18)
                            
                            Text(String(item.price.regularPrice))
                                .foregroundColor(.white)
                                .font(.title3)
                                .bold()
                        }
                    }
                    Spacer()
                }
                .padding(.all, 10)
                .background(Color.black.opacity(0.15))
                .cornerRadius(10)
            }
        }
        .frame(width: 150, height: 150, alignment: .center)
        .background(Color.gray.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 10)
    
        
    }
}

#Preview {
    ShopItemView(item: ShopItem(
        mainId: "Pickaxe_ID_728_OrbitTealMale_3NIST",
        displayName: "Gaffi Stick",
        displayDescription: "Used by the Tusken Raiders on Tatooine, a planet Boba has spent much time on.",
        displayType: "Pickaxes", 
        displayAssets: [DisplayAssets(
            url: "https://media.fortniteapi.io/images/displayAssets/v2/MAX/DAv2_Pickaxe_ID_728_OrbitTealMale_3NIST/MI_Pickaxe_ID_728_OrbitTealMale.png",
            background: "https://media.fortniteapi.io/images/shop/a093315256ba9913479f99c59d106da8ea570209d8122a7c61ff92221021b060/v2/MI_Pickaxe_ID_728_OrbitTealMale/background.png",
            fullBackground: "https://media.fortniteapi.io/images/displayAssets/v2/MAX/DAv2_Pickaxe_ID_728_OrbitTealMale_3NIST/MI_Pickaxe_ID_728_OrbitTealMale.png")],
        price: Price(
            regularPrice: 800,
            finalPrice: 800,
            floorPrice: 800),
        rarity: Rarity(
            id: "Epic",
            name: "Epic"),
        section: ItemSection(name: "Gear For Festival")))
}
