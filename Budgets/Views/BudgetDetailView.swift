//
//  BudgetDetailView.swift
//  Budgets
//
//  Created by Kamila Sultanova on 04.06.2025.
//

import SwiftUI

struct BudgetDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let budgetCategory: BudgetCategory
    
    @State private var title: String = ""
    @State private var total: String = ""
    
    var isFormValid: Bool {
        guard let totalAsDouble = Double(total) else { return false }
        return !title.isEmpty && !total.isEmpty && totalAsDouble > 0
    }
    
    private func saveTransaction() {
        do{
            let transaction = Transaction(context: viewContext)
            transaction.title = title
            transaction.total = Double(total)!
            
            budgetCategory.addToTransactions(transaction)
            try viewContext.save()
            
            title = ""
            total = ""
        }catch{
            print(error.localizedDescription)
        }
    }
    
    private func deleteTransaction(_ transaction: Transaction) {
        viewContext.delete(transaction)
        do{
            try viewContext.save()
        }catch{
            print(error.localizedDescription)
        }
    }

    var body: some View {
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading){
                    Text(budgetCategory.title ?? "")
                        .font(.largeTitle)
                    HStack{
                        Text("Budget:")
                        Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                    }
                    .fontWeight(.bold)
                }
            }
            Form{
                Section{
                    TextField("Title", text: $title)
                    TextField("Total", text: $total)
                }header: {
                    Text("Add Transaction")
                }
                
                HStack {
                    Spacer()
                    Button("Save Transaction") {
                        saveTransaction()
                    }.disabled(!isFormValid)
                    Spacer()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .frame(maxHeight: 300)
            .padding([.bottom], 20)
            
            VStack {
                //display summary budget category
                BudgetSummaryView(budgetCategory: budgetCategory)
                //display the transactions
                
                TransactionListView(request: BudgetCategory.transactionsByCategoryRequest(budgetCategory), onDeleteTransaction: deleteTransaction)
            }.clipShape(RoundedRectangle(cornerRadius: 12))
          
            Spacer()
        }.padding()
    }
}


#Preview {
    BudgetDetailView(budgetCategory: BudgetCategory())
}
