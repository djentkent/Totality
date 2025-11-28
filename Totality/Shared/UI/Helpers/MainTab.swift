//
//  MainTab.swift
//  Totality
//
//  Created by Kent Wilson on 11/28/25.
//


// MainTab.swift

import SwiftUI

enum MainTab: Hashable {
    case forYou
    case workout
    case nutrition

    var title: String {
        switch self {
        case .forYou: return "For You"
        case .workout: return "Workout"
        case .nutrition: return "Nutrition"
        }
    }

    var systemImage: String {
        switch self {
        case .forYou: return "circle.dashed"
        case .workout: return "circle.dashed"
        case .nutrition: return "circle.dashed"
        }
    }

    /// Icon used in the floating action button
    var actionIcon: String? {
        switch self {
        case .forYou:
            return nil          // no FAB on For You
        case .workout:
            return "dumbbell"   // SF Symbol in iOS 17+; swap if needed
        case .nutrition:
            return "carrot"     // or any other symbol you like
        }
    }
}