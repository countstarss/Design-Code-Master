//
//  SearchView.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/4/30.
//

import SwiftUI

struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
