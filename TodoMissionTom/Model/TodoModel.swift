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
    init(title: String) {
        self.title = title
    }
}
