
//
//  WorkoutHomeUI.swift
//  Totality
//
//  Created by Kent Wilson on 11/22/25.
//

import SwiftUI

struct WorkoutHomeUI: View {
    let date: Date
    let onExerciseLibraryTap: () -> Void
    let onQuickStartTap: () -> Void
    let onBuildSessionTap: () -> Void

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

    var body: some View {
        ZStack {
            AppColor.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    headerSection
                    exerciseLibraryButton
                    sessionsSection
                    historySection

                    Spacer(minLength: 0)
                }
                .padding(.horizontal, 24)
                .padding(.top, 32)
                .padding(.bottom, 24)
            }
        }
    }

    // MARK: - Sections

    private var headerSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Workout")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(AppColor.textPrimary)

                Text(formattedDate)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(AppColor.textSecondary)
            }

            Spacer()

            // Placeholder avatar; replace with real user image when ready
            Circle()
                .fill(LinearGradient(
                    colors: [AppColor.card, AppColor.accentPurple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 40, height: 40)
        }
    }

    private var exerciseLibraryButton: some View {
        Button(action: onExerciseLibraryTap) {
            HStack {
                Spacer()
                Text("Exercise Library")
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
            }
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .fill(AppColor.card)
            )
        }
        .foregroundColor(AppColor.textPrimary)
    }

    private var sessionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Sessions")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(AppColor.textPrimary)

            ZStack {
                CardBackground()

                VStack(alignment: .leading, spacing: 16) {
                    VStack (alignment: .leading, spacing: 8){Text("No Sessions yet.")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Complete a workout from quick start or a built session to track progress")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(AppColor.textSecondary)
                    }

                    HStack (spacing: 16) {
                        Button(action: onBuildSessionTap) {
                            HStack {
                                Spacer()
                                Text("Build Session")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(AppColor.textPrimary.opacity(0.5))
                                Spacer()
                            }
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 24, style: .continuous)
                                    .fill(AppColor.card.opacity(0.50))
                            )
                        }
                        .buttonStyle(.plain)
                        
                        Button(action: onQuickStartTap) {
                            HStack {
                                Spacer()
                                Text("Quick Start")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(AppColor.textPrimary)
                                Spacer()
                            }
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 24, style: .continuous)
                                    .fill(AppColor.card)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 180)
        }
    }

    private var historySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("History")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(AppColor.textPrimary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(AppColor.textSecondary)
            }

            ZStack {
                CardBackground()

                Text("Your session history for this exercise will appear here")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(AppColor.textSecondary)
                    .multilineTextAlignment(.leading)
                    .padding(16)
            }
        }
    }
}

struct WorkoutHomeUI_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutHomeUI(
            date: .now,
            onExerciseLibraryTap: {},
            onQuickStartTap: {},
            onBuildSessionTap: {}
        )
        .previewLayout(.sizeThatFits)
        .background(AppColor.background)
    }
}

