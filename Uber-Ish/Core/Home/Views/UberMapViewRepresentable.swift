//
//  UberMapViewRepresentable.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/4/23.
//

import Foundation
import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @Binding var mapViewState: MapViewState
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch mapViewState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            context.coordinator.addDriversToMap(homeViewModel.drivers)
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinate = locationSearchViewModel.selectedUberLocation?.coordinate {
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyLine(to: coordinate)
            }
            break
        case .polylineAdded:
            break
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension UberMapViewRepresentable {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: UberMapViewRepresentable
        var currentRegion: MKCoordinateRegion?
        var currentUserLocation: CLLocationCoordinate2D?
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.currentUserLocation = userLocation.coordinate
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            self.currentRegion = region
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = .systemBlue
            polylineRenderer.lineWidth = 6
            
            return polylineRenderer
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if let annotation = annotation as? DriverAnnotation {
                let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "driver")
                view.image = UIImage(systemName: "car.fill")
                
                return view
            }
            
            return nil
        }
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            parent.mapView.addAnnotation(annotation)
            parent.mapView.selectAnnotation(annotation, animated: true)
        }
        
        func configurePolyLine(to destinationCoordinate: CLLocationCoordinate2D) {
            guard let currentUserLocation = currentUserLocation else { return }
            
            parent.locationSearchViewModel.getDestinationRoute(from: currentUserLocation, to: destinationCoordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                self.parent.mapViewState = .polylineAdded
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 80, left: 32, bottom: 525, right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        func clearMapViewAndRecenterOnUserLocation() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
        
        func addDriversToMap(_ drivers: [User]) {
            let annotations = drivers.map({ DriverAnnotation(driver: $0) })
            
            self.parent.mapView.addAnnotations(annotations)
        }
    }
}
