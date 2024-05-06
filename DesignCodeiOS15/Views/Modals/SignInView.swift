//
//  SignInView.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/5/6.
//

import SwiftUI

struct SignInView: View {
    enum Field:Hashable{
        case email
        case password
    }
    
    @State var email = ""
    @State var password = ""
    @FocusState var focusedField:Field?
    @State var circleY = -50
    @State var appear = [false,false,false]
    @EnvironmentObject var model :Model
    
    var body: some View {
        VStack(alignment:.leading,spacing:16) {
            Text("Sign In")
                .font(.largeTitle).bold()
                .opacity(appear[1] ? 1 : 0)
                .offset(y: appear[1] ? 0 : 40)
            Text("Access 120+ hours of course,tourials and livertreams")
                .font(.footnote)
            
            TextField("Email",text: $email)
                .inputStyle(icon: "mail")
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .focused($focusedField,equals: .email)
                .shadow(color:focusedField == .email ? Color(.systemPink).opacity(0.3) : Color(.clear), radius: 10)
            
            SecureField("Paddword",text: $password)
                .inputStyle(icon: "lock")
                .textContentType(.password)
                .focused($focusedField,equals: .password)
                .shadow(color:focusedField == .password ? Color(.systemPink).opacity(0.3) : Color(.clear), radius: 10)
            Button{}label: {
                Text("Sign In")
                    .frame(maxWidth:.infinity)
            }
            .shadow(color: Color("Shadow").opacity(0.2),radius: 30, x: 0,y:30)
            .buttonStyle(.angular)
            //改强调色 使用tint
            .tint(.accentColor)
            .controlSize(.large)
            .frame(maxWidth:.infinity)
            
            Group {
                HStack{
                    Text("Don't have a account")
                    Button{
                        model.selectedModal = .signUp
                    }label: {
                        Text("**Sign Up**")
                    }
                }
            }
            .foregroundStyle(.secondary)
            .font(.footnote)
        }
        .padding(20)
        .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .background(
            Circle().fill(.pink)
                .frame(width: 68, height: 68, alignment: .leading)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .offset(y:CGFloat(circleY))
        )
        .strokeStyle(cornerRadius: 30)
        .onChange(of: focusedField){value in
            withAnimation{circleY = focusedField == .email ? -37 : 30}
        }
        .onAppear{
            withAnimation(.spring){
                appear[0] = true
            }
            withAnimation(.easeOut.delay(0.1)){
                appear[1] = true
            }
            withAnimation(.easeOut.delay(0.2)){
                appear[2] = true
            }
        }
    }
}

#Preview {
    SignInView()
        .environmentObject(Model())
}
