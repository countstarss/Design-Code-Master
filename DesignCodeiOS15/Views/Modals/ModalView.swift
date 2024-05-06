//
//  ModalView.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/5/6.
//

import SwiftUI

struct ModalView: View {
    @EnvironmentObject var model:Model
    @AppStorage("showModal") var showModal = true 
    @State var viewState:CGSize = .zero
    
    var body: some View {
        ZStack {
            
            Group{
                switch model.selectedModal {
                case .signUp:
                    SignUpView()
                case .signIn:
                    SignInView()
                }
            }
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .offset(x:viewState.width ,y:viewState.height)
            .rotationEffect(.degrees(viewState.width/40))
            .rotation3DEffect(.degrees(viewState.width/20),axis: (x: 0.0, y: 1.0, z: 0.0))
            .gesture(drag)
            .padding(20)
            .background(
                Image("Blob 1").offset(x:200 ,y:-100)
            )
            
            
        }
    }
    
    var drag:some Gesture{
        DragGesture()
            .onChanged { value in
                viewState = value.translation
            }
            .onEnded { value in
                withAnimation(.openCard) {
                    viewState = .zero
                }
            }
        
    }
}

#Preview {
    ModalView()
        .environmentObject(Model())
}
