//
//  TodoListView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-23.
//


import SwiftUI

struct TodoListView: View {
    var body: some View {
        List {
            ForEach(0 ... 10, id: \.self) { Identifiable in
                TodoListRowView()
            }
        }
    }
}

struct TodoListRowView: View {
    var body: some View {
        DisclosureGroup {
            Text("sㅐ용입니다")
        } label: {
            Text("레이블입니다")
        }

    }
}

#Preview {
    TodoListView()
}
