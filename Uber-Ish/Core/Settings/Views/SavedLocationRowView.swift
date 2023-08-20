//
//  SavedLocationRowView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/18/23.
//

import SwiftUI

struct SavedLocationRowView: View {
    let viewModel: SavedLocationViewModel
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: viewModel.iconName)
                .imageScale(.medium)
                .font(.title)
                .foregroundColor(Color(.systemBlue))
            
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color.theme.primaryTextColor)
                
                Text(viewModel.subtitleFor(user: user))
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct SettingsOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SavedLocationRowView(viewModel: SavedLocationViewModel.home, user: User(fullName: "Test User", email: "test@g.com", uid: ""))
            .previewLayout(.sizeThatFits)
    }
}
