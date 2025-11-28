//
//  WorkoutHomeView.swift
//  Totality
//
//  Created by Kent Wilson on 11/22/25.
//

import SwiftUI

struct WorkoutHomeView: View {
    @StateObject private var viewModel: WorkoutHomeViewModel

    init(exerciseRepository: ExerciseRepository) {
        _viewModel = StateObject(
            wrappedValue: WorkoutHomeViewModel(exerciseRepository: exerciseRepository)
        )
    }

    var body: some View {
        WorkoutHomeUI(
            date: viewModel.today,
            onExerciseLibraryTap: viewModel.showExerciseLibrary,
            onQuickStartTap: viewModel.quickStartTapped,
            onBuildSessionTap: viewModel.onBuildSessionTapped,
        )
        .sheet(isPresented: $viewModel.isShowingExerciseLibrary) {
            ExerciseLibraryView(exercises: viewModel.exercises)
        }
    }
}
