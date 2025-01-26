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
    @Query(filter: nil, sort: \Category.initializedDate, order: .forward, animation: .bouncy) var categories: [Category]
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
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Option") {
                    Picker("Priority", selection: $priority) {
                        ForEach(Priority.allCases ,id: \.rawValue) { priority in
                            Text(priority.emoji).tag(priority)
                        }
                    }
                    
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
                                        Text(category.title).tag(Optional(category))
                                    }
                                    Text("None").tag(Category?.none)
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
                
                Section("Title") {
                    TextField("제목을 입력하세요", text: $title)
                }
                
                Section("Content") {
                    TextField("내용을 입력하세요", text: $content, axis: .vertical)
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
                            let newTodo = Todo(title: title, content: content, initializedDate: Date(), isCompleted: isCompleted, priority: priority, category: category)
                            modelContext.insert(newTodo)
                        case .edit(let todo):
                            todo.title = title
                            todo.content = content
                            todo.isCompleted = isCompleted
                            todo.priority = priority
                            todo.category = category
                        }
                        dismiss()
                    }
                    .disabled(title.isEmpty && content.isEmpty)
                }
            }
            
        }
    }
    
    var addCategoryForm: some View {
        HStack {
            TextField("New Category", text: $newCategoryName)
            Button("add") {
                withAnimation {
                    let newCategory = Category(title: newCategoryName)
                    modelContext.insert(newCategory)
                    showingAddCategory = false
                    newCategoryName.removeAll()
                    category = categories.last
                }
            }
            Button("cancel", role: .cancel) {
                withAnimation {
                    showingAddCategory = false
                    newCategoryName.removeAll()
                }
            }
        }
    }
}

#Preview {
    ModalView(mode: .add)
}
