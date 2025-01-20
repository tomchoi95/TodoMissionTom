//
//  ModalView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-20.
//

import SwiftUI

struct ModalView: View {
    let mode: PassingMode
    
    @State private var title = ""
    @State private var content = ""
    
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
                        Text("저장 버튼 만들어라")
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Text("취소 버튼 만들어라")
                    }
                }
            }
        }
    }
}

#Preview {
    ModalView(mode: .add)
}
