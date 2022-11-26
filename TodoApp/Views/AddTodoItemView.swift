//
//  AddTodoItemView.swift
//  TodoApp
//
//  Created by Baher Tamer on 26/11/2022.
//

import SwiftUI

struct AddTodoItemView: View {

    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    let addTodoItem: (String) -> Void

    var body: some View {
        NavigationView {
            Form {
                TextField("Todo Title", text: $title)
            }
            .navigationTitle("Add Todo Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        addTodoItem(title)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddTodoItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoItemView(addTodoItem: {_ in})
    }
}
