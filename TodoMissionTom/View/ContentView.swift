//
//  ContentView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var searchText: String = ""
    @State var modalViewMode: ModalViewMode?
    @State var selectedCompleted: Bool?
    @State var selectedCategory: Category?
    @State var selectedPriority: Priority?
    @State var sortOption: String = "날짜순"
    @State var isForwardOrder: Bool = true
    @Query var categories: [Category]
    var body: some View {
        TabView {
            Tab {
                NavigationStack {
                    searchOptionView
                    // 완료선택, 카테고리이름, 우선순위, 정렬옵션, 차순
                    VStack {
                        TodoListView(searchText: searchText, selectedPriority: selectedPriority, selectedCompleted: selectedCompleted, sortOption: sortOption, isForwardOrder: isForwardOrder, modalViewMode: $modalViewMode)
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
            } label: {
                Image(systemName: "clock")
                Text("Todo")
            }
            Tab {
                CategoryView()
            } label: {
                Image(systemName: "archivebox")
                Text("Categoy")
            }
        }
    }
    
    var searchOptionView: some View {
        VStack {
            HStack {
                Picker("완료선택", selection: $selectedCompleted) {
                    Text("완료선택").tag(nil as Bool?)
                    Text("완료").tag(true)
                    Text("미완료").tag(false)
                }
                Picker("카테고리", selection: $selectedCategory) {
                    Text("카테고리").tag(nil as Category?)
                    ForEach(categories) { category in
                        Text(category.title).tag(category)
                    }
                }
                Picker("우선순위", selection: $selectedPriority) {
                    Text("우선순위").tag(nil as Priority?)
                    ForEach(Priority.allCases, id: \.rawValue) { priority in
                        Text(priority.emoji).tag(priority)
                    }
                }
                Menu(sortOption) {
                    Picker(sortOption, selection: $sortOption) {
                        Text("작성일순").tag("작성일순")
                        Text("카테고리순").tag("카테고리순")
                        Text("우선순위순").tag("우선순위순")
                    }
                    Divider()
                    Picker("순서", selection: $isForwardOrder) {
                        Text("오름차순").tag(true)
                        Text("내림차순").tag(false)
                    }
                }
            }
            HStack {
                Text("날짜 옵션")
                Text("커스텀 날짜 옵션")
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
        .modelContainer(PreviewContainer.shared.container)
}
