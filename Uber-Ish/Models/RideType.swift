//
//  RideType.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/11/23.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    case uberX
    case uberBlack
    case uberXL
    
    var id: Int { return rawValue }
    
    var description: String {
        switch self {
        case .uberX: return "UberX"
        case .uberBlack: return "UberBlack"
        case .uberXL: return "UberXL"
        }
    }
    
    var imageName: String {
        switch self {
        case .uberX, .uberXL: return "uber-x"
        case .uberBlack: return "uber-black"
        }
    }
}
