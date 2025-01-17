//
//  AddTodoModalView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-17.
//

import SwiftUI
import SwiftData

struct AddTodoModalView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.modelContext) private var modelContext
    @State var title: String = ""
    @State var content: String = ""
    @State var todoPriority: TodoPriority = .medium
    @State var upToDate: Date = Date() // 보류
    @State var latestUpdat: Date = Date()
    @State var category: Category = .defaultcategory
    @State var isDone: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button("cancel") {
                presentation.wrappedValue.dismiss()
            }
            .padding(.bottom)
            
            HStack {
                Text(title)
                    .font(.title)
                Spacer()
                Button {
                    saveTodo()
                    presentation.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrowshape.up.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
            }
            .frame(height: 100)
            
            HStack {
                Toggle("완료", isOn: $isDone)
                    .padding(.trailing)

                VStack() {
                    Menu {
                        ForEach(Category.allCases) { option in
                            Button(action: {
                                category = option
                            }) {
                                Text(option.rawValue)
                                if category == option {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Text(category.rawValue)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)

                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                    .padding(.horizontal)
                }
                
                VStack() {
                    Menu {
                        ForEach(TodoPriority.allCases) { option in
                            Button(action: {
                                todoPriority = option
                            }) {
                                Text(option.rawValue)
                                if todoPriority == option {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Text(todoPriority.rawValue)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                    .padding(.horizontal)
                }

                // 언제까지
            }
            Section {
                TextField("제목", text: $title)
                    .textFieldStyle(.roundedBorder)
            }
        
            Form {
                TextField("내용", text: $content, axis: .vertical)
            }
           
        }
        .padding()
    }
    
    private func saveTodo() {
        let newTodo: Todo = Todo(title: title, content: content, todoPriority: todoPriority, upToDate: Date(), latestUpdat: Date(), category: category, isDone: isDone)
        modelContext.insert(newTodo)
    }
    
}

enum Mode {
    case add
    case edit(Todo)
}

#Preview {
    AddTodoModalView()
}
