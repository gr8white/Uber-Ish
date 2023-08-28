//
//  GeoPoint.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/28/23.
//

import Firebase
import CoreLocation

extension GeoPoint {
    func toCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
