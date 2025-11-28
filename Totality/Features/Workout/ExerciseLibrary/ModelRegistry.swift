import Foundation
import SwiftData

enum ModelRegistry {
    static var models: [any PersistentModel.Type] {
        [
            Exercise.self,
            ExerciseMuscle.self,
            ExerciseJoint.self,
            ExerciseRelation.self,
            CardioProfile.self
        ]
    }
}
