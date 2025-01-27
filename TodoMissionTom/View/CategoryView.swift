//
//  CategoryView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-27.
//

import SwiftUI
import SwiftData

struct CategoryView: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            CategorySearchView(searchText: searchText)
        }.searchable(text: $searchText)
    }
}

struct CategorySearchView: View {
    @Query var categories: [Category]
    @Environment(\.modelContext) var modelContext
    
    init(searchText: String) {
        _categories = Query(filter: Category.predicate(searchText), sort: \Category.title)
    }
    
    var body: some View {
        List(categories) { category in
            NavigationLink(category.title, value: category)
                .swipeActions() {
                    Button("삭제", role: .destructive) {
                        modelContext.delete(category)
                        try? modelContext.save()
                    }
                }
        }
        .navigationDestination(for: Category.self) { category in
            List(category.todos ?? []) { todo in
                TodoListRowView(todo: todo)
            }
        }
    }
}

extension Category {
    static func predicate(_ searchText: String) -> Predicate<Category> {
        return #Predicate<Category> { category in
            searchText.isEmpty ||
            category.title.localizedStandardContains(searchText)
        }
    }
}

#Preview {
    CategoryView()
        .modelContainer(PreviewContainer.shared.container)
}
