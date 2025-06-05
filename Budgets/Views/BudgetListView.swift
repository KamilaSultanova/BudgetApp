//
//  BudgetListView.swift
//  Budgets
//
//  Created by Kamila Sultanova on 04.06.2025.
//

import SwiftUI

struct BudgetListView: View {
    
    let budgetCategoryResults: FetchedResults<BudgetCategory>
    let onDeleteCategory: (BudgetCategory) -> Void
    
    var body: some View {
        List {
            
            if !budgetCategoryResults.isEmpty{
                
                ForEach(budgetCategoryResults) {
                    budgetCategory in
                    NavigationLink(value: budgetCategory){
                        HStack {
                            Text(budgetCategory.title ?? "")
                            Spacer()
                            VStack(alignment: .trailing, spacing: 10){
                                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                                Text("\(budgetCategory.overspent ? "Overspent" : "Remaining") \(Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .fontWeight(.bold)
                                    .foregroundColor(budgetCategory.overspent ? .red : .green)
                            }
                        }
                    }
                }.onDelete { indexSet in
                    indexSet.map { budgetCategoryResults[$0]}.forEach(onDeleteCategory)
                }
            }else{
                Text("No budget category exists.")
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: BudgetCategory.self) {
            budgetCategory in
            BudgetDetailView(budgetCategory: budgetCategory)
        }
    }
}
