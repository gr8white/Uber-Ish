//
//  PickupPassengerView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/30/23.
//

import SwiftUI

struct PickupPassengerView: View {
    let ride: Ride
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 12)
            
            VStack {
                HStack {
                    Text("Pick up \(ride.passengerName) at \(ride.dropoffLocationName)")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(height: 44)
                    
                    Spacer()
                    
                    VStack {
                        Text("\(ride.travelTime ?? 0)")
                        
                        Text("min")
                    }
                    .frame(width: 56, height: 56)
                    .foregroundColor(.white)
                    .bold()
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                }
                .padding()
                
                Divider()
            }
            
            VStack {
                HStack {
                    Image("male-profile-photo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(ride.passengerName)
                            .fontWeight(.bold)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color(.systemYellow))
                                .imageScale(.small)
                            
                            Text("4.8")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("Earnings")
                        
                        Text(ride.tripCost.toCurrency())
                            .font(.system(size: 24, weight: .semibold))
                    }
                }
                .padding()
                
                Divider()
            }
            
            Button {
                
            } label: {
                Text("CANCEL RIDE")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(Color(.systemRed))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
        .padding(.bottom, 20)
        .background(Color.theme.backgroundcolor)
        .cornerRadius(32)
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 10)
    }
}

struct PickupPassengerView_Previews: PreviewProvider {
    static var previews: some View {
        PickupPassengerView(ride: dev.mockRide)
    }
}
