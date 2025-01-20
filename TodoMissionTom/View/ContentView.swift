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
    @Query() var todos: [Todo]
    @State private var searchText = ""
    @State private var plusCount = 0
    @State private var modalStatus: PassingMode?
    
    private func openModalView(mode: PassingMode) {
        
    }
    
    var body: some View {
        
        NavigationStack {
            List(todos) { todo in
                TodoRowAccordionView(todo: todo)
            }
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        plusCount += 1
                        // 버튼 동작 하게 하는겨
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .symbolEffect(.bounce, value: plusCount)
                            
                    }
                }
            }
            .searchable(text: $searchText)
        }
        
    }
}

#Preview {
    ContentView()
}

struct TodoRowAccordionView: View {
    
    let todo: Todo
    
    var body: some View {
        DisclosureGroup {
            Text("콘텐츠다\(todo.content)")
        } label: {
            Text("타이틀\(todo.title)")
        }

    }
}

enum PassingMode {
    case add
    case edit(Todo)
}
