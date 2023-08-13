//
//  Double.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/11/23.
//

import Foundation

extension Double {
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    func toCurrency() -> String {
        return currencyFormatter.string(for: self) ?? ""
    }
}
