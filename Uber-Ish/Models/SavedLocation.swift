//
//  SavedLocation.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/19/23.
//

import Foundation
import Firebase

struct SavedLocation: Codable {
    let title: String
    let address: String
    let coordinates: GeoPoint
}
