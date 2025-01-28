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
    @State private var modalViewMode: ModalViewMode?
    @State private var selectedCompleted: Bool?
    @State private var selectedCategory: Category?
    @State private var selectedPriority: Priority?
    @State private var sortOption: Sort = .latest
    @State private var dateOption: DateOption = .allday
    @State private var isForwardOrder: Bool = true
    @State private var customDate: Date = Date()
    @Query var categories: [Category]
    @Query var todos: [Todo]
    private var filteredTodo: [Todo] {
        let filtered: [Todo] = todos.filter { todo in
            let serchMatch = searchText.isEmpty || todo.title.localizedCaseInsensitiveContains(searchText) || todo.content.localizedCaseInsensitiveContains(searchText)
            let completionMatch = selectedCompleted == nil || todo.isCompleted == selectedCompleted
            let priorityMatch = selectedPriority == nil || todo.priority == selectedPriority
            let categoryMatch = selectedCategory == nil || todo.category == selectedCategory
            let dateMatch = {
                let calendar = Calendar.current
                switch dateOption {
                case .allday:
                    return true
                case .thisWeek:
                    return calendar.component(.weekOfYear, from: todo.deadline) == calendar.component(.weekOfYear, from: .now)
                case .today:
                    return calendar.isDate(todo.deadline, inSameDayAs: .now)
                case .customDate:
                    return calendar.isDate(todo.deadline, inSameDayAs: customDate)
                }
            }()
            return serchMatch && completionMatch && priorityMatch && categoryMatch && dateMatch
        }
        let filteredAndSorted = filtered.sorted { left , right in
            let order: Bool
            switch sortOption {
            case .latest: order = left.lastUpdate < right.lastUpdate
            case .category: order = left.category?.title ?? "" < right.category?.title ?? ""
            case .priority: order = left.priority.rawValue < right.priority.rawValue
            }
            return isForwardOrder ? !order : order
        }
        return filteredAndSorted
    }
    
    enum Sort: String, CaseIterable {
        case latest = "최근등록순"
        case category = "카테고리순"
        case priority = "우선순위순"
    }
    
    enum DateOption: String, CaseIterable {
        case allday = "All Day"
        case thisWeek = "This Week"
        case today = "Today"
        case customDate = "Custom Date"
    }
       
    
    var body: some View {
        TabView {
            Tab {
                NavigationStack {
                    searchOptionView
                    VStack {
                        TodoListView(todos: filteredTodo, modalViewMode: $modalViewMode)
                    }
                    .animation(.smooth, value: filteredTodo)
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
                Menu("정렬옵션") {
                    Picker("정렬옵션", selection: $sortOption) {
                        ForEach(Sort.allCases, id: \.rawValue) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    Divider()
                    Picker("순서", selection: $isForwardOrder) {
                        Text("오름차순").tag(true)
                        Text("내림차순").tag(false)
                    }
                }
            }
            HStack {
                Menu(dateOption.rawValue) {
                    Picker("date picker", selection: $dateOption) {
                        ForEach(DateOption.allCases, id: \.rawValue) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                }
                if dateOption == .customDate {
                    DatePicker("Custom Date", selection: $customDate, displayedComponents: [.date])
                        .labelsHidden()
                }
            }
        }
    }
}

struct TodoListView: View {
    @Environment(\.modelContext) var modelContext
    var todos: [Todo]
    @Binding var modalViewMode: ModalViewMode?
    var body: some View {
        List {
            ForEach(todos) { todo in
                TodoListRowView(todo: todo)
                    .swipeActions(allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            modelContext.delete(todo)
                        } label: {
                            Label("삭제", systemImage: "trash.fill")
                        }
                        
                        Button {
                            modalViewMode = .edit(todo)
                        } label: {
                            Label("수정", systemImage: "pencil")
                        }
                        .tint(.orange)
                    }
            }
        }
    }
}
struct TodoListRowView: View {
    let todo: Todo
    var body: some View {
        DisclosureGroup {
            VStack(alignment: .leading) {
                Text(todo.content)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                Group {
                    HStack {
                        Text("\(Image(systemName: "clock"))")
                        Text(todo.initializedDate, style: .date)
                        Text(todo.initializedDate, style: .time)
                    }
                    HStack {
                        Text("\(Image(systemName: "calendar.badge.clock"))")
                        Text(todo.deadline, style: .date)
                        Text(todo.deadline, style: .time)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.subheadline)
                .foregroundStyle(Color.gray)
            }
            
        } label: {
            HStack {
                Image(systemName: todo.isCompleted ? "chevron.down.circle.fill" : "bookmark.circle")
                    .onTapGesture {
                        todo.isCompleted.toggle()
                    }
                Text(todo.title)
                Spacer()
                Text(todo.category?.title ?? "")
                Text(todo.priority.emoji)
            }
        }
        .disclosureGroupStyle(.automatic)
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
