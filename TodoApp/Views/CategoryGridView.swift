//
//  CategoryGridView.swift
//  TodoApp
//
//  Created by Baher Tamer on 26/11/2022.
//

import SwiftUI

struct CategoryGridView: View {

    @FetchRequest(fetchRequest: TodoCategory.allCategories) var todoCategories

    private var ColumnGrid = Array(repeating: GridItem(.flexible()), count: 3)

    var body: some View {
        LazyVGrid(columns: ColumnGrid) {
            ForEach(todoCategories) { category in
                VStack(alignment: .center) {
                    Text(category.icon!)
                        .font(.system(size: 50))
                        .padding()
                        .background(CategoryColor.getColor(category.color!).gradient)
                        .clipShape(Circle())

                    Text(category.name!)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .lineLimit(2, reservesSpace: true)
                }
            }
        }
    }
}

struct CategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGridView()
    }
}
