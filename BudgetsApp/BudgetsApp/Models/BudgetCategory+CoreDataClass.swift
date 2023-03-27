//
//  BudgetCategory+CoreDataClass.swift
//  BudgetsApp
//
//  Created by  Vladyslav Fil on 17.03.2023.
//

import Foundation
import CoreData

@objc(BudgetCategory)
public class BudgetCategory: NSManagedObject {
    
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
    
    static func transactionsByCategoryRequest(_ budgetCategory: BudgetCategory) -> NSFetchRequest<Transaction> {
        let request = Transaction.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "dateCreated", ascending: false)
        ]
        request.predicate = NSPredicate(format: "category = %@", budgetCategory)
        return request
    }
}
