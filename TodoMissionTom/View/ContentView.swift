//
//  ContentView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-23.
//
// 데이터 입력 하기.

import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
    @State private var modalViewMode: ModalViewMode?
    var body: some View {
        NavigationStack {
            VStack {
                TodoListView()
            }
            .searchable(text: $searchText)
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem {
                    Button {
                        modalViewMode = .add
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    
                }
            }
            .sheet(item: $modalViewMode) { mode in
                ModalView(mode: mode)
            }
            
        }
    }
}



enum ModalViewMode: Identifiable {
    case add
    case edit(Todo)
    
    var id: String {
        switch self {
        case .add:
            "add"
        case .edit(_):
            "edit"
        }
    }
}


#Preview {
    ContentView()
}
