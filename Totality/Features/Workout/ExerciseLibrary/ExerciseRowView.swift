//
//  ExerciseRowView.swift
//  Totality
//
//  Created by Kent Wilson on 11/24/25.
//

import SwiftUI

struct ExerciseRowView: View {
    let exercise: Exercise

    var body: some View {
        HStack(spacing: 12) {
            // Leading placeholder icon/avatar for the exercise
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(AppColor.card.opacity(0.9))
                    .frame(width: 40, height: 40)

                Image(systemName: "dumbbell")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(AppColor.textPrimary)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(exercise.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppColor.textPrimary)
                    .lineLimit(1)

                HStack(spacing: 6) {
                    Text(exercise.category.rawValue.capitalized)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(AppColor.textSecondary)
                    Text("•")
                        .foregroundColor(AppColor.textSecondary)
                    Text(implementsLabel)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(AppColor.textSecondary)
                    if let pm = primaryMuscleLabel {
                        Text("•")
                            .foregroundColor(AppColor.textSecondary)
                        Text(pm)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(AppColor.textSecondary)
                    }
                }
            }

            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(AppColor.card)
        )
    }
    

    private var implementsLabel: String {
        exercise.primaryImplement.rawValue.capitalized
    }

    private var primaryMuscleLabel: String? {
        let primaries = exercise.muscles.filter { $0.role == .primaryAgonist }
        let chosen = primaries.max(by: { $0.emphasis < $1.emphasis }) ?? exercise.muscles.first
        return chosen?.muscle.rawValue.capitalized
    }
}

struct ExerciseRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExerciseRowView(
                exercise: Exercise(
                    name: "Barbell Back Squat",
                    category: .resistance,
                    implement: .barbell,
                    type: .compound
                )
            )
            .padding()
            .background(AppColor.background)
            .previewLayout(.sizeThatFits)

            ExerciseRowView(
                exercise: Exercise(
                    name: "Dumbbell Bench Press",
                    category: .resistance,
                    implement: .dumbbell,
                    type: .compound
                )
            )
            .padding()
            .background(AppColor.background)
            .previewLayout(.sizeThatFits)
        }
    }
}
