//
//  RideCancelledView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 9/2/23.
//

import SwiftUI

struct RideCancelledView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 12)
            
            Text(homeViewModel.rideCancelledMessage)
                .font(.headline)
                .padding(.vertical)
            
            Button {
                homeViewModel.deleteRide()
            } label: {
                Text("OK")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(Color(.blue))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
        .padding(.bottom, 32)
        .frame(maxWidth: .infinity)
        .background(Color.theme.backgroundcolor)
        .cornerRadius(32)
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 10)
    }
}

struct RideCancelledView_Previews: PreviewProvider {
    static var previews: some View {
        RideCancelledView()
    }
}
