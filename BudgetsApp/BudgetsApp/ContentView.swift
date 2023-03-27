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
    
    @FetchRequest(fetchRequest: BudgetCategory.all) private var budgetCategoryResults
    
    @State private var sheetAction: SheetActions? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Total Budget - ")
                    Text(total as NSNumber, formatter: NumberFormatter.currency)
                        .fontWeight(.bold)
                }
                
                BudgetListView(
                    budgetCategoryResults: budgetCategoryResults,
                    onDeleteBudgetCategory: deleteBudgetCategory,
                    onEditBudgetCategory: editBudgetCategory
                )
            }
            .sheet(item: $sheetAction) { action in
                switch action {
                case .add:
                    AddBudgetCategoryView()
                case let .edit(category):
                    AddBudgetCategoryView(category: category)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Category") { sheetAction = .add }
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
    
    func editBudgetCategory(_ category: BudgetCategory) {
        sheetAction = .edit(category)
    }
}

//MARK: - Models
private extension ContentView {
    enum SheetActions: Identifiable {
        var id: String { self.rawValue }
        
        var rawValue: String {
            switch self {
            case .add: return "add"
            case .edit: return "edit"
            }
        }
        
        case add
        case edit(BudgetCategory)
    }
}

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
    }
}
