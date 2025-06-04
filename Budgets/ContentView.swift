//
//  ContentView.swift
//  Budgets
//
//  Created by Kamila Sultanova on 04.06.2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults:
    FetchedResults<BudgetCategory>
    @State private var isPresented: Bool = false
    
    var grandTotal: Double {
        budgetCategoryResults.reduce(0) { result, budgetCategory in
            return result + budgetCategory.total
        }
    }
    
    private func deleteBudgetCategory(budgetCategory: BudgetCategory) {
        viewContext.delete(budgetCategory)
        do{
            try viewContext.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    var body: some View {
        NavigationStack {
            VStack {
                Text(grandTotal as NSNumber, formatter: NumberFormatter.currency)
                    .fontWeight(.bold)
                BudgetListView(budgetCategoryResults: budgetCategoryResults, onDeleteCategory: deleteBudgetCategory)
            }.sheet(isPresented: $isPresented, content: {
                AddBudgetCategoryView()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add category") {
                        isPresented = true
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
}
