//
// ExerciseDefinition.swift
//  Totality
//
//  Created by Kent Wilson on 11/28/25.
//


import Foundation
import SwiftData

/// A helper struct for defining canonical exercises in a clean, consistent way.
/// Use this in your seeder or anywhere you want to construct an Exercise with full metadata
/// without manually setting every property each time.
struct ExerciseDefinition {
    // MARK: - Core
    
    let name: String
    let akaNames: [String]
    
    let category: ExerciseCategory
    let implement: ImplementType
    let type: ExerciseType
    
    /// For built-ins this will normally be `false`. For user exercises
    /// you probably won't use ExerciseDefinition at all, but the field is here
    /// for flexibility.
    let isUserCreated: Bool
    
    // MARK: - Movement & plane
    
    let primaryMovementPattern: MovementPattern?
    let primaryPlane: PlaneOfMotion?
    
    // MARK: - ROM, angle, position
    
    let romBias: ROMBias?
    let rangeOfMotionClass: RangeOfMotionClass?
    
    let angle: ExerciseAngle?
    let bodyPosition: BodyPosition?
    
    // MARK: - Grip, stance, lateral
    
    let defaultGripOrientation: GripOrientation?
    let defaultGripWidth: GripWidth?
    let defaultStance: StanceType?
    
    let lateralType: LateralType?
    
    // MARK: - Contraction, velocity, stability
    
    let contractionBias: ContractionBias?
    let velocityType: VelocityType?
    let stabilityClass: StabilityClass?
    
    // MARK: - Joint action & tissue load
    
    let primaryJointAction: JointAction?
    let tissueLoadType: TissueLoadType?
    
    // MARK: - Force / arc / resistance
    
    let forceCurve: ForceCurve?
    let movementArc: MovementArc?
    let resistanceProfile: ResistanceProfile?
    let forceVector: ForceVector?
    
    // MARK: - Ratings
    
    let overloadPotential: Int?    // 1–5
    let stabilityDemand: Int?      // 1–5
    let skillDemand: Int?          // 1–5
    let difficultyRating: Int?     // 1–5
    
    // MARK: - Set method compatibility
    
    let allowedSetTypes: [SetType]
    
    // MARK: - Muscles, joints, cardio
    
    let muscles: [ExerciseMuscleDefinition]
    let joints: [ExerciseJointDefinition]
    let cardioProfile: CardioProfileDefinition?
    
    // MARK: - Content
    
    let descriptionText: String?
    let videoURL: URL?
    
    // MARK: - Init with sensible defaults
    
    init(
        name: String,
        akaNames: [String] = [],
        category: ExerciseCategory,
        implement: ImplementType,
        type: ExerciseType,
        isUserCreated: Bool = false,
        
        primaryMovementPattern: MovementPattern? = nil,
        primaryPlane: PlaneOfMotion? = nil,
        
        romBias: ROMBias? = nil,
        rangeOfMotionClass: RangeOfMotionClass? = nil,
        
        angle: ExerciseAngle? = nil,
        bodyPosition: BodyPosition? = nil,
        
        defaultGripOrientation: GripOrientation? = nil,
        defaultGripWidth: GripWidth? = nil,
        defaultStance: StanceType? = nil,
        
        lateralType: LateralType? = nil,
        
        contractionBias: ContractionBias? = nil,
        velocityType: VelocityType? = nil,
        stabilityClass: StabilityClass? = nil,
        
        primaryJointAction: JointAction? = nil,
        tissueLoadType: TissueLoadType? = nil,
        
        forceCurve: ForceCurve? = nil,
        movementArc: MovementArc? = nil,
        resistanceProfile: ResistanceProfile? = nil,
        forceVector: ForceVector? = nil,
        
        overloadPotential: Int? = nil,
        stabilityDemand: Int? = nil,
        skillDemand: Int? = nil,
        difficultyRating: Int? = nil,
        
        allowedSetTypes: [SetType] = [],
        
        muscles: [ExerciseMuscleDefinition] = [],
        joints: [ExerciseJointDefinition] = [],
        cardioProfile: CardioProfileDefinition? = nil,
        
        descriptionText: String? = nil,
        videoURL: URL? = nil
    ) {
        self.name = name
        self.akaNames = akaNames
        self.category = category
        self.implement = implement
        self.type = type
        self.isUserCreated = isUserCreated
        
        self.primaryMovementPattern = primaryMovementPattern
        self.primaryPlane = primaryPlane
        
        self.romBias = romBias
        self.rangeOfMotionClass = rangeOfMotionClass
        
        self.angle = angle
        self.bodyPosition = bodyPosition
        
        self.defaultGripOrientation = defaultGripOrientation
        self.defaultGripWidth = defaultGripWidth
        self.defaultStance = defaultStance
        
        self.lateralType = lateralType
        
        self.contractionBias = contractionBias
        self.velocityType = velocityType
        self.stabilityClass = stabilityClass
        
        self.primaryJointAction = primaryJointAction
        self.tissueLoadType = tissueLoadType
        
        self.forceCurve = forceCurve
        self.movementArc = movementArc
        self.resistanceProfile = resistanceProfile
        self.forceVector = forceVector
        
        self.overloadPotential = overloadPotential
        self.stabilityDemand = stabilityDemand
        self.skillDemand = skillDemand
        self.difficultyRating = difficultyRating
        
        self.allowedSetTypes = allowedSetTypes
        
        self.muscles = muscles
        self.joints = joints
        self.cardioProfile = cardioProfile
        
        self.descriptionText = descriptionText
        self.videoURL = videoURL
    }
    
