//
//  RideAcceptedView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/28/23.
//

import SwiftUI

struct RideAcceptedView: View {
    var body: some View {
        VStack {
            Text("Your driver is on the way")
                .padding()
        }
        .background(Color.theme.backgroundcolor)
        .cornerRadius(32)
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 10)
    }
}

struct RideAcceptedView_Previews: PreviewProvider {
    static var previews: some View {
        RideAcceptedView()
    }
}
