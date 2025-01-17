//
//  Item.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-17.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
