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
                VStack(alignment: .leading, spacing: 12) {
                    Text("Email Address")
                        .fontWeight(.semibold)
                        .font(.footnote)
                    
                    TextField("name@email.com", text: $email)
                    
                    Rectangle()
                        .foregroundColor(Color(.init(white: 1.0, alpha: 0.3)))
                        .frame(height: 0.7)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Password")
                        .fontWeight(.semibold)
                        .font(.footnote)
                    
                    TextField("Enter your password", text: $password)
                    
                    Rectangle()
                        .foregroundColor(Color(.init(white: 1.0, alpha: 0.3)))
                        .frame(height: 0.7)
                }
            }
            
            Button {
                
            } label: {
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
    }
}
