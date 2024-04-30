//
//  Suggestion.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/4/30.
//

import SwiftUI

struct Suggestion: Identifiable{
    let id = UUID()
    let text: String
}

var suggestions = [
    Suggestion(text: "SwiftUI"),
    Suggestion(text: "React"),
    Suggestion(text: "Design"),
    Suggestion(text: "Flutter"),
]
