//
//  Untitled.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-26.
//

import Foundation

extension Todo {
    static func predicate(searchText: String) -> Predicate<Todo> {
        return #Predicate<Todo> { todo in
            (searchText.isEmpty || todo.title.localizedStandardContains(searchText) || todo.content.localizedStandardContains(searchText))
        }
    }
}
