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
    
    init(searchText: String, selectedPriority: Priority?, selectedCompleted: Bool?, sortOption: String, isForwardOrder: Bool, modalViewMode: Binding<ModalViewMode?>) {
        self._modalViewMode = modalViewMode
        let predicate = Todo.predicate(searchText: searchText, selectedPriority: selectedPriority, selectedCompleted: selectedCompleted)
        let sort = Todo.sort(sortOption: sortOption, isForwardOrder: isForwardOrder)
        _todos = Query(
            filter: predicate, sort: [sort])
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
            VStack(alignment: .leading) {
                Text(todo.content)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                Group {
                    HStack {
                        Text("\(Image(systemName: "clock"))")
                        Text(todo.initializedDate, style: .date)
                        Text(todo.initializedDate, style: .time)
                    }
                    HStack {
                        Text("\(Image(systemName: "calendar.badge.clock"))")
                        Text(todo.deadline, style: .date)
                        Text(todo.deadline, style: .time)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.subheadline)
                .foregroundStyle(Color.gray)
            }
            
        } label: {
            HStack {
                Image(systemName: todo.isCompleted ? "chevron.down.circle.fill" : "bookmark.circle")
                    .onTapGesture {
                        todo.isCompleted.toggle()
                    }
                Text(todo.title)
                Spacer()
                Text(todo.category?.title ?? "")
                Text(todo.priority.emoji)
            }
        }
        .disclosureGroupStyle(.automatic)
    }
}

#Preview {
//    TodoListView(searchText: " ", modalViewMode: .constant(nil))
//        .modelContainer(PreviewContainer.shared.container)
}
