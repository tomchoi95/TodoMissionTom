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
    var priority: Priority
    var upToDate: Date
    var latestUpdat: Date
    var category: Category
    
    init(id: UUID, title: String, priority: Priority, upToDate: Date, latestUpdat: Date, category: Category = Category()) {
        self.id = id
        self.title = title
        self.priority = priority
        self.upToDate = upToDate
        self.latestUpdat = latestUpdat
        self.category = category
    }
}

@Model
class Category {
    var name: String
    
    init(name: String = "default") {
        self.name = name
    }
}


enum Priority {
    case high
    case medium
    case low
}
