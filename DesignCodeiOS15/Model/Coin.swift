//
//  Coin.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/5/9.
//

import SwiftUI

struct Coin: Identifiable,Decodable {
    var id : Int
    var coin_name : String
    var acronym : String
    var logo : String
}

class CoinModel:ObservableObject{
    // 这里设置了ObservableObject,并且有Published包装器,我们在任何地方都可以使用coins
    @Published var coins : [Coin] = []
    
    @MainActor
    func fetchCoins() async{
        do{
            let url = URL(string: "https://random-data-api.com/api/crypto_coin/random_crypto_coin?size=10")!
            let (data,_) = try await URLSession.shared.data(from: url)
            coins = try JSONDecoder().decode([Coin].self, from: data)
        }catch{
            //
            print("Error Fetching Coins")
        }
        
    }
}
