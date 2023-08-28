//
//  UberIshLocation.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/12/23.
//

import Foundation
import CoreLocation

struct UberIshLocation: Identifiable {
    var id = NSUUID().uuidString
    let title: String
    let coordinate: CLLocationCoordinate2D
}
