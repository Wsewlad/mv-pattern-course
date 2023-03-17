//
//  ContentView.swift
//  BudgetsApp
//
//  Created by  Vladyslav Fil on 17.03.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults: FetchedResults<BudgetCategory>
    
    @State private var isAddCategoryPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .fontWeight(.bold)
                
                BudgetListView(
                    budgetCategoryResults: budgetCategoryResults,
                    onDeleteBudgetCategory: deleteBudgetCategory
                )
            }
            .sheet(isPresented: $isAddCategoryPresented) {
                AddBudgetCategoryView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Category") { isAddCategoryPresented = true }
                }
            }
        }
    }
}

//MARK: - ComputedProperties and Functions
private extension ContentView {
    var total: Double {
        budgetCategoryResults.reduce(0) { partialResult, budgetCategory in
            partialResult + budgetCategory.total
        }
    }
    
    func deleteBudgetCategory(_ category: BudgetCategory) {
        viewContext.delete(category)
        do { try viewContext.save() }
        catch { print(error.localizedDescription) }
    }
}

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
    }
}
