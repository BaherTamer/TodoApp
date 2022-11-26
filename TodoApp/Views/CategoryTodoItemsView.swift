//
//  CategoryTodoItemsView.swift
//  TodoApp
//
//  Created by Baher Tamer on 26/11/2022.
//

import SwiftUI

struct CategoryTodoItemsView: View {

    let todoCategory: TodoCategory

    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest var todoItems: FetchedResults<TodoItem>

    init(todoCategory: TodoCategory) {
        self.todoCategory = todoCategory
        _todoItems = FetchRequest(fetchRequest: TodoCategory.todoItemsByCategoryRequest(todoCategory))
    }

    @State private var showingAddTodoItemView: Bool = false

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
                        Text("○ " + todoItem.title!)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.bottom)
                        .onTapGesture {
                            updateTodoItemState(todoItem)
                        }
                    }

                    ForEach(todoItems.filter({ $0.isCompleted })) { todoItem in
                        Text("◉ " + todoItem.title!)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.bottom)
                        .onTapGesture {
                            updateTodoItemState(todoItem)
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
                    .background(CategoryColor.getColor(todoCategory.color!).gradient)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6), ignoresSafeAreaEdges: .all)
        .navigationTitle("\(todoCategory.icon!) \(todoCategory.name!)")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // TODO: Clear Completed, Show Completed, Delete Category, Edit Category
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
    }
}
