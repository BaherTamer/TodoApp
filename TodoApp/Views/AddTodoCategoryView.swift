//
//  AddTodoCategoryView.swift
//  TodoApp
//
//  Created by Baher Tamer on 25/11/2022.
//

import SwiftUI

struct AddTodoCategoryView: View {

    @State private var icon: String = "✅"
    @State private var name: String = ""
    

    var body: some View {
        NavigationStack {
            Form {
                EmojiTextField(text: $icon, placeholder: "")
            }
        }
    }
}

struct AddTodoCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoCategoryView()
    }
}
