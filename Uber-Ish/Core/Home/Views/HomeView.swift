//
//  HomeView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/4/23.
//

import SwiftUI

struct HomeView: View {
    @State private var mapViewState: MapViewState = .noInput
    @EnvironmentObject var viewModel: LocationSearchViewModel
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                ZStack(alignment: .bottom) {
                    ZStack(alignment: .top) {
                        UberMapViewRepresentable(mapViewState: $mapViewState)
                            .ignoresSafeArea()
                        
                        if mapViewState == .searchingForLocation {
                            LocationSearchView(mapViewState: $mapViewState)
                        } else if mapViewState == .noInput {
                            LocationSearchActivationView()
                                .padding(.top, 72)
                                .padding(.horizontal, 32)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        mapViewState = .searchingForLocation
                                    }
                                }
                        }
                        
                        MapViewActionButton(mapViewState: $mapViewState)
                            .padding(.leading)
                            .padding(.top, 4)
                    }
                    
                    if mapViewState == .locationSelected || mapViewState == .polylineAdded {
                        RideRequestView()
                            .transition(.move(edge: .bottom))
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                .onReceive(LocationManager.shared.$userLocation) { location in
                    viewModel.userLocation = location
                }
            } else {
                LandingView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
