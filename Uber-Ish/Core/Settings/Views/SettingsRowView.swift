//
//  SettingsRowView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/18/23.
//

import SwiftUI

struct SettingsRowView: View {
    let iconName: String
    let iconColor: Color
    let title: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: iconName)
                .imageScale(.medium)
                .font(.title)
                .foregroundColor(iconColor)
            
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(Color.theme.primaryTextColor)
        }
        .padding(4)
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(iconName: "bell.circle.fill", iconColor: Color(.systemPurple), title: "Notifications")
            .previewLayout(.sizeThatFits)
    }
}
