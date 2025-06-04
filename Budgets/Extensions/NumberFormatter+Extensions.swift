//
//  NumberFormatter+Extensions.swift
//  Budgets
//
//  Created by Kamila Sultanova on 04.06.2025.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
