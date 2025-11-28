//
//  ExerciseModels.swift
//  Totality
//
//  Created by Kent Wilson on 11/28/25.
//

import Foundation
import SwiftData

// MARK: - Exercise Core Model

@Model
final class Exercise {
    @Attribute(.unique) var id: UUID
    var name: String
    
    // Identity / ownership
    var isUserCreated: Bool
    var isEditable: Bool
    var createdByUserId: UUID?
    var akaNames: [String]
    
    // High-level classification (raw)
    var categoryRaw: String
    var primaryImplementRaw: String
    var typeRaw: String
    
    // Movement / biomechanics (raw)
    var primaryMovementPatternRaw: String?
    var primaryPlaneRaw: String?
    
    var romBiasRaw: String?
    var rangeOfMotionClassRaw: String?
    
    var angleRaw: String?
    var bodyPositionRaw: String?
    
    var defaultGripOrientationRaw: String?
    var defaultGripWidthRaw: String?
    var defaultStanceRaw: String?
    
    var lateralTypeRaw: String?
    
    // Contraction / velocity / stability (raw)
    var contractionBiasRaw: String?
    var velocityTypeRaw: String?
    var stabilityClassRaw: String?
    
    // Joint action / tissue load (raw)
    var primaryJointActionRaw: String?
    var tissueLoadTypeRaw: String?
    
    // Force / arc / resistance (raw)
    var forceCurveRaw: String?
    var movementArcRaw: String?
    var resistanceProfileRaw: String?
    var forceVectorRaw: String?
    
    // Ratings
    var overloadPotential: Int?      // 1–5
    var stabilityDemand: Int?       // 1–5
    var skillDemand: Int?           // 1–5
    var difficultyRating: Int?      // 1–5
    
    // Technique compatibility
    var allowedSetTypesRaw: [String]
    
    // Content
    var descriptionText: String?
    var videoURL: URL?
    
    // Relationships
    @Relationship(deleteRule: .cascade, inverse: \ExerciseMuscle.exercise)
    var muscles: [ExerciseMuscle]
    
    @Relationship(deleteRule: .cascade, inverse: \ExerciseJoint.exercise)
    var joints: [ExerciseJoint]
    
    @Relationship(deleteRule: .cascade, inverse: \ExerciseRelation.fromExercise)
    var relationsFrom: [ExerciseRelation]
    
    @Relationship(deleteRule: .cascade, inverse: \ExerciseRelation.toExercise)
    var relationsTo: [ExerciseRelation]
    
    // Cardio profile (optional)
    @Relationship(deleteRule: .cascade)
    var cardioProfile: CardioProfile?
    
    // MARK: - Init
    
    init(
        name: String,
        category: ExerciseCategory,
        implement: ImplementType,
        type: ExerciseType,
        isUserCreated: Bool = false,
        createdByUserId: UUID? = nil
    ) {
        self.id = UUID()
        self.name = name
        
        self.isUserCreated = isUserCreated
        self.isEditable = isUserCreated
        self.createdByUserId = createdByUserId
        
        self.akaNames = []
        
        self.categoryRaw = category.rawValue
        self.primaryImplementRaw = implement.rawValue
        self.typeRaw = type.rawValue
        
        self.allowedSetTypesRaw = []
        
        self.muscles = []
        self.joints = []
        self.relationsFrom = []
        self.relationsTo = []
    }
}

// MARK: - Enum Convenience

extension Exercise {
    var category: ExerciseCategory {
        get { ExerciseCategory(rawValue: categoryRaw) ?? .resistance }
        set { categoryRaw = newValue.rawValue }
    }
    
    var primaryImplement: ImplementType {
        get { ImplementType(rawValue: primaryImplementRaw) ?? .barbell }
        set { primaryImplementRaw = newValue.rawValue }
    }
    
    var type: ExerciseType {
        get { ExerciseType(rawValue: typeRaw) ?? .compound }
        set { typeRaw = newValue.rawValue }
    }
    
