//
//  File.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-17.
//

import SwiftData
import Foundation

@Model
class Todo {
    var id: UUID
    var title: String
    var todoPriority: TodoPriority
    var upToDate: Date
    var latestUpdat: Date
    var category: Category
    var isDone: Bool
    
    init(id: UUID, title: String, todoPriority: TodoPriority = .medium, upToDate: Date, latestUpdat: Date, category: Category = Category(), isDone: Bool = false) {
        self.id = id
        self.title = title
        self.todoPriority = todoPriority
        self.upToDate = upToDate
        self.latestUpdat = latestUpdat
        self.category = category
        self.isDone = isDone
    }
}

@Model
class Category {
    var name: String
    
    init(name: String = "default") {
        self.name = name
    }
}


enum TodoPriority: Hashable {
    case high
    case medium
    case low
}
