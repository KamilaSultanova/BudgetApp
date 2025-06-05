//
//  ContentView.swift
//  Budgets
//
//  Created by Kamila Sultanova on 04.06.2025.
//

import SwiftUI

enum SheetAction: Identifiable {
   case add
   case edit(BudgetCategory)
 
var id: Int {
  switch self {
     case .add:
  return 1
     case .edit(_):
  return 2
     }
  }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: BudgetCategory.all) var budgetCategoryResults
 
    @State private var sheetAction: SheetAction?
    
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
    
    private func editBudgetCategory(budgetCategory: BudgetCategory) {
        sheetAction = .edit(budgetCategory)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Text("Total Budget:")
                    Text(grandTotal as NSNumber, formatter: NumberFormatter.currency)
                        .fontWeight(.bold)
                }
                BudgetListView(budgetCategoryResults: budgetCategoryResults, onDeleteCategory: deleteBudgetCategory, onEditCategory: editBudgetCategory)
            }
            .sheet(item: $sheetAction, content: { sheetAction in
                switch sheetAction {
                case .add:
                    AddBudgetCategoryView()
                case .edit(let budgetCategory):
                    AddBudgetCategoryView(budgetCategory: budgetCategory)
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add category") {
                        sheetAction = .add
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
