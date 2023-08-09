//
//  HomeView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/4/23.
//

import SwiftUI

struct HomeView: View {
    @State private var mapViewState: MapViewState = .noInput
    
    var body: some View {
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
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
