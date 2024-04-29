//
//  Model.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/4/29.
//



import SwiftUI

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @EnvironmentObject var model : Model
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            switch selectedTab {
            case .home:
                HomeView()
            case .explore:
                AccountView()
            case .notifications:
                AccountView()
            case .library:
                AccountView()
            }
            
            TabBar()
                // 如果点开detail,就隐藏TabBar
                .offset(y: model.showDetail ? 200 : 0)
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 44)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(Model())
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(Model())
        }
    }
}
