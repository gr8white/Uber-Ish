//
//  LocationSearchResultsView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/19/23.
//

import SwiftUI

struct LocationSearchResultsView: View {
    @StateObject var viewModel: LocationSearchViewModel
    let config: LocationResultsViewConfig
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(viewModel.results, id: \.self) { result in
                    LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                viewModel.selectLocation(result, config: config)
                            }
                        }
                }
            }
        }
    }
}

struct LocationResultsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultsView(viewModel: LocationSearchViewModel(), config: .ride)
    }
}
