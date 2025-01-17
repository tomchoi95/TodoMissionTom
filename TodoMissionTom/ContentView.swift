//
//  ContentView.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-17.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var Todos: [Todo]

    var body: some View {
        
        VStack {
            Button("add") {
                
            }
            
        }
        
    }

}

#Preview {
    ContentView()
}
