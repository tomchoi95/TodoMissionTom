//
//  Untitled.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-26.
//

import Foundation
import SwiftUI

extension Todo {
    
}

extension Category {
    static func predicate(_ searchText: String) -> Predicate<Category> {
        return #Predicate<Category> { category in
            searchText.isEmpty ||
            category.title.localizedStandardContains(searchText)
        }
    }
}