    var primaryMovementPattern: MovementPattern? {
        get { primaryMovementPatternRaw.flatMap(MovementPattern.init(rawValue:)) }
        set { primaryMovementPatternRaw = newValue?.rawValue }
    }
    
    var primaryPlane: PlaneOfMotion? {
        get { primaryPlaneRaw.flatMap(PlaneOfMotion.init(rawValue:)) }
        set { primaryPlaneRaw = newValue?.rawValue }
    }
    
    var romBias: ROMBias? {
        get { romBiasRaw.flatMap(ROMBias.init(rawValue:)) }
        set { romBiasRaw = newValue?.rawValue }
    }
    
    var rangeOfMotionClass: RangeOfMotionClass? {
        get { rangeOfMotionClassRaw.flatMap(RangeOfMotionClass.init(rawValue:)) }
        set { rangeOfMotionClassRaw = newValue?.rawValue }
    }
    
    var angle: ExerciseAngle? {
        get { angleRaw.flatMap(ExerciseAngle.init(rawValue:)) }
        set { angleRaw = newValue?.rawValue }
    }
    
    var bodyPosition: BodyPosition? {
        get { bodyPositionRaw.flatMap(BodyPosition.init(rawValue:)) }
        set { bodyPositionRaw = newValue?.rawValue }
    }
    
    var defaultGripOrientation: GripOrientation? {
        get { defaultGripOrientationRaw.flatMap(GripOrientation.init(rawValue:)) }
        set { defaultGripOrientationRaw = newValue?.rawValue }
    }
    
    var defaultGripWidth: GripWidth? {
        get { defaultGripWidthRaw.flatMap(GripWidth.init(rawValue:)) }
        set { defaultGripWidthRaw = newValue?.rawValue }
    }
    
    var defaultStance: StanceType? {
        get { defaultStanceRaw.flatMap(StanceType.init(rawValue:)) }
        set { defaultStanceRaw = newValue?.rawValue }
    }
    
    var lateralType: LateralType? {
        get { lateralTypeRaw.flatMap(LateralType.init(rawValue:)) }
        set { lateralTypeRaw = newValue?.rawValue }
    }
    
    var contractionBias: ContractionBias? {
        get { contractionBiasRaw.flatMap(ContractionBias.init(rawValue:)) }
        set { contractionBiasRaw = newValue?.rawValue }
    }
    
    var velocityType: VelocityType? {
        get { velocityTypeRaw.flatMap(VelocityType.init(rawValue:)) }
        set { velocityTypeRaw = newValue?.rawValue }
    }
    
    var stabilityClass: StabilityClass? {
        get { stabilityClassRaw.flatMap(StabilityClass.init(rawValue:)) }
        set { stabilityClassRaw = newValue?.rawValue }
    }
    
    var primaryJointAction: JointAction? {
        get { primaryJointActionRaw.flatMap(JointAction.init(rawValue:)) }
        set { primaryJointActionRaw = newValue?.rawValue }
    }
    
    var tissueLoadType: TissueLoadType? {
        get { tissueLoadTypeRaw.flatMap(TissueLoadType.init(rawValue:)) }
        set { tissueLoadTypeRaw = newValue?.rawValue }
    }
    
    var forceCurve: ForceCurve? {
        get { forceCurveRaw.flatMap(ForceCurve.init(rawValue:)) }
        set { forceCurveRaw = newValue?.rawValue }
    }
    
    var movementArc: MovementArc? {
        get { movementArcRaw.flatMap(MovementArc.init(rawValue:)) }
        set { movementArcRaw = newValue?.rawValue }
    }
    
    var resistanceProfile: ResistanceProfile? {
        get { resistanceProfileRaw.flatMap(ResistanceProfile.init(rawValue:)) }
        set { resistanceProfileRaw = newValue?.rawValue }
    }
    
    var forceVector: ForceVector? {
        get { forceVectorRaw.flatMap(ForceVector.init(rawValue:)) }
        set { forceVectorRaw = newValue?.rawValue }
    }
    
    var allowedSetTypes: [SetType] {
        get { allowedSetTypesRaw.compactMap(SetType.init(rawValue:)) }
        set { allowedSetTypesRaw = newValue.map { $0.rawValue } }
    }
}

