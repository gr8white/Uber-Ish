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
    @EnvironmentObject var viewModel: LocationSearchViewModel
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
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
            
            if mapViewState == .locationSelected || mapViewState == .polylineAdded {
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation) { location in
            viewModel.userLocation = location
        }
        .onReceive(viewModel.$selectedUberLocation) { location in
            if location != nil {
                self.mapViewState = .locationSelected
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LocationSearchViewModel())
            .environmentObject(AuthenticationViewModel())
    }
}
