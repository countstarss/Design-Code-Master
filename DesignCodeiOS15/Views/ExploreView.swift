//
//  ExploreView.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/5/10.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            courseSection
            .safeAreaInset(edge: .top){
                Color.clear.frame(height: 70)
            }
            .overlay(
                NavigationBar(title: "Recent", hasScrolled: .constant(true))
                    
            )
            .background(Image("Blob 1").offset(x:-100,y:-400))
        }
    }
    
    
    var courseSection :some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing:16) {
                ForEach(courses) { course in
                    SmallCourseItem(course: course)
                        .frame(maxWidth: .infinity)
                }
                
            }
            .padding(.horizontal,20)
            Spacer()
        }
    }
}

#Preview {
    ExploreView()
}
