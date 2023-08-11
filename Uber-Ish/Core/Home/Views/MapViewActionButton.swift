//
//  MapViewActionButton.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/7/23.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapViewState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
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
            print("no input")
        case .searchingForLocation, .locationSelected:
            mapViewState = .noInput
            viewModel.selectedLocationCoordinate = nil
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation, .locationSelected:
            return "arrow.left"
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapViewState: .constant(.noInput))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
