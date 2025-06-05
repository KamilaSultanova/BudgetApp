//
//  BudgetCategory+CoreDataClass.swift
//  Budgets
//
//  Created by Kamila Sultanova on 04.06.2025.
//
import Foundation
import CoreData

@objc(BudgetCategory)
public class BudgetCategory: NSManagedObject {
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
    
    static var all: NSFetchRequest<BudgetCategory> {
        let request = BudgetCategory.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        return request
    }
    
    var transactionsTotal: Double {
        transactionsArray.reduce(0) { result, transaction in
            result + transaction.total
        }
    }
    
    var remainingBudgetTotal: Double {
        self.total - transactionsTotal
    }
    
    var overspent: Bool {
        remainingBudgetTotal < 0
    }
    
    private var transactionsArray: [Transaction] {
        guard let transaction = transactions else { return [] }
        let allTransactions = (transactions?.allObjects as? [Transaction]) ?? []
        return allTransactions.sorted { t1, t2 in
            t1.dateCreated! > t2.dateCreated!
        }
    }
    
    static func transactionsByCategoryRequest(_ budgetCategory: BudgetCategory) -> NSFetchRequest<Transaction> {
        let request = Transaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        request.predicate = NSPredicate(format: "category = %@", budgetCategory)
        return request
    }
    
    static func byId(_ id: NSManagedObjectID) -> BudgetCategory {
        let vc = CoreDataManager.shared.viewContext
        guard let budgetCategory = vc.object(with: id) as? BudgetCategory else { fatalError("Id not found")}
        return budgetCategory
    }
}
