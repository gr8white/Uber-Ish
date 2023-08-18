//
//  SideMenuView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/17/23.
//

import SwiftUI

struct SideMenuView: View {
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            HStack {
                Image("male-profile-photo")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 64, height: 64)
                
                VStack(alignment: .leading, spacing: 8){
                    Text(user.fullName)
                        .font(.system(size: 16, weight: .semibold))
                    
                    Text(user.email)
                        .font(.system(size: 14))
                        .tint(Color.theme.primaryTextColor)
                        .opacity(0.77)
                }
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Do more with your account")
                    .font(.footnote)
                    .fontWeight(.semibold)
                
                HStack {
                    Image(systemName: "dollarsign.square")
                        .font(.title2)
                        .imageScale(.medium)
                    
                    Text("Make money driving")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(6)
                }
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 32) {
                ForEach(SideMenuOptionViewModel.allCases) { viewModel in
                    NavigationLink(value: viewModel) {
                        SideMenuOption(viewModel: viewModel)
                    }
                }
            }
            .navigationDestination(for: SideMenuOptionViewModel.self) { viewModel in
                Text(viewModel.title)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
        .padding(.top, 32)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(user: User(fullName: "Test User", email: "test@g.com", uid: ""))
    }
}
