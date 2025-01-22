//
//  ContentView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-17.
//

// 필터뷰 만들기.

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var searchText = "" // 검색어 상태
    @State private var modalStatus: PassingMode? // 모달창 상태
    @State private var selectedDone: Bool? // 완료 상태를 알고싶다!
    @State private var selectedCategory: Category? // 카테고리 지정한거 알고싶다!
    @State private var selectedPriority: Priority? // 우선순위 지정한거 알고싶다!
    @State private var selectedDate: Date? // 지정한 날짜에 대해 알고싶다!
    @State private var sortingOption: SortingOption = .update
    @State private var isOrderForward: Bool = false
    
    var filterView: some View {
        HStack {
            // 완료 선택
            
            // 우선순위 선택 메뉴
            Menu {
                Button("All Priorities") {
                    selectedPriority = nil
                }
                ForEach(Priority.allCases) { priority in
                    Button(priority.rawValue) {
                        selectedPriority = priority
                    }
                }
            } label: {
                Text(selectedPriority?.rawValue ?? "All Priorities")
            }
            
            // 카테고리 선택 메뉴
            Menu {
                Button("All Categories") {
                    selectedCategory = nil
                }
                ForEach(Category.allCases) { category in
                    Button(category.rawValue) {
                        selectedCategory = category
                    }
                }
            } label: {
                Text(selectedCategory?.rawValue ?? "All Categories")
            }
            
            // 날짜 선택 - 오늘, 이번주, 커스텀 날짜.
            // 정렬 옵션 - 듀데이. 중요도. 업데이트순. // 오름차순, 내림차순
        }
    }
    
    
    var body: some View {
        
        NavigationStack {
            // 필터뷰 구현 해야함
            filterView
            
//            TodoListView
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        modalStatus = .add
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .searchable(text: $searchText)
            .sheet(item: $modalStatus) { mode in
                switch mode {
                case .add:
                    ModalView(mode: .add)
                case .edit(let existingTodo):
                    ModalView(mode: .edit(existingTodo))
                }
            }
        }
        
    }
}


#Preview {

    ContentView()
        .modelContainer(for: Todo.self)
}



enum SortingOption {
    case date
    case priority
    case update
}


enum PassingMode: Identifiable {
    case add
    case edit(Todo)
    
    var id: String {
        switch self {
        case .add:
            return "Add"
        case .edit(let todo):
            return "\(todo.id)"
        }
    }
}

