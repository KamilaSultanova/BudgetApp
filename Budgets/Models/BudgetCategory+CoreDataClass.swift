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
}
