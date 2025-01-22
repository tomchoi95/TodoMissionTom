//
//  TodoListView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-22.
//

import SwiftUI
import SwiftData

struct TodoListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var todos: [Todo]
    var searchText = "" // 검색어 상태
    var selectedDone: Bool? // 완료 상태를 알고싶다!
    var selectedCategory: Category? // 카테고리 지정한거 알고싶다!
    var selectedPriority: Priority? // 우선순위 지정한거 알고싶다!
    var selectedDate: Date? // 지정한 날짜에 대해 알고싶다!
    var isOrderForward: Bool
    
    init(searchText: String, selectedDone: Bool?, selectedCategory: Category?, selectedPriority: Priority?, selectedDate: Date?, sortingOption: SortingOption, isOrderForward: Bool) {
        self.searchText = searchText
        self.selectedDone = selectedDone
        self.selectedCategory = selectedCategory
        self.selectedPriority = selectedPriority
        self.selectedDate = selectedDate
        self.isOrderForward = isOrderForward
        
        _todos = Query(filter: #Predicate<Todo> { todo in
            (searchText.isEmpty || todo.title.localizedCaseInsensitiveContains(searchText)) || todo.content.localizedCaseInsensitiveCompare(searchText) && //검색어
            
            (selectedCategory == nil || todo.category == selectedCategory) && // 카테고리
            
            (selectedPriority == nil || todo.priority == selectedPriority)
        }, sort: \.title, order: isOrderForward ? .forward : .reverse , animation: .easeInOut)
    }
    
    var body: some View {
        
        List {
            ForEach(todos) { todo in
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
    }
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