    // MARK: - Materializer
    
    /// Build a fully-populated Exercise (with muscles, joints, cardio profile).
    /// You can then insert this Exercise into your ModelContext (`context.insert(ex)`).
    func makeExercise() -> Exercise {
        let exercise = Exercise(
            name: name,
            category: category,
            implement: implement,
            type: type,
            isUserCreated: isUserCreated
        )
        
        // Identity / content
        exercise.akaNames = akaNames
        exercise.descriptionText = descriptionText
        exercise.videoURL = videoURL
        
        // Movement & plane
        exercise.primaryMovementPattern = primaryMovementPattern
        exercise.primaryPlane = primaryPlane
        
        // ROM / angle / position
        exercise.romBias = romBias
        exercise.rangeOfMotionClass = rangeOfMotionClass
        exercise.angle = angle
        exercise.bodyPosition = bodyPosition
        
        // Grip / stance / lateral
        exercise.defaultGripOrientation = defaultGripOrientation
        exercise.defaultGripWidth = defaultGripWidth
        exercise.defaultStance = defaultStance
        exercise.lateralType = lateralType
        
        // Contraction / velocity / stability
        exercise.contractionBias = contractionBias
        exercise.velocityType = velocityType
        exercise.stabilityClass = stabilityClass
        
        // Joint action / tissue load
        exercise.primaryJointAction = primaryJointAction
        exercise.tissueLoadType = tissueLoadType
        
        // Force / arc / resistance
        exercise.forceCurve = forceCurve
        exercise.movementArc = movementArc
        exercise.resistanceProfile = resistanceProfile
        exercise.forceVector = forceVector
        
        // Ratings
        exercise.overloadPotential = overloadPotential
        exercise.stabilityDemand = stabilityDemand
        exercise.skillDemand = skillDemand
        exercise.difficultyRating = difficultyRating
        
        // Set methods
        exercise.allowedSetTypes = allowedSetTypes
        
        // Muscles
        for m in muscles {
            _ = ExerciseMuscle(
                exercise: exercise,
                muscle: m.muscle,
                role: m.role,
                emphasis: m.emphasis,
                articulation: m.articulation
            )
        }
        
        // Joints
        for j in joints {
            _ = ExerciseJoint(
                exercise: exercise,
                joint: j.joint,
                loadEmphasis: j.loadEmphasis
            )
        }
        
        // Cardio profile
        if let cp = cardioProfile {
            let profile = CardioProfile(
                exercise: exercise,
                defaultRoundType: cp.defaultRoundType,
                supportsDistance: cp.supportsDistance,
                supportsDuration: cp.supportsDuration,
                supportsHRZones: cp.supportsHRZones,
                defaultZone: cp.defaultZone
            )
            exercise.cardioProfile = profile
        }
        
        return exercise
    }
}

// MARK: - Helper definitions

/// Defines a muscle involvement for an exercise.
struct ExerciseMuscleDefinition {
    let muscle: MuscleGroup
    let role: MuscleRole
    let emphasis: Int               // 1–5
    let articulation: MuscleArticulationType
    
    init(
        muscle: MuscleGroup,
        role: MuscleRole,
        emphasis: Int,
        articulation: MuscleArticulationType = .unknown
    ) {
        self.muscle = muscle
        self.role = role
        self.emphasis = emphasis
        self.articulation = articulation
    }
}

/// Defines a joint loading characteristic for an exercise.
struct ExerciseJointDefinition {
    let joint: Joint
    let loadEmphasis: Int           // 1–5
    
    init(joint: Joint, loadEmphasis: Int) {
        self.joint = joint
        self.loadEmphasis = loadEmphasis
    }
}

/// Defines cardio-specific metadata for cardio-capable exercises.
struct CardioProfileDefinition {
    let defaultRoundType: CardioRoundType
    let supportsDistance: Bool
    let supportsDuration: Bool
    let supportsHRZones: Bool
    let defaultZone: Int?
    
    init(
        defaultRoundType: CardioRoundType,
        supportsDistance: Bool,
        supportsDuration: Bool,
        supportsHRZones: Bool,
        defaultZone: Int? = nil
    ) {
        self.defaultRoundType = defaultRoundType
        self.supportsDistance = supportsDistance
        self.supportsDuration = supportsDuration
        self.supportsHRZones = supportsHRZones
        self.defaultZone = defaultZone
    }
}
