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
    @Query() var todos: [Todo]
    @State private var searchText = "" // 검색어 상태
    @State private var plusCount = 0 // 이미지 움직이자
    @State private var modalStatus: PassingMode? // 모달창 상태
    @State private var selectedDone: Bool? // 완료 상태를 알고싶다!
    @State private var selectedCategory: Category? // 카테고리 지정한거 알고싶다!
    @State private var selectedPriority: Priority? // 우선순위 지정한거 알고싶다!
    @State private var selectedDate: Date? // 지정한 날짜에 대해 알고싶다!
    
    private var filteredTodo: [Todo] {
        let filterdTodos = todos.filter { todo in
            let searchFilter = searchText == "" || todo.title.localizedCaseInsensitiveContains(searchText) || todo.content.localizedCaseInsensitiveContains(searchText)
            let caterotyFilter = selectedCategory == nil || todo.category == selectedCategory
            let priorityFilter = selectedPriority == nil || todo.priority == selectedPriority
            let completionFilter = selectedDone == nil || todo.isDone == selectedDone

            // 필터 구현해야함 - 날짜필터 구현해야함
            // let dateFilter
            
            return searchFilter && caterotyFilter && priorityFilter && completionFilter
        }
        return filterdTodos // 정렬 옵션 해야함
    }
    
    
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
            
            List {
                ForEach(filteredTodo) { todo in
                    TodoRowAccordionView(todo: todo)
                        .swipeActions(edge: .leading) {
                            Button {
                                modalStatus = .edit(todo)
                            } label: {
                                Text("edit")
                            }
                            
                        }
                }
                .onDelete { IndexSet in
                    for index in IndexSet {
                        modelContext.delete(todos[index])
                    }
                }
            }
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        plusCount += 1
                        modalStatus = .add
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .symbolEffect(.bounce, value: plusCount)
                        
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
        .modelContainer(for: Todo.self,inMemory: false)
}

struct TodoRowAccordionView: View {
    
    let todo: Todo
    
    var body: some View {
        DisclosureGroup {
            VStack(alignment: .leading, spacing: 8) {
                Text(todo.content)
                
                HStack {
                    Label("Due: ", systemImage: "calendar")
                    Text(todo.dueDate.formatted(date: .abbreviated, time: .shortened))
                }
                .font(.caption)
                .foregroundColor(.gray)
                
                HStack {
                    Label("Updated: ", systemImage: "clock")
                    Text(todo.latestUpdateTime.formatted(date: .abbreviated, time: .shortened))
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
        } label: {
            Image(systemName: todo.isDone ? "chevron.down.circle" : "circle")
                .onTapGesture {
                    todo.isDone.toggle()
                }
            Text("\(todo.title)")
            Spacer()
            Text(todo.category.rawValue)
            Text(todo.priority.rawValue)
        }
        
    }
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
