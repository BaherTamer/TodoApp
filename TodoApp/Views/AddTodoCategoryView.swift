//
//  AddTodoCategoryView.swift
//  TodoApp
//
//  Created by Baher Tamer on 25/11/2022.
//

import SwiftUI

struct AddTodoCategoryView: View {

    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext

    @State private var icon: String = "📝"
    @State private var name: String = ""
    @State private var categoryColor: CategoryColor = .blue

    private let screenWidth = UIScreen.main.bounds.size.width
    private var todoCategoryToEdit: TodoCategory?

    init(todoCategoryToEdit: TodoCategory? = nil) {
        self.todoCategoryToEdit = todoCategoryToEdit
    }

    private func saveAddCategory() {
        if let todoCategoryToEdit {
            saveCategory(categoryToEdit: todoCategoryToEdit)
        } else {
            addCategory()
        }
    }

    private func addCategory() {
        let newCategory = TodoCategory(context: viewContext)

        if name.isEmpty {
            newCategory.name = "New Category"
        } else {
            newCategory.name = name
        }

        if icon.isEmpty {
            newCategory.icon = "📝"
        } else {
            newCategory.icon = icon
        }

        newCategory.color = categoryColor.rawValue

        saveContext()
    }

    private func saveCategory(categoryToEdit: TodoCategory) {
        let updatedCategory = TodoCategory.getTodoCategoryById(categoryToEdit.objectID)

        updatedCategory.name = name
        updatedCategory.icon = icon
        updatedCategory.color = categoryColor.rawValue

        saveContext()
    }

    private func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    EmojiTextField(text: $icon).accentColor(.clear)
                        .offset(x: 38)
                        .scaleEffect(2.2)
                        .frame(width: 100, height: 100)
                        .background(categoryColor.color.gradient)
                        .clipShape(Circle())
                        .frame(maxWidth: .infinity, alignment: .center)
                        .onTapGesture {
                            icon = ""
                        }
                        .onChange(of: icon) { _ in
                            if icon.count == 1 {
                                hideKeyboard()
                            }
                        }

                    TextField("List Name", text: $name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                }
                .listRowSeparator(.hidden)

                Section {
                    SelectingColors(categoryColor: $categoryColor)
                }
            }
            .navigationTitle("Add Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(todoCategoryToEdit != nil ? "Save" : "Add") {
                        saveAddCategory()
                        dismiss()
                    }
                }
            }
        }.onAppear {
            if let todoCategoryToEdit {
                icon = todoCategoryToEdit.icon!
                name = todoCategoryToEdit.name!

                for color in CategoryColor.allCases {
                    if color.rawValue == todoCategoryToEdit.color {
                        categoryColor = color
                    }
                }
            }
        }
    }
}

struct AddTodoCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoCategoryView()
            .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
    }
}
