//
//  SideMenuView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/17/23.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            HStack {
                Image("male-profile-photo")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 64, height: 64)
                
                VStack(alignment: .leading, spacing: 8){
                    Text("Test User")
                        .font(.system(size: 16, weight: .semibold))
                    
                    Text("test@gmail.com")
                        .font(.system(size: 14))
                        .tint(.black)
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
            
            ForEach(SideMenuOptionViewModel.allCases) { viewModel in
                SideMenuOption(viewModel: viewModel)
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
        SideMenuView()
    }
}
