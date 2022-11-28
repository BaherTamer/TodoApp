//
//  CategoryTodoItemsView.swift
//  TodoApp
//
//  Created by Baher Tamer on 26/11/2022.
//

import SwiftUI

struct CategoryTodoItemsView: View {

    @ObservedObject var todoCategory: TodoCategory

    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest var todoItems: FetchedResults<TodoItem>

    @Environment(\.dismiss) var dismiss

    init(todoCategory: TodoCategory) {
        self.todoCategory = todoCategory
        _todoItems = FetchRequest(fetchRequest: TodoCategory.todoItemsByCategoryRequest(todoCategory))
    }

    @State private var showingAddTodoItemView: Bool = false
    @State private var showCompleted: Bool = false
    @State private var showingEditCategoryView: Bool = false

    private func addTodoItem(_ title: String) {
        let newTodoItem = TodoItem(context: viewContext)

        if title.isEmpty {
            newTodoItem.title = "New Todo Item"
        } else {
            newTodoItem.title = title
        }

        todoCategory.addToTodos(newTodoItem)

        saveContext()
    }

    private func updateTodoItemState(_ todoItem: TodoItem) {
        let updatedTodoItem = TodoItem.getTodoItemById(todoItem.objectID)
        updatedTodoItem.isCompleted.toggle()

        saveContext()
    }

    private func removeTodoItem(_ todoItem: TodoItem) {
        let removedItem = TodoItem.getTodoItemById(todoItem.objectID)
        viewContext.delete(removedItem)

        saveContext()
    }

    private func clearCompletedTodoItems() {
        for todoItem in todoItems {
            let deletedItem = TodoItem.getTodoItemById(todoItem.objectID)

            if deletedItem.isCompleted {
                viewContext.delete(deletedItem)
            }
        }

        saveContext()
    }

    private func deleteTodoCategory() {
        dismiss()
        let deletedCategory = TodoCategory.getTodoCategoryById(todoCategory.objectID)
        viewContext.delete(deletedCategory)

        saveContext()
        dismiss()
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
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(todoItems.filter({ !$0.isCompleted })) { todoItem in
                        TodoRow(todo: todoItem) {
                            updateTodoItemState(todoItem)
                        }.swipeActions {
                            Button(role: .destructive) {
                                removeTodoItem(todoItem)
                            } label: {
                                Label("Remove", systemImage: "trash")
                            }
                        }
                    }

                    if showCompleted {
                        if !todoItems.filter({$0.isCompleted}).isEmpty {
                            Divider()
                                .padding(.vertical)
                        }

                        ForEach(todoItems.filter({ $0.isCompleted })) { todoItem in
                            TodoRow(todo: todoItem) {
                                updateTodoItemState(todoItem)
                            }.swipeActions {
                                Button(role: .destructive) {
                                    removeTodoItem(todoItem)
                                } label: {
                                    Label("Remove", systemImage: "trash")
                                }
                            }
                        }
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
            }

            Button {
                showingAddTodoItemView.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background(CategoryColor.getColor(todoCategory.color ?? "blue").gradient)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6), ignoresSafeAreaEdges: .all)
        .navigationTitle("\(todoCategory.icon ?? "📝") \(todoCategory.name ?? "New Category")")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        showCompleted.toggle()
                    } label: {
                        Label(showCompleted ? "Hide Completed" : "Show Completed", systemImage: showCompleted ? "eye.slash" : "eye")
                    }

                    Button {
                        showingEditCategoryView.toggle()
                    } label: {
                        Label("Edit Category", systemImage: "pencil")
                    }

                    Divider()

                    Button(role: .destructive) {
                        clearCompletedTodoItems()
                    } label: {
                        Label("Clear Completed", systemImage: "xmark")
                    }

                    Button(role: .destructive) {
                        dismiss()
                        deleteTodoCategory()
                        dismiss()
                    } label: {
                        Label("Delete Category", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }

            }
        }
        .sheet(isPresented: $showingAddTodoItemView) {
            AddTodoItemView { title in
                addTodoItem(title)
            }
        }
        .sheet(isPresented: $showingEditCategoryView) {
            AddTodoCategoryView(todoCategoryToEdit: todoCategory)
        }
    }
}
