//
//  Transaction+CoreDataClass.swift
//  Budgets
//
//  Created by Kamila Sultanova on 04.06.2025.
//

import Foundation
import CoreData

@objc(Transaction)
public class Transaction: NSManagedObject {
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
}
