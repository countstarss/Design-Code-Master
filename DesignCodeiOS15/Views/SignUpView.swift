//
//  SignUpView.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/4/30.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        VStack(alignment:.leading,spacing:16) {
            Text("Sign Up")
                .font(.largeTitle).bold()
            Text("Access 120+ hours of course,tourials and livertreams")
                .font(.footnote)
            Button{}label: {
                Text("Crate a account")
                    .frame(maxWidth:.infinity)
            }
            .buttonStyle(.angular)
            //改强调色 使用tint
            .tint(.accentColor)
            .controlSize(.large)
            .frame(maxWidth:.infinity)
            
            Group {
                Text("By clicking on  , ")
                + Text("**create a account**")
                    .foregroundColor(.primary.opacity(0.7))
                + Text("you agree to our **Term Of Service** and [Privacy Policy](https://countstarss.github.io)")
    
                HStack{
                    Text("Already have a account")
                    Button{
                        
                    }label: {
                        Text("**Sign in**")
                    }
                }
            }
            .foregroundStyle(.secondary)
            .font(.footnote)
        }
        .padding(20)
        .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .shadow(color: Color("Shadow").opacity(0.2),radius: 30, x: 0,y:30)
        .padding(20)
        .background(
            Image("Blob 1").offset(x:200 ,y:-100)
        )
    
        
    }
    
}

#Preview {
    SignUpView()
}
