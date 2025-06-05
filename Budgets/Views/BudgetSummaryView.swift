//
//  BudgetSummaryView.swift
//  Budgets
//
//  Created by Kamila Sultanova on 05.06.2025.
//

import SwiftUI

struct BudgetSummaryView: View {
    
    @ObservedObject var budgetCategory: BudgetCategory
    
    var body: some View {
        VStack{
            Text("\(budgetCategory.overspent ? "Overspent" : "Remaining") \(Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                .frame(maxWidth: .infinity)
                .fontWeight(.bold)
                .foregroundColor(budgetCategory.overspent ? .red : .green)
        }
    }
}

