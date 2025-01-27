//
//  Untitled.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-26.
//

import Foundation
import SwiftUI

extension Todo {
    static func predicate(searchText: String, selectedPriority: Priority?, selectedCompleted: Bool?) -> Predicate<Todo> {
        return #Predicate<Todo> { todo in
            (searchText.isEmpty || todo.title.localizedStandardContains(searchText) || todo.content.localizedStandardContains(searchText)) &&
            (selectedPriority == nil || selectedPriority == todo.priority) &&
            (selectedCompleted == nil || selectedCompleted == todo.isCompleted)
        }
    }
    
    static func sort(sortOption: String, isForwardOrder: Bool) -> SortDescriptor<Todo> {
        let order: SortOrder = isForwardOrder ? .forward : .reverse
        switch sortOption {
        case "작성일순":
            return SortDescriptor(\Todo.initializedDate, order: order)
        case "카테고리순":
            return SortDescriptor(\Todo.category, order: order)
        case "우선순위순":
            return SortDescriptor(\Todo.priority.rawValue, order: order)
        default:
            return SortDescriptor(\Todo.initializedDate, order: order)
        }
    }
}

extension Category {
    static func predicate(_ searchText: String) -> Predicate<Category> {
        return #Predicate<Category> { category in
            searchText.isEmpty ||
            category.title.localizedStandardContains(searchText)
        }
    }
}
