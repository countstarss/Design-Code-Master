//
//  SignUpView.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/4/30.
//

import SwiftUI

struct SignUpView: View {
    enum Field:Hashable{
        case email
        case password
    }
    
    @State var email = ""
    @State var password = ""
    @FocusState var focusedField:Field?
    @State var circleY = -50
    @EnvironmentObject var model : Model
    
    var body: some View {
        VStack(alignment:.leading,spacing:16) {
            Text("Sign Up")
                .font(.largeTitle).bold()
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
                Text("Crate a account")
                    .frame(maxWidth:.infinity)
            }
            .shadow(color: Color("Shadow").opacity(0.2),radius: 30, x: 0,y:30)
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
                        model.selectedModal = .signIn
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
        .background(
            Circle().fill(.pink)
                .frame(width: 68, height: 68, alignment: .leading)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .offset(y:CGFloat(circleY))
        )
        .strokeStyle(cornerRadius: 30)
        .onChange(of: focusedField){value in
            withAnimation{circleY = focusedField == .email ? -45 : 10}
        }
    }
    
    
}

#Preview {
    SignUpView()
        .environmentObject(Model())
}
