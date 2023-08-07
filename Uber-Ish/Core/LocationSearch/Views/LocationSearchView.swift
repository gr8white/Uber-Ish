//
//  LocationSearchView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/7/23.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var destinationLocationText: String = ""
    @State private var startLocationText: String = ""
    
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
                        .background(Color(
                        .systemGroupedBackground))
                    
                    TextField("Where to?", text: $destinationLocationText)
                        .frame(height: 32)
                        .background(Color(
                        .systemGray4))
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<20, id: \.self) { _ in
                        LocationSearchResultCell()
                    }
                }
            }
        }
        .background(.white)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}
