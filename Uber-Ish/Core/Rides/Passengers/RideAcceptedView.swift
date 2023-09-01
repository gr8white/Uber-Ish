//
//  RideAcceptedView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/28/23.
//

import SwiftUI

struct RideAcceptedView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 12)
            
            if let ride = homeViewModel.ride {
                VStack {
                    HStack {
                        Text("Meet your driver at \(ride.pickupLocationName) for your trip to \(ride.dropoffLocationName)")
                            .font(.body)
                            .frame(height: 44)
                            .lineLimit(3)
                            .padding(.trailing)
                        
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
                }
                
                Divider()
                
                VStack {
                    HStack(alignment: .center) {
                        Image("male-profile-photo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(ride.driverName)
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
                        
                        VStack(alignment: .center) {
                            Image("uber-x")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 64)
                            
                            HStack {
                                Text("Mercedes S -")
                                    .foregroundColor(.gray)
                                
                                Text("PKC4518")
                            }
                            .font(.system(size: 14, weight: .semibold))
                            .frame(width: 160)
                        }
                    }
                    
                    Divider()
                }
                .padding()
            }
            
            Button {
                print("cancel ride tapped")
            } label: {
                Text("CANCEL RIDE")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(Color(.red))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            .padding(.bottom, 36)
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
