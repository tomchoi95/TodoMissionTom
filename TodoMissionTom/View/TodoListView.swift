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
        _todos = @Query(filter: Todo.predicate(searchText: searchText), sort: \.content)
    }
    
    
    var body: some View {
        List {
            ForEach(todos) { todo in
                TodoListRowView(todo: todo)
                    .swipeActions(allowsFullSwipe: false) {
                        Button {
                            modelContext.delete(todo)
                        } label: {
                            Label("삭제", image: "trash.fill")
                        }
                        
                        Button {
                            modalViewMode = .edit(todo)
                        } label: {
                            Label("수정", image: "pencil")
                        }
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


