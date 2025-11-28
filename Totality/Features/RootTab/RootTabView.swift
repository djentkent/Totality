//
//  RootTabView.swift
//  Totality
//
//  Created by Kent Wilson on 11/22/25.
//

import SwiftUI
import SwiftData

struct RootTabView: View {
    private let hasSeededKey = "hasSeededExercises"
    @State private var selectedTab: MainTab = .forYou
    @Environment(\.modelContext) private var modelContext
    @State private var exerciseRepository: SwiftDataExerciseRepository? = nil

    var body: some View {
        ZStack(alignment: .bottom) {
            // Main content
            Group {
                switch selectedTab {
                case .forYou:
                    ForYouHomeView()        // swap with your real view
                case .workout:
                    if let repo = exerciseRepository as ExerciseRepository? {
                        WorkoutHomeView(exerciseRepository: repo)
                    } else {
                        ProgressView().tint(.white)
                    }
                case .nutrition:
                    NutritionHomeView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()

            // Custom tab bar
            MainTabBarView(selectedTab: $selectedTab) { tab in
                handleAction(for: tab)
            }
        }
        .task {
            let defaults = UserDefaults.standard
            if !defaults.bool(forKey: hasSeededKey) {
                do {
                    try ExerciseSeeder.seedIfNeeded(in: modelContext)
                    defaults.set(true, forKey: hasSeededKey)
                } catch {
                    print("Seeding error: \(error)")
                }
            }
            self.exerciseRepository = SwiftDataExerciseRepository(context: modelContext)
        }
    }

    private func handleAction(for tab: MainTab) {
        switch tab {
        case .forYou:
            // no FAB here but safe to handle if you ever add one
            break
        case .workout:
            // e.g. present Quick Workout sheet
            print("Workout action tapped")
        case .nutrition:
            // e.g. open Add Meal flow
            print("Nutrition action tapped")
        }
    }
}

