//
//  LocationSearchViewModel.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/7/23.
//

import Foundation
import MapKit

enum LocationResultsViewConfig {
    case ride
    case saveLocation
}

class LocationSearchViewModel: NSObject, ObservableObject {
    @Published var results: [MKLocalSearchCompletion] = []
    @Published var selectedUberLocation: UberIshLocation?
    @Published var pickUpTime: String?
    @Published var dropOffTime: String?
    private let searchCompleter = MKLocalSearchCompleter()
    var userLocation: CLLocationCoordinate2D?
    
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    func selectLocation(_ selectedLocation: MKLocalSearchCompletion, config: LocationResultsViewConfig) {
        switch config {
        case .ride:
            getInfo(forLocalSearhCompletion: selectedLocation) { response, error in
                if let error = error {
                    print("DEBUG: Local search failed with error: \(error.localizedDescription)")
                    return
                }
                
                guard let item = response?.mapItems.first else { return }
                
                self.selectedUberLocation = UberIshLocation(title: selectedLocation.title, coordinate: item.placemark.coordinate)
            }
        case .saveLocation:
            print(selectedLocation)
        }
    }
    
    func getInfo(forLocalSearhCompletion localSearch: MKLocalSearchCompletion, completion: @escaping  MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    
    func computeRidePrice(for type: RideType) -> Double {
        guard let coordinate = selectedUberLocation?.coordinate, let userLocation = self.userLocation else { return 0.0 }
        
        let userCoordinates = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        
        let destinationCoordinates = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let tripDistanceInMeters = userCoordinates.distance(from: destinationCoordinates)
        return type.computePrice(for: tripDistanceInMeters)
    }
    
    func getDestinationRoute(
        from userLocation: CLLocationCoordinate2D,
        to destination: CLLocationCoordinate2D,
        completion: @escaping (MKRoute) -> Void
    ) {
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if let error = error {
                print("DEBUG: Local search failed with error: \(error.localizedDescription)")
                return
            }
            
            guard let route = response?.routes.first else { return }
            self.configurePickupAndDropoffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configurePickupAndDropoffTimes(with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        pickUpTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expectedTravelTime)
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
