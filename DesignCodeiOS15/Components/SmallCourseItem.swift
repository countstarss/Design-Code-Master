//
//  SmallCourseItem.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/5/10.
//

import SwiftUI

struct SmallCourseItem: View {
    var course: Course = courses[0]
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                .fill(.black.opacity(0.1))
                .overlay(
                    Image(course.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150,height: 150)
                )
            Text(course.subtitle)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
            Text(course.title)
                .fontWeight(.semibold)
        }
        .padding()
        .frame(width: 160,height: 200)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
    }
}

#Preview {
    SmallCourseItem()
}
