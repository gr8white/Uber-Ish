//
//  SignUpView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/14/23.
//

import SwiftUI

struct SignUpView: View {
    @State var fullName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Text("Create an account")
                .font(.system(size: 40))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .frame(width: 190)
            
            VStack(spacing: 32) {
                CustomInputField(text: $fullName, title: "Full Name", placeholder: "Enter your name")
                
                CustomInputField(text: $email, title: "Email", placeholder: "Enter your email")
                
                CustomInputField(text: $password, title: "Create Password", placeholder: "Enter your password", isSecured: true)
            }
            
            VStack {
                HStack(spacing: 24) {
                    Rectangle()
                        .frame(width: 104, height: 1)
                        .opacity(0.5)
                    
                    Text("Sign in with social")
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    Rectangle()
                        .frame(width: 104, height: 1)
                        .opacity(0.5)
                }
                
                HStack(spacing: 24) {
                    Button {} label: {
                        Image("facebook-sign-in-icon")
                            .resizable()
                            .frame(width: 44, height: 44)
                    }
                    
                    Button {} label: {
                        Image("google-sign-in-icon")
                            .resizable()
                            .frame(width: 44, height: 44)
                    }
                }
            }
            
            Button {
                authViewModel.signUp(fullName: fullName, email: email, password: password) { authState in
                    print(authState)
                }
                
            } label: {
                HStack {
                    Text("SIGN UP")
                        .font(.system(size: 14))
                    
                    Image(systemName: "arrow.right")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
