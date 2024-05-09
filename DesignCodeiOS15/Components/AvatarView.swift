//
//  AvatarView.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/5/6.
//

import SwiftUI

struct AvatarView: View {
    @AppStorage("isLogin") var isLogin = false
    
    var body: some View {
        Group {
            if isLogin{
                AsyncImage(url: URL(string: "https://picsum.photos/200"),transaction: Transaction(animation: .easeInOut)){
                    phase in
                    switch phase {
                    case .success(let image):
                        image.resizable()
                            .transition(.scale(scale: 0.5, anchor: .center))
                    case .empty:
                        ProgressView()
                    case .failure(_):
                        Color.gray
                    @unknown default:
                        EmptyView()
                    }
                    
                }
            }else{
                Image("Avatar Default")
                    .resizable()
            }
        }
        .frame(width: 26, height: 26)
        .cornerRadius(10)
        .padding(8)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .strokeStyle(cornerRadius: 18)
        
    }
}

#Preview {
    AvatarView(isLogin: false)
}
