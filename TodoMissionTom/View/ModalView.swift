//
//  ModalView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-20.
//

import SwiftUI

struct ModalView: View {
    let mode: PassingMode
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var content = ""
    @State private var isDone = false
    
    init(mode: PassingMode) {
        self.mode = mode
        switch mode {
        case .add:
            break
        case .edit(let todo):
            _title = State(initialValue: todo.title)
            _content = State(initialValue: todo.content)
            _isDone = State(initialValue: todo.isDone)
        }
    }
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("여기에 옵션 넣자")
                }
                Section {
                    TextField("제목", text: $title)
                }
                Section {
                    TextField("내용", text: $content)
                }
                .navigationTitle("\(title)")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            switch mode {
                            case .add:
                                let newTodo = Todo(title: title, content: content, isDone: isDone)
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
