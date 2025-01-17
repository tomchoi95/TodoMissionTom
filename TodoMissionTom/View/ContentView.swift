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
    @Query private var todos: [Todo]
    @State var showAddModal: Bool = false
    @State var searchText: String = ""
    var body: some View {
        // 완료 선택할 수 있게 하기.
        
                Button("Todo 추가하기") { showAddModal.toggle() }
                    .padding()
                    .font(.system(size: 50))
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.teal))
                    .sheet(isPresented: self.$showAddModal) { AddTodoModalView() }
        NavigationStack {
            List {
                ForEach(todos) { todo in
                    DisclosureGroup(content: {
                        Text(todo.content)
                    }, label: {
                        if todo.isDone {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "circlebadge")
                        }
                        
                        Text(todo.title)
                    })
                }
                .onDelete(perform: deleteTodo)
            }
        }.searchable(text: $searchText)
    }
    
    private func deleteTodo(offsets: IndexSet) {
        withAnimation {
            offsets.map { todos[$0] }.forEach(modelContext.delete)
        }
    }

}

#Preview {
    ContentView()
}
