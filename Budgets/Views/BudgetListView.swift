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
        if !budgetCategoryResults.isEmpty{
            List {
                ForEach(budgetCategoryResults) {
                    budgetCategory in
                    HStack {
                        Text(budgetCategory.title ?? "")
                        Spacer()
                        VStack{
                            Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                        }
                    }
                }.onDelete { indexSet in
                    indexSet.map { budgetCategoryResults[$0]}.forEach(onDeleteCategory)
                }
            }
        }else{
            Text("No budget category exists.")
        }
    }
}
