//
//  ExerciseRepository.swift
//  Totality
//
//  Created by Kent Wilson on 11/24/25.
//

import Foundation
import SwiftData

/// Abstraction for fetching exercises.
/// For now it's simple, but we can extend this with search, filtering, etc.
protocol ExerciseRepository {
    func allExercises() -> [Exercise]
}

/// Production repository backed by SwiftData.
/// Uses the seeded Exercise records as the source of truth.
final class SwiftDataExerciseRepository: ExerciseRepository {
    
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func allExercises() -> [Exercise] {
        let descriptor = FetchDescriptor<Exercise>(
            sortBy: [SortDescriptor(\.name, order: .forward)]
        )
        
        do {
            return try context.fetch(descriptor)
        } catch {
            // For now we fail soft and return an empty list.
            // You can add logging here if you want.
            print("⚠️ Failed to fetch exercises: \(error)")
            return []
        }
    }
}

#if DEBUG
/// Optional mock repo for previews/tests. Right now it just delegates
/// to SwiftData so you don't get out of sync with the real model.
/// You can later customize this to return a small in-memory list if needed.
final class MockExerciseRepository: ExerciseRepository {
    
    private let repo: SwiftDataExerciseRepository
    
    init(context: ModelContext) {
        self.repo = SwiftDataExerciseRepository(context: context)
    }
    
    func allExercises() -> [Exercise] {
        repo.allExercises()
    }
}
#endif

