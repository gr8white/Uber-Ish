//
//  Ride.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/25/23.
//

import Foundation
import Firebase

struct Ride: Identifiable, Codable {
    let id: String
    let passengerUid: String
    let passengerName: String
    let passengerLocation: GeoPoint
    let driverUid: String
    let driverName: String
    let driverLocation: GeoPoint
    let pickupLocationName: String
    let pickupLocation: GeoPoint
    let pickupLocationAddress: String
    let dropoffLocationName: String
    let dropoffLocation: GeoPoint
    let tripCost: Double
    
    var distanceToPassenger: Double?
    var travelTime: Int?
}
