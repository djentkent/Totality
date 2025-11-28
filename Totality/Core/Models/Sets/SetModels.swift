//
//  SetModels.swift
//  Totality
//
//  Created by Kent Wilson on 11/28/25.
//

import Foundation
import SwiftData



// MARK: - Set Template (planned set)

@Model
final class SetTemplate {
    @Attribute(.unique) var id: UUID
    
    // Relationship to ExerciseTemplate / SessionExercise (if you use one)
    var exerciseId: UUID    // soft link to the planned exercise
    
    var orderIndex: Int
    
    var categoryRaw: String
    var typeRaw: String
    var stimulusRaw: String?
    
    var targetReps: Int?
    var targetLoad: Double?      // in user’s unit (lbs/kg) – interpret with context
    var targetRIR: Int?          // 0–5
    var targetRPE: Double?       // 1–10
    
    var isDeleted: Bool
    
    init(
        exerciseId: UUID,
        orderIndex: Int,
        category: SetCategory,
        type: SetType,
        stimulus: SetStimulus? = nil,
        targetReps: Int? = nil,
        targetLoad: Double? = nil,
        targetRIR: Int? = nil,
        targetRPE: Double? = nil
    ) {
        self.id = UUID()
        self.exerciseId = exerciseId
        self.orderIndex = orderIndex
        
        self.categoryRaw = category.rawValue
        self.typeRaw = type.rawValue
        self.stimulusRaw = stimulus?.rawValue
        
        self.targetReps = targetReps
        self.targetLoad = targetLoad
        self.targetRIR = targetRIR
        self.targetRPE = targetRPE
        
        self.isDeleted = false
    }
    
    var category: SetCategory {
        get { SetCategory(rawValue: categoryRaw) ?? .resistance }
        set { categoryRaw = newValue.rawValue }
    }
    
    var type: SetType {
        get { SetType(rawValue: typeRaw) ?? .straight }
        set { typeRaw = newValue.rawValue }
    }
    
    var stimulus: SetStimulus? {
        get { stimulusRaw.flatMap(SetStimulus.init(rawValue:)) }
        set { stimulusRaw = newValue?.rawValue }
    }
}

// MARK: - SetRecord (logged set in a workout/session)

@Model
final class SetRecord {
    @Attribute(.unique) var id: UUID
    
    // Link to workout / exercise instance
    var workoutId: UUID      // id of Workout / SessionInstance
    var exerciseId: UUID     // id of Exercise used at time of logging
    
    /// Optional link to template this set came from (if session was pre-planned)
    var setTemplateId: UUID?
    
    var orderIndex: Int
    
    var categoryRaw: String
    var typeRaw: String
    var stimulusRaw: String?
    
    // Performance data
    var load: Double?         // lbs/kg – interpreted via user settings
    var reps: Int?
    var rir: Int?             // Rating of “reps in reserve”
    var rpe: Double?          // 1–10
    var timeUnderTension: TimeInterval?  // optional, future
    
    // Cardio-specific fields (for cardio rounds)
    var duration: TimeInterval?   // seconds
    var distance: Double?         // meters / km / miles (interpret via context)
    var averageHeartRate: Int?
    
    // Flags / meta
    var isLogged: Bool
    var isSkipped: Bool
    var failureTypeRaw: String
    var restTypeRaw: String?
    
    // For drop & myo sets
    @Relationship(deleteRule: .cascade, inverse: \MiniSet.parentSet)
    var miniSets: [MiniSet]
    
    init(
        workoutId: UUID,
        exerciseId: UUID,
        orderIndex: Int,
        category: SetCategory,
        type: SetType,
        stimulus: SetStimulus? = nil
    ) {
        self.id = UUID()
        self.workoutId = workoutId
        self.exerciseId = exerciseId
        self.setTemplateId = nil
        self.orderIndex = orderIndex
        
        self.categoryRaw = category.rawValue
        self.typeRaw = type.rawValue
        self.stimulusRaw = stimulus?.rawValue
        
        self.isLogged = false
        self.isSkipped = false
        self.failureTypeRaw = SetFailureType.none.rawValue
        
        self.miniSets = []
    }
    
    var category: SetCategory {
        get { SetCategory(rawValue: categoryRaw) ?? .resistance }
        set { categoryRaw = newValue.rawValue }
    }
    
    var type: SetType {
        get { SetType(rawValue: typeRaw) ?? .straight }
        set { typeRaw = newValue.rawValue }
    }
    
    var stimulus: SetStimulus? {
        get { stimulusRaw.flatMap(SetStimulus.init(rawValue:)) }
        set { stimulusRaw = newValue?.rawValue }
    }
    
    var failureType: SetFailureType {
        get { SetFailureType(rawValue: failureTypeRaw) ?? .none }
        set { failureTypeRaw = newValue.rawValue }
    }
    
    var restType: RestType? {
        get { restTypeRaw.flatMap(RestType.init(rawValue:)) }
        set { restTypeRaw = newValue?.rawValue }
    }
}

// MARK: - MiniSet (for Drop & Myo sets)

@Model
final class MiniSet {
    @Attribute(.unique) var id: UUID
    
    @Relationship var parentSet: SetRecord
    
    var indexInParent: Int      // 0,1,2,... within the drop/myo cluster
    
    var load: Double?
    var reps: Int?
    var rir: Int?
    var rpe: Double?
    
    var isLast: Bool    // true = the mini-set that gets the RPE in UI
    
    init(
        parentSet: SetRecord,
        indexInParent: Int,
        load: Double? = nil,
        reps: Int? = nil,
        rir: Int? = nil,
        rpe: Double? = nil,
        isLast: Bool = false
    ) {
        self.id = UUID()
        self.parentSet = parentSet
        self.indexInParent = indexInParent
        self.load = load
        self.reps = reps
        self.rir = rir
        self.rpe = rpe
        self.isLast = isLast
    }
}
