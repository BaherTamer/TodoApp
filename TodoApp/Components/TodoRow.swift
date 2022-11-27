//
//  TodoRow.swift
//  TodoApp
//
//  Created by Baher Tamer on 27/11/2022.
//

import SwiftUI

struct TodoRow: View {

    @ObservedObject var todo: TodoItem
    let updateTodoState: () -> ()

    var body: some View {
        HStack(alignment: .top) {
            Text(todo.isCompleted ? "◉" : "○")
            Text(todo.title ?? "Todo Item")
                .foregroundColor(todo.isCompleted ? .secondary : .primary)
                .strikethrough(todo.isCompleted, color: CategoryColor.getColor((todo.category?.color)!))
        }
        .font(.title3)
        .fontWeight(.semibold)
        .padding(.bottom)
        .onTapGesture {
            updateTodoState()
        }
    }
}

struct TodoRow_Previews: PreviewProvider {
    static var previews: some View {
        TodoRow(todo: TodoItem(context: CoreDataManager.shared.viewContext), updateTodoState: {})
    }
}
