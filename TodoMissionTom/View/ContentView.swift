//
//  ContentView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-17.
//



import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(/* 쿼리 구현 하는 곳 */) var todos: [Todo] // 필터 구현 해야함
    @State private var searchText = ""
    @State private var plusCount = 0
    @State private var modalStatus: PassingMode?
    
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(todos) { todo in
                    TodoRowAccordionView(todo: todo)
                        .swipeActions(edge: .leading) {
                            Button {
                                modalStatus = .edit(todo)
                            } label: {
                                Text("edit")
                            }
                            
                        }
                }
                .onDelete { IndexSet in
                    for index in IndexSet {
                        modelContext.delete(todos[index])
                    }
                }
            }
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        plusCount += 1
                        modalStatus = .add
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .symbolEffect(.bounce, value: plusCount)
                        
                    }
                }
            }
            .searchable(text: $searchText)
            .sheet(item: $modalStatus) { mode in
                switch mode {
                case .add:
                    ModalView(mode: .add)
                case .edit(let existingTodo):
                    ModalView(mode: .edit(existingTodo))
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Todo.self)
}

struct TodoRowAccordionView: View {
    
    let todo: Todo
    
    var body: some View {
        DisclosureGroup {
            Text("\(todo.content)")
        } label: {
            Image(systemName: todo.isDone ? "chevron.down.circle" : "circle")
                .onTapGesture {
                    todo.isDone.toggle()
                }
            Text("\(todo.title)")
        }
        
    }
}

enum PassingMode: Identifiable {
    case add
    case edit(Todo)
    
    var id: String {
        switch self {
        case .add:
            return "Add"
        case .edit(let todo):
            return "\(todo.id)"
        }
    }
}
