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
    @Environment(\.modelContext) var modelContext
    @Binding var modalViewMode: ModalViewMode?
    
    var body: some View {
        List {
            ForEach(todos) { todo in
                TodoListRowView(todo: todo)
                    .swipeActions(allowsFullSwipe: false) {
                        Button {
                            modelContext.delete(todo)
                        } label: {
                            Label("삭제", image: "trash.fill")
                                .background(Color.red)
                        }
                        
                        Button {
                            modalViewMode = .edit(todo)
                        } label: {
                            Label("수정", image: "pencil")
                                .background(Color.yellow)
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

#Preview {
//    TodoListRowView(todo: Todo(title: "dummy title", content: "dummy content", initialDate: Date(), isCompleted: true))
    @Previewable @State var bind: ModalViewMode?
    TodoListView(modalViewMode: $bind)
}
#Preview {
}
