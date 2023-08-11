//
//  RideRequestView.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/9/23.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType: RideType = .uberX
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 12)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 12) {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                    
                    Text("Current Location")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text("1:30 PM")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray)
                }
                
                Rectangle()
                    .fill(Color(.systemGray3))
                    .frame(width: 1, height: 32)
                    .padding(.leading, 3)
                
                HStack(alignment: .center, spacing: 12) {
                    Rectangle()
                        .fill(.black)
                        .frame(width: 8, height: 8)
                    
                    Text("Coffee Lovers")
                        .font(.system(size: 16, weight: .semibold))
                    
                    Spacer()
                    
                    Text("1:37 PM")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            Divider()
            
            Text("Suggested Rides")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(RideType.allCases) { type in
                        VStack(alignment: .leading) {
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(type.description)
                                    .font(.system(size: 14, weight: .semibold))
                                
                                Text("$22.45")
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding()
                        }
                        .frame(width: 112, height: 140)
                        .foregroundColor(type == selectedRideType ? .white : .black)
                        .background(Color(type == selectedRideType ? .systemBlue: .systemGroupedBackground))
                        .scaleEffect(type == selectedRideType ? 1.2 : 1.0)
                        .cornerRadius(10)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedRideType = type
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
                .padding(.vertical, 8)
            
            HStack(spacing: 12) {
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .padding(.leading)
                    .foregroundColor(.white)
                
                Text("**** 1234")
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding(.trailing)
            }
            .frame(height: 50)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            
            Button {
                
            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(Color(.blue))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
        .padding(.bottom, 32)
        .background(.white)
        .cornerRadius(32)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
            .previewLayout(.sizeThatFits)
    }
}
