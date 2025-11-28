//
//  ExerciseLibraryView.swift
//  Totality
//
//  Created by Kent Wilson on 11/24/25.
//

import SwiftUI

struct ExerciseLibraryView: View {
    let exercises: [Exercise]

    @Environment(\.dismiss) private var dismiss
    @State private var searchText: String = ""

    private var filteredExercises: [Exercise] {
        guard !searchText.isEmpty else { return exercises }
        return exercises.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        NavigationStack {
            List(filteredExercises) { exercise in
                ExerciseRowView(exercise: exercise)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .searchable(text: $searchText)
            .navigationTitle("Exercise Library")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { dismiss() }
                }
            }
        }
        .background(AppColor.background)
        .background(AppColor.background.ignoresSafeArea())
    }
}
