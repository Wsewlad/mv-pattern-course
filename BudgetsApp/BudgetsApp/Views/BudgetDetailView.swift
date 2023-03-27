//
//  BudgetDetailView.swift
//  BudgetsApp
//
//  Created by  Vladyslav Fil on 17.03.2023.
//

import SwiftUI
import CoreData

struct BudgetDetailView: View {
    
    let budgetCategory: BudgetCategory
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var title: String = ""
    @State private var total: String = ""
    
    var body: some View {
        VStack {
            Text(budgetCategory.title ?? "")
                .font(.largeTitle)
            HStack {
                Text("Budget:")
                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
            }
            .fontWeight(.bold)
            
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Total", text: $total)
                } header: {
                    Text("Add Transaction")
                }
                
                HStack {
                    Spacer()
                    Button("Save") {
                        createTransaction()
                    }
                    .disabled(!isFormValid)
                    Spacer()
                }
            }
            
            BudgetSummaryView(budgetCategory: budgetCategory)
            
            TransactionsListView(
                request: BudgetCategory.transactionsByCategoryRequest(budgetCategory),
                onDeleteTransaction: deleteTransaction
            )
            
            Spacer()
        }
        .padding()
    }
}

//MARK: - Functions
private extension BudgetDetailView {
    func createTransaction() {
        do {
            let transaction = Transaction(context: viewContext)
            transaction.title = title
            transaction.total = Double(total) ?? 0

            budgetCategory.addToTransactions(transaction)
            
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteTransaction(_ transaction: Transaction) {
        do {
            viewContext.delete(transaction)
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

//MARK: - Validation
private extension BudgetDetailView {
    var isFormValid: Bool {
        guard
            let totalAsDouble = Double(total),
                totalAsDouble > 0,
                !title.isEmpty
        else { return false }
        return true
    }
}

//MARK: - Preview
struct BudgetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetDetailView(budgetCategory: BudgetCategory())
    }
}
