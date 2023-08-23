//
//  DriverAnnotation.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/22/23.
//

import MapKit
import Firebase

class DriverAnnotation: NSObject, MKAnnotation {
    var uid: String
    var coordinate: CLLocationCoordinate2D
    
    init(driver: User) {
        self.uid = driver.uid
        self.coordinate = CLLocationCoordinate2D(latitude: driver.coordinates.latitude,
                                                 longitude: driver.coordinates.longitude)
    }
    
    
}
