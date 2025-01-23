//
//  ContentView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-23.
//
// 데이터 입력 하기.

import SwiftUI

struct ContentView: View {
    @State var searchText: String = ""
    
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
                        // 추가 기능을 달거에요
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }

                }
            }
        }
    }
}

#Preview {
    ContentView()
}
