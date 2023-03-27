//
//  AddBudgetCategoryView.swift
//  BudgetsApp
//
//  Created by  Vladyslav Fil on 17.03.2023.
//

import SwiftUI

struct AddBudgetCategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    private var category: BudgetCategory?
    
    init(category: BudgetCategory? = nil) {
        self.category = category
    }
    
    @State private var title: String = ""
    @State private var total: Double = 100
    
    @State private var errors: [String] = []
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                Slider(value: $total, in: 0...500, step: 50) {
                    Text("Total")
                } minimumValueLabel: {
                    Text("$0")
                } maximumValueLabel: {
                    Text("$500")
                }
                
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ForEach(errors, id: \.self) { error in
                    Text(error)
                        .foregroundColor(.red)
                }
            }
            .onAppear(perform: onAppear)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if isFormValid {
                            saveOrUpdate()
                        }
                    }
                }
            }
        }
    }
}

//MARK: - Functions
private extension AddBudgetCategoryView {
    func onAppear() {
        if let budgetCategory = category {
            title = budgetCategory.title ?? ""
            total = budgetCategory.total
        }
    }
    
    func saveOrUpdate() {
        if let category {
            category.title = title
            category.total = total
        } else {
            let budgetCategory = BudgetCategory(context: viewContext)
            budgetCategory.title = title
            budgetCategory.total = total
        }
        do {
            try viewContext.save()
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

//MARK: - Validation
private extension AddBudgetCategoryView {
    var isFormValid: Bool {
        
        errors.removeAll()
        
        if title.isEmpty {
            errors.append("Title is required")
        }
        
        if total <= 0 {
            errors.append("Total should be greater than 0")
        }
        
        return errors.isEmpty
    }
}

struct AddBudgetCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetCategoryView()
    }
}
