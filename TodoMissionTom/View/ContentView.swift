//
//  ContentView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-17.
//

// 필터뷰 만들기.

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var todos: [Todo]
    @State private var searchText = ""
    @State private var plusCount = 0
    @State private var modalStatus: PassingMode?
    @State private var selectedCategory: Category?
    @State private var selectedPriority: Priority?
    private var filteredTodo: [Todo] {
        let filterdTodos = todos.filter { todo in
            let searchFilter = searchText == "" || todo.title.localizedCaseInsensitiveContains(searchText) || todo.content.localizedCaseInsensitiveContains(searchText)
            // 필터 구현해야함
            
            return searchFilter
        }
        return filterdTodos
    }
   
    var body: some View {
        
        
        // 필터뷰 구현 해야함
        
        NavigationStack {
            List {
                ForEach(filteredTodo) { todo in
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
        
        List {
            ForEach(todos) { todo in
                TodoRowAccordionView(todo: todo)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Todo.self,inMemory: false)
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
