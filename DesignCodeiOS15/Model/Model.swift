//
//  Model.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/4/29.
//

import SwiftUI
import Combine

class Model:ObservableObject{
    @Published var showDetail:Bool = false
    @Published var showDone:Bool = false
    @Published var selectedModal: Modal = .signIn
}

enum Modal :String{
    case signUp
    case signIn
}
