//
//  SavedLocationSearchView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/19/23.
//

import SwiftUI

struct SavedLocationSearchView: View {
    @StateObject var viewModel = LocationSearchViewModel()
    let config: SavedLocationViewModel
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .imageScale(.medium)
                    .padding(.leading)
                
                TextField("Search for a location...", text: $viewModel.queryFragment)
                    .frame(height: 32)
                    .padding(.leading)
                    .background(Color(.systemGray5))
                    .padding(.trailing)
            }
            .padding(.top)
            
            Spacer()
            
            LocationSearchResultsView(viewModel: viewModel, config: .saveLocation(config))
        }
        .navigationTitle(config.subtitle)
    }
}

struct SavedLocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SavedLocationSearchView(config: .home)
        }
    }
}