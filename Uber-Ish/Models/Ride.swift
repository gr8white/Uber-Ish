//
//  Ride.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/25/23.
//

import Firebase
import FirebaseFirestoreSwift

struct Ride: Identifiable, Codable {
    @DocumentID var rideId: String?
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
    var state: RideState
    
    var id: String {
        return rideId ?? ""
    }
}

enum RideState: Int, Codable {
    case requested
    case rejected
    case accepted
}
