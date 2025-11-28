import Foundation
import SwiftData

final class DefaultSwiftDataExerciseRepository: ExerciseRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func allExercises() -> [Exercise] {
        do {
            let fetch = FetchDescriptor<Exercise>()
            return try context.fetch(fetch)
        } catch {
            assertionFailure("Failed to fetch exercises: \(error)")
            return []
        }
    }
}

