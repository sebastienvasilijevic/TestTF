//
//  String+Extensions.swift
//  TestTheFork
//
//  Created by VASILIJEVIC Sebastien on 15/10/2021.
//

import Foundation

// MARK: - String
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func getCurrencySymbol() -> String {
        var symbol: String = ""
        switch self {
        case "EUR":
            symbol = "€"
            break
        case "USD":
            symbol = "$"
            break
        default: break
        }
        return symbol
    }
}
