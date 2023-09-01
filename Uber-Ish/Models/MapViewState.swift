//
//  MapViewState.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/8/23.
//

import Foundation

enum MapViewState {
    case noInput
    case searchingForLocation
    case locationSelected
    case polylineAdded
    case rideRequested
    case rideRejected
    case rideAccepted
}
