//
//  SavedLocationViewModel.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/18/23.
//

import Foundation

enum SavedLocationViewModel: Int, CaseIterable, Identifiable {
    case home
    case work
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .work: return "Work"
        }
    }
    
    var iconName: String {
        switch self {
        case .home: return "house.circle.fill"
        case .work: return "archivebox.circle.fill"
        }
    }
    
    var subtitle: String {
        switch self {
        case .home: return "Add Home"
        case .work: return "Add Work"
        }
    }
    
    var databaseKey: String {
        switch self {
        case .home: return "homeLocation"
        case .work: return "workLocation"
        }
    }
    
    var id: Int { return self.rawValue }
    
    func subtitleFor(user: User) -> String {
        switch self {
        case .home:
            return user.homeLocation?.title ?? subtitle
        case .work:
            return user.workLocation?.title ?? subtitle
        }
    }
}
