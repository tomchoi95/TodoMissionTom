//
//  TodoListView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-23.
//


import SwiftUI
import SwiftData

struct TodoListView: View {
    @Query() var todos: [Todo]
    var body: some View {
        List {
            ForEach(todos) { todo in
                TodoListRowView(todo: todo)
            }
        }
    }
}

struct TodoListRowView: View {
    let todo: Todo
    var body: some View {
        DisclosureGroup {
            Text(todo.content)
        } label: {
            Text(todo.title)
        }

    }
}

#Preview {
    TodoListView()
}
