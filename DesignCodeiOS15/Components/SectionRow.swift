//
//  SectionRow.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/5/10.
//

import SwiftUI

struct SectionRow: View {
    var section: CourseSection = courseSections[0]
    var body: some View {
        HStack (alignment: .top,spacing: 16){
            Image(section.logo)
                .resizable()
                .frame(width: 36,height: 36)
                .mask(Circle())
                .padding(12)
                // systemBackground 可以根据颜色模式自动变化
                .background(Color(UIColor.systemBackground).opacity(0.3))
                .mask(Circle())
                .overlay(CircularView(trimValue: section.progress,size: 64))
                .padding(12)
            VStack(alignment: .leading,spacing: 8){
                Text(section.subtitle)
                    .font(.caption.weight(.medium))
                Text(section.title)
                    .fontWeight(.semibold)
                Text(section.text)
                    .font(.caption.weight(.medium))
                    .foregroundColor(.secondary)
                ProgressView(value: section.progress)
                    .accentColor(.white)
                    .frame(maxWidth: 132)
            }
        }
    }
}

#Preview {
    SectionRow()
}
