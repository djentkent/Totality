//
//  WorkoutHomeViewModel.swift
//  Totality
//
//  Created by Kent Wilson on 11/22/25.
//

import Foundation
import SwiftUI

final class WorkoutHomeViewModel: ObservableObject {
    @Published var today: Date = .now
    @Published var exercises: [Exercise] = []
    @Published var isShowingExerciseLibrary = false

    private let exerciseRepository: ExerciseRepository

    init(exerciseRepository: ExerciseRepository) {
        self.exerciseRepository = exerciseRepository
        loadExercises()
    }

    private func loadExercises() {
        exercises = exerciseRepository.allExercises()
    }

    func showExerciseLibrary() {
        isShowingExerciseLibrary = true
    }

    func quickStartTapped() {
        // Phase 2: start session
        print("Quick start tapped")
    }
    
    func onBuildSessionTapped() {
        // Phase 3: build session
        print("Build Session tapped")
    }
}
