//
//  TodoListView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-23.
//


import SwiftUI
import SwiftData

struct TodoListView: View {
    @Query var todos: [Todo]
    @Environment(\.modelContext) var modelContext
    @Binding var modalViewMode: ModalViewMode?
    
    init(searchText: String, modalViewMode: Binding<ModalViewMode?>) {
        self._modalViewMode = modalViewMode
        let predicate = Todo.predicate(searchText: searchText)
        _todos = Query(
            filter: predicate, sort: [SortDescriptor(\.title, order: .forward)])
    }
    
    
    var body: some View {
        List {
            ForEach(todos) { todo in
                TodoListRowView(todo: todo)
                    .swipeActions(allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            modelContext.delete(todo)
                        } label: {
                            Label("삭제", systemImage: "trash.fill")
                        }
                        
                        Button {
                            modalViewMode = .edit(todo)
                        } label: {
                            Label("수정", systemImage: "pencil")
                        }
                        .tint(.orange)
                    }
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
            Image(systemName: todo.isCompleted ? "chevron.down.circle.fill" : "bookmark.circle")
                .onTapGesture {
                    todo.isCompleted.toggle()
                }
            Text(todo.title)
        }
    }
}


