//
//  BudgetListView.swift
//  BudgetsApp
//
//  Created by  Vladyslav Fil on 17.03.2023.
//

import SwiftUI

struct BudgetListView: View {
    
    let budgetCategoryResults: FetchedResults<BudgetCategory>
    let onDeleteBudgetCategory: (BudgetCategory) -> Void
    let onEditBudgetCategory: (BudgetCategory) -> Void
    
    var body: some View {
        List {
            if !budgetCategoryResults.isEmpty {
                ForEach(budgetCategoryResults) { budgetCategory in
                    NavigationLink(value: budgetCategory) {
                        HStack {
                            Text(budgetCategory.title ?? "")
                            Spacer()
                            VStack(alignment: .trailing, spacing: 10) {
                                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                                
                                Text("\(budgetCategory.overSpent ? "Overspent" : "Remaining") \(Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .fontWeight(.bold)
                                    .foregroundColor(budgetCategory.overSpent ? .red : .green)
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                onDeleteBudgetCategory(budgetCategory)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            
                            Button("Edit") {
                                onEditBudgetCategory(budgetCategory)
                            }
                            .tint(.green)
                        }
                    }
                }
            } else {
                Text("No budget categorirs exist")
            }
        }
        .navigationDestination(for: BudgetCategory.self) { category in
            BudgetDetailView(budgetCategory: category)
        }
    }
}
