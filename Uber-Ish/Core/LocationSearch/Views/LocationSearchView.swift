//
//  LocationSearchView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/7/23.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var startLocationText: String = ""
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                
                VStack {
                    TextField("Current Location", text: $startLocationText)
                        .frame(height: 32)
                        .padding(.leading)
                        .background(Color(.systemGroupedBackground))
                    
                    TextField("Where to?", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .padding(.leading)
                        .background(Color(.systemGray4))
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)
            
            LocationSearchResultsView(viewModel: viewModel, config: .ride)
        }
        .background(Color.theme.backgroundcolor)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
            .environmentObject(LocationSearchViewModel())
    }
}
