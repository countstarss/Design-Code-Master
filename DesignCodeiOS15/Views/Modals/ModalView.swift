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
    @State var isDidmissed  = false
    @State var appear = [false,false,false]
    @AppStorage("isLogin") var isLogin = false
    
    var body: some View {
        ZStack {
            Color.clear.background(.regularMaterial)
                .onTapGesture {
                    dismissModal()
                }
            
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
            .offset(y: isDidmissed ? 1000 : 0)
            .rotationEffect(.degrees(viewState.width/40))
            .rotation3DEffect(.degrees(viewState.width/20),axis: (x: 0.0, y: 1.0, z: 0.0))
            .gesture(drag)
            .padding(20)
            .opacity(appear[0] ? 1 : 0)
            .offset(y: appear[0] ? 0 : 200)
            .background(
                Image("Blob 1").offset(x:200 ,y:-100)
                    .allowsHitTesting(false)
                    .opacity(appear[2] ? 1 : 0)
                    .offset(y: appear[2] ? 0 : -20)
                
            )
            
            Button {
                withAnimation {
                    dismissModal()
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.body.weight(.bold))
                    .foregroundColor(.secondary)
                    .padding(8)
                    .background(.ultraThinMaterial, in: Circle())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(30)
            .opacity(appear[0] ? 1 : 0)
            .offset(y: appear[0] ? 0 : -200)
            
            
        }
        .onAppear{
            withAnimation(.easeOut){
                appear[0] = true
            }
            withAnimation(.easeOut.delay(0.1)){
                appear[1] = true
            }
            withAnimation(.easeOut(duration: 1).delay(0.2)){
                appear[2] = true
            }
        }
        .onChange(of: isLogin) {newValue in
            if newValue{
                dismissModal()
            }
        }
    }
    
    var drag:some Gesture{
        DragGesture()
            .onChanged { value in
                viewState = value.translation
            }
            .onEnded { value in
                if value.translation.height > 200 {
                    dismissModal()
                }else{
                    withAnimation(.openCard) {
                        viewState = .zero
                    }
                }
                
            }
        
    }
    func dismissModal(){
        withAnimation(.linear){
            isDidmissed = true
        }
        withAnimation(.linear.delay(0.5)) {
            showModal = false
        }
    }
}

#Preview {
    ModalView()
        .environmentObject(Model())
}
