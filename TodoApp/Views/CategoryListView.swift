//
//  CategoryListView.swift
//  TodoApp
//
//  Created by Baher Tamer on 26/11/2022.
//

import SwiftUI

struct CategoryListView: View {

    @State private var showingAddCategoryView: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Categories")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.bottom, 2)

                Button {
                    showingAddCategoryView.toggle()
                } label: {
                    Text("Add Category")
                        .font(.headline)
                }

                Divider().padding(.bottom)

                CategoryGridView()
            }
            .padding(.horizontal)
            .sheet(isPresented: $showingAddCategoryView) {
                AddTodoCategoryView()
            }
            .background(Color(UIColor.systemGray6), ignoresSafeAreaEdges: .all)
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
