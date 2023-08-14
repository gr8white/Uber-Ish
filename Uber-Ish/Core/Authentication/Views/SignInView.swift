//
//  SignInView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/14/23.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 32) {
                CustomInputField(text: $email, title: "Email", placeholder: "name@example.com")
                
                CustomInputField(text: $password, title: "Password", placeholder: "Enter your password", isSecured: true)
            }
            
            Button {} label: {
                Text("Forgot Password?")
                    .font(.system(size: 14, weight: .semibold))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
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
            
            Button {} label: {
                HStack {
                    Text("SIGN IN")
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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
