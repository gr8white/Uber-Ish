//
//  User.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/16/23.
//

import Foundation

struct User: Codable {
    let fullName: String
    let email: String
    let uid: String
    var homeLocation: SavedLocation?
    var workLocation: SavedLocation?
}
