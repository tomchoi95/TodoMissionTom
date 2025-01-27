//
//  ModalView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-23.
//

import SwiftUI
import SwiftData

struct ModalView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var isCompleted: Bool = false
    @State private var showingAddCategory: Bool = false
    @State private var priority: Priority = .medium
    @State private var category: Category?
    @State private var newCategoryName: String = ""
    @State private var deadline: Date = Date()
    @Query(filter: nil, sort: \Category.initializedDate, order: .reverse) var categories: [Category]
    let mode: ModalViewMode
    
    init(mode: ModalViewMode) {
        self.mode = mode
        switch mode {
        case .add:
            return
        case .edit(let todo):
            _title = State(initialValue: todo.title)
            _content = State(initialValue: todo.content)
            _isCompleted = State(initialValue: todo.isCompleted)
            _priority = State(initialValue: todo.priority)
            _category = State(initialValue: todo.category)
            _deadline = State(initialValue: todo.deadline)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    Section("Option") {
                        priorityRow
                        categoryRow
                        deadlinePickerRow
                        completionToggleRow
                    }
                    Section("Title") {
                        TextField("제목을 입력하세요", text: $title)
                    }
                    
                    Section("Content") {
                        TextField("내용을 입력하세요", text: $content, axis: .vertical)
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .automatic) {
                    Button("save") {
                        switch mode {
                        case .add:
                            let newTodo = Todo(title: title, content: content, initializedDate: Date(), isCompleted: isCompleted, priority: priority, category: category, deadline: deadline)
                            modelContext.insert(newTodo)
                            category?.todos?.append(newTodo)
                            try? modelContext.save()
                        case .edit(let todo):
                            todo.title = title
                            todo.content = content
                            todo.isCompleted = isCompleted
                            todo.priority = priority
                            todo.category = category
                            todo.deadline = deadline
                            
                        }
                        dismiss()
                    }
                    .disabled(title.isEmpty && content.isEmpty)
                }
            }
        }
        
    }
    var priorityRow: some View {
        Picker("Priority", selection: $priority) {
            ForEach(Priority.allCases ,id: \.rawValue) { priority in
                Text(priority.emoji).tag(priority)
            }
        }
    }
    var categoryRow: some View {
        Group {
            HStack {
                Text("Category")
                Spacer()
                if categories.isEmpty {
                    Button("Add Category") {
                        withAnimation {
                            showingAddCategory = true
                        }
                    }
                } else {
                    Menu {
                        Picker("Choose Category", selection: $category) {
                            ForEach(categories) { category in
                                Text(category.title).tag(category as Category?)
                            }
                            Text("None").tag(nil as Category?)
                        }
                        Divider()
                        Button("Add Category") {
                            withAnimation {
                                showingAddCategory = true
                            }
                        }
                    } label: {
                        Text(category?.title ?? "None")
                    }
                }
            }
            if showingAddCategory {
                addCategoryForm
            }
        }
    }
    var addCategoryForm: some View {
        HStack {
            TextField("New Category", text: $newCategoryName)
            Button("add") {
                withAnimation {
                    showingAddCategory = false
                    let newCategory = Category(title: newCategoryName)
                    modelContext.insert(newCategory)
                    newCategoryName.removeAll()
                    category = newCategory
                }
            }
            .disabled(newCategoryName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            Button("cancel") {
                withAnimation {
                    showingAddCategory = false
                    newCategoryName.removeAll()
                }
            }
        }
    }
    var deadlinePickerRow: some View {
        DatePicker("Deadline", selection: $deadline, displayedComponents: [.date, .hourAndMinute])
    }
    var completionToggleRow: some View {
        Toggle("Completion", isOn: $isCompleted)
    }
}

#Preview {
    ModalView(mode: .add)
}
