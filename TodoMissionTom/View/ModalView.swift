//
//  ModalView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-23.
//

import SwiftUI

struct ModalView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var content: String = ""
    
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
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("저장") {
                        // 저장 로직 추가
                    }
                }
            }
        }
    }
}

#Preview {
    ModalView()
}
