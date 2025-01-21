//
//  ModalView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-20.
//

import SwiftUI
import SwiftData

struct ModalView: View {
    let mode: PassingMode
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var content = ""
    @State private var isDone = false
    @State private var latestUpdateTime = Date()
    @State private var selectedPriority: Priority = .middle
    
    init(mode: PassingMode) {
        self.mode = mode
        switch mode {
        case .add:
            break
        case .edit(let todo):
            _title = State(initialValue: todo.title)
            _content = State(initialValue: todo.content)
            _isDone = State(initialValue: todo.isDone)
            _selectedPriority = State(initialValue: todo.priority)
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("옵션") {
                    Toggle("", isOn: $isDone)
                }
                Section() {
                    TextField("제목을 입력하세요", text: $title)
                }
                Section {
                    TextField("내용을 입력하세요", text: $content)
                }
                .navigationTitle("\(title)")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            switch mode {
                            case .add:
                                let newTodo = Todo(title: title, content: content, isDone: isDone, priority: selectedPriority)
                                modelContext.insert(newTodo)
                            case .edit(let todo):
                                todo.title = title
                                todo.content = content
                                todo.isDone = isDone
                            }
                            
                            dismiss()
                        } label: {
                            Text("저장")
                        }
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        Button("cancel") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ModalView(mode: .add)
}
