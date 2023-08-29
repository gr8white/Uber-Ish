//
//  HomeView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/4/23.
//

import SwiftUI

struct HomeView: View {
    @State private var mapViewState: MapViewState = .noInput
    @State private var showSideMenu: Bool = false
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LandingView()
            } else if let user = authViewModel.currentUser {
                NavigationStack {
                    ZStack {
                        if showSideMenu {
                            SideMenuView(user: user)
                        }
                        
                        mapView
                            .offset(x: showSideMenu ? 316: 0)
                            .shadow(color: showSideMenu ? .black : .clear, radius: 10)
                    }
                    .onAppear {
                        showSideMenu = false
                    }
                }
            }
        }
    }
}

extension HomeView {
    var mapView: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                UberMapViewRepresentable(mapViewState: $mapViewState)
                    .ignoresSafeArea()
                
                if mapViewState == .searchingForLocation {
                    LocationSearchView()
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
                
                MapViewActionButton(mapViewState: $mapViewState, showSideMenu: $showSideMenu)
                    .padding(.leading)
                    .padding(.top, 4)
            }
            if let user = authViewModel.currentUser {
                if user.accountType == .passenger {
                    if mapViewState == .locationSelected || mapViewState == .polylineAdded {
                        RideRequestView()
                            .transition(.move(edge: .bottom))
                    } else if mapViewState == .rideRequested {
                        RideLoadingView()
                            .transition(.move(edge: .bottom))
                    } else if mapViewState == .rideAccepted {
                        RideAcceptedView()
                            .transition(.move(edge: .bottom))
                    } else if mapViewState == .rideRejected {
                        
                    }
                } else {
                    if let ride = homeViewModel.ride {
                        AcceptRideView(ride: ride)
                            .transition(.move(edge: .bottom))
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation) { location in
            homeViewModel.userLocation = location
        }
        .onReceive(homeViewModel.$selectedUberLocation) { location in
            if location != nil {
                self.mapViewState = .locationSelected
            }
        }
        .onReceive(homeViewModel.$ride) { ride in
            guard let ride = ride else { return }
            
            withAnimation(.spring()) {
                switch ride.state {
                case .requested: self.mapViewState = .rideRequested
                case .rejected: self.mapViewState = .rideRejected
                case .accepted: self.mapViewState = .rideAccepted
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthenticationViewModel())
    }
}
