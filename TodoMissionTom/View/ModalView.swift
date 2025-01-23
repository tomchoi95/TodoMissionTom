//
//  ModalView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-23.
//

import SwiftUI

struct ModalView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var isCompleted: Bool = false
    let mode: ModalViewMode
    
    var body: some View {
        NavigationStack {
            Form {
                Section("제목") {
                    TextField("제목을 입력하세요", text: $title)
                }
                
                Section("내용") {
                    TextField("내용을 입력하세요", text: $content, axis: .vertical)
                }
            }
            .navigationTitle(title)
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button("저장") {
                        let newTodo = Todo(title: title, content: content, initialDate: Date(), isCompleted: isCompleted)
                        modelContext.insert(newTodo)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ModalView(mode: .add)
}
