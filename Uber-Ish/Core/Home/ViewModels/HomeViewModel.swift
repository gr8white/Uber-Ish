//
//  HomeViewModel.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/22/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine
import MapKit

class HomeViewModel: NSObject, ObservableObject {
    // MARK: - Properties
    @Published var drivers: [User] = []
    @Published var currentUser: User?
    
    private let userService = UserService.shared
    private var cancellables = Set<AnyCancellable>()
    
    //Location Search Properties
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
    
    // MARK: - Initializer
    override init() {
        super.init()
        fetchUser()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    // MARK: - User API
    
    func fetchDrivers () {
        Firestore.firestore().collection("users")
            .whereField("accountType", isEqualTo: AccountType.driver.rawValue)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let drivers = documents.compactMap({ try? $0.data(as: User.self)})
                
                self.drivers = drivers
            }
    }
    
    func fetchUser() {
        userService.$user
            .sink { user in
                guard let user = user else { return }
                self.currentUser = user
                guard user.accountType == .passenger else { return }
                self.fetchDrivers()
            }
            .store(in: &cancellables)
    }
}

extension HomeViewModel {
    func selectLocation(_ selectedLocation: MKLocalSearchCompletion, config: LocationResultsViewConfig) {
        getInfo(forLocalSearhCompletion: selectedLocation) { response, error in
            if let error = error {
                print("DEBUG: Local search failed with error: \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            
            switch config {
            case .ride:
                self.selectedUberLocation = UberIshLocation(title: selectedLocation.title, coordinate: coordinate)
            case .saveLocation(let viewModel):
                guard let uid = Auth.auth().currentUser?.uid else { return }
                
                let savedLocation = SavedLocation(title: selectedLocation.title, address: selectedLocation.subtitle, coordinates: GeoPoint(latitude: coordinate.latitude, longitude: coordinate.longitude))
                
                guard let encodedLocation = try? Firestore.Encoder().encode(savedLocation) else { return }
                
                Firestore.firestore().collection("users").document(uid).updateData([
                    viewModel.databaseKey: encodedLocation
                ])
            }
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

extension HomeViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