// MARK: - Muscles & joints for an exercise

@Model
final class ExerciseMuscle {
    @Attribute(.unique) var id: UUID
    
    @Relationship var exercise: Exercise
    
    var muscleRaw: String
    var roleRaw: String
    var emphasis: Int        // 1–5
    var articulationRaw: String
    
    init(
        exercise: Exercise,
        muscle: MuscleGroup,
        role: MuscleRole,
        emphasis: Int,
        articulation: MuscleArticulationType = .unknown
    ) {
        self.id = UUID()
        self.exercise = exercise
        
        self.muscleRaw = muscle.rawValue
        self.roleRaw = role.rawValue
        self.emphasis = emphasis
        self.articulationRaw = articulation.rawValue
    }
    
    var muscle: MuscleGroup {
        get { MuscleGroup(rawValue: muscleRaw) ?? .other }
        set { muscleRaw = newValue.rawValue }
    }
    
    var role: MuscleRole {
        get { MuscleRole(rawValue: roleRaw) ?? .primaryAgonist }
        set { roleRaw = newValue.rawValue }
    }
    
    var articulation: MuscleArticulationType {
        get { MuscleArticulationType(rawValue: articulationRaw) ?? .unknown }
        set { articulationRaw = newValue.rawValue }
    }
}

@Model
final class ExerciseJoint {
    @Attribute(.unique) var id: UUID
    
    @Relationship var exercise: Exercise
    
    var jointRaw: String
    var loadEmphasis: Int     // 1–5
    
    init(exercise: Exercise, joint: Joint, loadEmphasis: Int) {
        self.id = UUID()
        self.exercise = exercise
        self.jointRaw = joint.rawValue
        self.loadEmphasis = loadEmphasis
    }
    
    var joint: Joint {
        get { Joint(rawValue: jointRaw) ?? .other }
        set { jointRaw = newValue.rawValue }
    }
}

// MARK: - Exercise relations (similar / substitute / antagonist / variation)

@Model
final class ExerciseRelation {
    @Attribute(.unique) var id: UUID
    
    @Relationship var fromExercise: Exercise
    @Relationship var toExercise: Exercise
    
    var typeRaw: String
    var similarityScore: Double   // 0–1
    
    init(
        from: Exercise,
        to: Exercise,
        type: ExerciseRelationType,
        similarityScore: Double
    ) {
        self.id = UUID()
        self.fromExercise = from
        self.toExercise = to
        self.typeRaw = type.rawValue
        self.similarityScore = similarityScore
    }
    
    var type: ExerciseRelationType {
        get { ExerciseRelationType(rawValue: typeRaw) ?? .similar }
        set { typeRaw = newValue.rawValue }
    }
}

// MARK: - Cardio profile (optional)

enum CardioRoundType: String, Codable {
    case steadyState
    case intervals
    case emom
    case tabata
    case mixed
    case zoneBased
}

@Model
final class CardioProfile {
    @Attribute(.unique) var id: UUID
    
    @Relationship var exercise: Exercise
    
    var defaultRoundTypeRaw: String
    var supportsDistance: Bool
    var supportsDuration: Bool
    var supportsHRZones: Bool
    var defaultZone: Int?       // e.g., 2 for zone 2
    
    init(
        exercise: Exercise,
        defaultRoundType: CardioRoundType,
        supportsDistance: Bool,
        supportsDuration: Bool,
        supportsHRZones: Bool,
        defaultZone: Int? = nil
    ) {
        self.id = UUID()
        self.exercise = exercise
        self.defaultRoundTypeRaw = defaultRoundType.rawValue
        self.supportsDistance = supportsDistance
        self.supportsDuration = supportsDuration
        self.supportsHRZones = supportsHRZones
        self.defaultZone = defaultZone
    }
    
    var defaultRoundType: CardioRoundType {
        get { CardioRoundType(rawValue: defaultRoundTypeRaw) ?? .steadyState }
        set { defaultRoundTypeRaw = newValue.rawValue }
    }
}
