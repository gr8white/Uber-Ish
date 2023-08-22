//
//  DeveloperPreview.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/22/23.
//

import Foundation
import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DeveloperPreview {
        DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let mockUser = User(
        fullName: "Test User",
        email: "test@g.com",
        uid: "",
        coordinates: GeoPoint(latitude: 37.785834, longitude: -122.406417),
        accountType: .passenger
    )
}
