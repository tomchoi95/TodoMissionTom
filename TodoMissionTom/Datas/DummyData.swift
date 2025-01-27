//
//  DummyData.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-26.
//

import Foundation
import SwiftData

@MainActor
class PreviewContainer {
    
    static let shared: PreviewContainer = PreviewContainer()
    
    let container: ModelContainer
    
    private init() {
        let schema: Schema = Schema([
            Todo.self, Category.self
        ])
        let configuration: ModelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            container = try ModelContainer(for: schema, configurations: configuration)
            insertPreviewDummuData()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    func insertPreviewDummuData() {
        let dummies: [Todo] = [
            Todo(
                title: "회의 준비",
                content: "다음 주 회의를 위한 자료 준비하기",
                initializedDate: Date(),
                isCompleted: false,
                priority: .high,
                category: nil,
                deadline: Date()
            ),
            Todo(
                title: "장보기",
                content: "주간 식재료와 생필품 구입",
                initializedDate: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                isCompleted: true,
                priority: .medium,
                category: nil,
                deadline: Date()
            ),
            Todo(
                title: "운동",
                content: "30분 러닝 및 스트레칭",
                initializedDate: Date(),
                isCompleted: false,
                priority: .low,
                category: nil,
                deadline: Date()
            ),
            Todo(
                title: "책 읽기",
                content: "Swift 프로그래밍 관련 책 50페이지 읽기",
                initializedDate: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
                isCompleted: true,
                priority: .medium,
                category: nil,
                deadline: Date()
            ),
            Todo(
                title: "프로젝트 마감",
                content: "앱 개발 프로젝트 최종 검토 및 제출",
                initializedDate: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
                isCompleted: false,
                priority: .high,
                category: nil,
                deadline: Date()
            ),
            Todo(
                title: "친구 만나기",
                content: "오랜만에 친구와 저녁 식사 약속",
                initializedDate: Date(),
                isCompleted: false,
                priority: .low,
                category: nil,
                deadline: Date()
            ),
            Todo(
                title: "재무 점검",
                content: "월말 재무 상태 검토 및 예산 계획",
                initializedDate: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
                isCompleted: true,
                priority: .high,
                category: nil,
                deadline: Date()
            ),
            Todo(
                title: "영화 보기",
                content: "최근 개봉한 영화 시청",
                initializedDate: Date(),
                isCompleted: false,
                priority: .low,
                category: nil,
                deadline: Date()
            ),
            Todo(
                title: "블로그 글쓰기",
                content: "SwiftUI 관련 블로그 포스트 작성",
                initializedDate: Calendar.current.date(byAdding: .day, value: -4, to: Date())!,
                isCompleted: true,
                priority: .medium,
                category: nil,
                deadline: Date()
            ),
            Todo(
                title: "정리 정돈",
                content: "책상 및 방 청소하기",
                initializedDate: Date(),
                isCompleted: false,
                priority: .low,
                category: nil,
                deadline: Date()
            )
        ]
        dummies.forEach { dummy in
            container.mainContext.insert(dummy)
        }
    }
}
