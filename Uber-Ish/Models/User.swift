//
//  User.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/16/23.
//

import Foundation
import Firebase

enum AccountType: Int, Codable {
    case passenger
    case driver
}

struct User: Codable {
    let fullName: String
    let email: String
    let uid: String
    var coordinates: GeoPoint
    var accountType: AccountType
    var homeLocation: SavedLocation?
    var workLocation: SavedLocation?
}
