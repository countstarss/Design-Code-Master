//
//  CircularView.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/5/10.
//

import SwiftUI

struct CircularView: View {
    var trimValue : CGFloat = 0.4
    var size : CGFloat = 60
    var lineWidth : CGFloat = 4
    @State var appear = false
    
    var body: some View {
        Circle()
            .trim(from: 0,to: appear ? trimValue : 0)
            .stroke(style: StrokeStyle(lineWidth: lineWidth,lineCap: .round))
            .fill(.angularGradient(colors: [.purple, .pink, .purple], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
            .rotationEffect(.degrees(270))
            .onAppear{
                withAnimation(.spring().delay(0.5)) {
                    appear = true
                }
            }
            .onDisappear{
                appear = false
            }
            .frame(width: size,height: size)
        
    }
}

#Preview {
    CircularView()
}
