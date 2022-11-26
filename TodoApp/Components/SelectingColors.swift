//
//  SelectingColors.swift
//  TodoApp
//
//  Created by Baher Tamer on 26/11/2022.
//

import SwiftUI

struct SelectingColors: View {

    @Binding var categoryColor: CategoryColor
    private let columnGrid = Array(repeating: GridItem(.flexible()), count: 6)

    var body: some View {
        LazyVGrid(columns: columnGrid) {
            ForEach(CategoryColor.allCases, id: \.self) { color in
                Circle()
                    .fill(color.color)
                    .padding(5)
                    .overlay(content: {
                        if color == categoryColor {
                            Circle()
                                .stroke(lineWidth: 3)
                                .foregroundColor(.gray.opacity(0.5))
                        }
                    })
                    .onTapGesture {
                        categoryColor = color
                    }
            }
        }
    }
}

struct SelectingColors_Previews: PreviewProvider {
    static var previews: some View {
        SelectingColors(categoryColor: .constant(.green))
    }
}
