//
//  SettingsView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/18/23.
//

import SwiftUI

struct SettingsView: View {
    private let user: User
    
    enum SettingsOptions: CaseIterable {
        case notifications
        case paymentMethods
        case createDrivingAccount
        case signOut
        
        static var settingsSection: [SettingsOptions] = [.notifications, .paymentMethods]
        
        static var accountSection: [SettingsOptions] = [.createDrivingAccount, .signOut]
        
        var title: String {
            switch self {
            case .notifications: return "Notifications"
            case .paymentMethods: return "Payment Methods"
            case .createDrivingAccount: return "Make Money Driving"
            case .signOut: return "Sign Out"
            }
        }
        
        var iconName: String {
            switch self {
            case .notifications: return "bell.circle.fill"
            case .paymentMethods: return "creditcard.circle.fill"
            case .createDrivingAccount: return "dollarsign.square.fill"
            case .signOut: return "arrow.left.square.fill"
            }
        }
        
        var iconColor: Color {
            switch self {
            case .notifications: return Color(.systemPurple)
            case .paymentMethods: return Color(.systemBlue)
            case .createDrivingAccount: return Color(.systemGreen)
            case .signOut: return Color(.systemRed)
            }
        }
    }
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        VStack {
            List {
                Section {
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
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
                
                Section("Favorites") {
                    SavedLocationRowView(iconName: "house.circle.fill", title: "Home", subtitle: "Add Home")
                    
                    SavedLocationRowView(iconName: "archivebox.circle.fill", title: "Work", subtitle: "Add Work")
                }
                
                Section("Settings") {
                    ForEach(SettingsOptions.settingsSection, id: \.self) { option in
                        SettingsRowView(iconName: option.iconName, iconColor: option.iconColor, title: option.title)
                    }
                }
                
                Section("Account") {
                    ForEach(SettingsOptions.accountSection, id: \.self) { option in
                        SettingsRowView(iconName: option.iconName, iconColor: option.iconColor, title: option.title)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(user: User(fullName: "Test User", email: "test@g.com", uid: ""))
    }
}
