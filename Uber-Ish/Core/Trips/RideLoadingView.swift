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
            Text("Finding you a ride")
                .padding()
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
