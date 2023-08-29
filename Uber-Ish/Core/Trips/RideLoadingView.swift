//
//  RideLoadingView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/28/23.
//

import SwiftUI

struct RideLoadingView: View {
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 12)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Finding you a ride")
                        .font(.headline)
                    
                    Text("Arriving at 1:30 PM")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                }
                
                Spacer()
                
                LoadingSpinner(lineWidth: 6, height: 64, width: 64)
            }
            .padding()
            .padding(.bottom, 24)
        }
        .background(Color.theme.backgroundcolor)
        .cornerRadius(32)
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 10)
    }
}

struct RideLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        RideLoadingView()
    }
}
