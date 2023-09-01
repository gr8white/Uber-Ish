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
    
    let mockRide = Ride(
        passengerUid: NSUUID().uuidString,
        passengerName: "Derrick",
        passengerLocation: GeoPoint(latitude: 37.785834, longitude: -122.406417),
        driverUid: NSUUID().uuidString,
        driverName: "Sydni",
        driverLocation: GeoPoint(latitude: 37.785834, longitude: -122.406417),
        pickupLocationName: "Apple Campus",
        pickupLocation: GeoPoint(latitude: 37.785834, longitude: -122.406417),
        pickupLocationAddress: "123 Main St.",
        dropoffLocationName: "Starbucks",
        dropoffLocation: GeoPoint(latitude: 37.785834, longitude: -122.406417),
        tripCost: 30.0,
        distanceToPassenger: 1000,
        travelTime: 30,
        state: .requested
    )
}
