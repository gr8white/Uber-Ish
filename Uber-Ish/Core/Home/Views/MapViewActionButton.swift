//
//  MapViewActionButton.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/7/23.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapViewState: MapViewState
    @Binding var showSideMenu: Bool
    @EnvironmentObject var viewModel: HomeViewModel
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        Button {
            withAnimation(.spring()) {
                actionForState(mapViewState)
            }
        } label: {
            Image(systemName: imageNameForState(mapViewState))
                .font(.title2)
                .foregroundColor(.black)
                .frame(width: 20, height: 20)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func actionForState(_ state: MapViewState) {
        switch state {
        case .noInput:
            showSideMenu.toggle()
        case .searchingForLocation:
            mapViewState = .noInput
        case .locationSelected, 
                .polylineAdded,
                .rideAccepted,
                .rideRejected,
                .rideRequested,
                .rideCancelledByDriver,
                .rideCancelledByPassenger:
            mapViewState = .noInput
            viewModel.selectedUberLocation = nil
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput:
            return "line.3.horizontal"
        default:
            return "arrow.left"
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapViewState: .constant(.noInput), showSideMenu: .constant(false))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
