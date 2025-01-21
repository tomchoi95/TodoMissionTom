//
//  TodoModel.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-20.
//

import SwiftUI
import SwiftData

@Model
final class Todo {
    var title: String
    var content: String
    var initialTime: Date
    var isDone: Bool
    
    init(title: String, content: String, isDone: Bool) {
        self.title = title
        self.content = content
        self.initialTime = Date()
        self.isDone = isDone
    }
}
