//
//  AddBudgetCategoryView.swift
//  BudgetsApp
//
//  Created by  Vladyslav Fil on 17.03.2023.
//

import SwiftUI

struct AddBudgetCategoryView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if isFormValid {
                            save()
                        }
                    }
                }
            }
        }
    }
}

//MARK: - Functions
private extension AddBudgetCategoryView {
    func save() {
        let budgetCategory = BudgetCategory(context: viewContext)
        budgetCategory.title = title
        budgetCategory.total = total
        
        do {
            try viewContext.save()
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
