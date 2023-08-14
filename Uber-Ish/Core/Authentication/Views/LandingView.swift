//
//  LandingView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/14/23.
//

import SwiftUI

struct LandingView: View {
    @State var showSignIn: Bool = true
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            VStack(spacing: 40) {
                VStack(spacing: -16) {
                    Image("uber-app-icon")
                        .resizable()
                        .frame(width: 200, height: 200)
                    
                    Text("UBER-ish")
                        .font(.largeTitle)
                }
                
                if showSignIn {
                    SignInView()
                } else {
                    SignUpView()
                }
                
                Spacer()
                
                Button {
                    showSignIn.toggle()
                } label: {
                    HStack (spacing: 3) {
                        Text("\(showSignIn ? "Don't" : "Already") have an account?")
                        
                        Text("Sign \(showSignIn ? "Up" : "In")")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                }
            }
            .padding(.horizontal)
            .foregroundColor(.white)
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
