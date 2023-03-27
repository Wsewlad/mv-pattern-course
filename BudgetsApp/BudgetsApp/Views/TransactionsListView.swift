//
//  TransactionsListView.swift
//  BudgetsApp
//
//  Created by  Vladyslav Fil on 17.03.2023.
//

import SwiftUI
import CoreData

struct TransactionsListView: View {
    
    @FetchRequest var transactions: FetchedResults<Transaction>
    var onDeleteTransaction: (Transaction) -> Void
    
    init(
        request: NSFetchRequest<Transaction>,
        onDeleteTransaction: @escaping (Transaction) -> Void
    ) {
        _transactions = FetchRequest(fetchRequest: request)
        self.onDeleteTransaction = onDeleteTransaction
    }
    
    var body: some View {
        if transactions.isEmpty {
            Text("No transactions.")
        } else {
            List {
                ForEach(transactions) { transaction in
                    HStack {
                        Text(transaction.title ?? "")
                        Spacer()
                        Text(transaction.total as NSNumber, formatter: NumberFormatter.currency)
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { transactions[$0] }.forEach(onDeleteTransaction)
                }
            }
        }
    }
}
