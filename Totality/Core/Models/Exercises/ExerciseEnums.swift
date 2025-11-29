//
//  Exercise.swift
//  Totality
//
//  Created by Kent Wilson on 11/24/25.
//

import Foundation

// MARK: - High-level exercise classification

enum ExerciseCategory: String, Codable {
    case resistance
    case cardio
    case mixed
    case mobility
    case rehab
}

enum ExerciseType: String, Codable {
    case compound
    case isolation
    case cardio
    case mixed
}

// Implement = main tool / modality
enum ImplementType: String, Codable {
    case barbell
    case dumbbell
    case machine
    case cable
    case band
    case kettlebell
    case bodyweight
    case trapBar
    case smithMachine
    case sled
    case battleRope
    case jumpRope
    case treadmill
    case bike
    case rower
    case elliptical
    case airBike
    case stairClimber
    case stationaryBike
    case other
}

// MARK: - Movement pattern & plane

enum MovementPattern: String, Codable {
    case push
    case pull
    case hinge
    case squat
    case lunge
    case tripleExtension
    case carry
    case gait
    case coreAntiExtension
    case coreAntiRotation
    case rotation
    case hipExtension
    case hipFlexion
    case kneeFlexion
    case kneeExtension
    case elbowFlexion
    case elbowExtension
    case horizontalAbduction
    case abduction
    case flexion
    case elevation
    case coreRotation
    case spinalFlexion
    case dorsiflexion
    case calfRaise
    case hipAbduction
    case hipAdduction
    case coreAntiLateralFlexion
    case other
}

enum PlaneOfMotion: String, Codable {
    case sagittal
    case frontal
    case transverse
    case multi
}

// ROM bias (simple)
enum ROMBias: String, Codable {
    case full
    case long
    case short
    case variable
}

// More explicit ROM class
enum RangeOfMotionClass: String, Codable {
    case full
    case longMuscleLength
    case shortMuscleLength
    case partial
    case dynamic
    case variable
}

// MARK: - Angle & body position

enum ExerciseAngle: String, Codable {
    case flat
    case inclineLow       // ~15–30°
    case inclineMedium    // ~30–45°
    case inclineHigh      // ~45–70°
    case declineLow
    case declineMedium
    case declineHigh
    case upright
    case bent45
    case bent90
    case custom
}

enum BodyPosition: String, Codable {
    case standing
    case seated
    case kneeling
    case halfKneeling
    case tallKneeling
    case supine        // lying on back
    case prone         // lying face down
    case sideLying
    case hipHinged
    case other
}

// MARK: - Grip & stance

enum GripOrientation: String, Codable {
    case pronated
    case supinated
    case neutral
    case mixed
    case none      // e.g., lower-body only
}

enum GripWidth: String, Codable {
    case narrow
    case shoulderWidth
    case wide
    case variable
    case none
}

enum StanceType: String, Codable {
    case feetTogether
    case hipWidth
    case shoulderWidth
    case wide
    case sumo
    case splitStance
    case singleLeg
    case other
}

// MARK: - Lateral / unilateral vs bilateral

enum LateralType: String, Codable {
    case bilateralSymmetric
    case bilateralAlternating
    case unilateral
    case contralateralLoad
    case ipsilateralLoad
    case crossBody
    case gaitPattern
    case other
}

// MARK: - Contraction, velocity, stability

enum ContractionBias: String, Codable {
    case concentricBiased        // e.g. paused squat
    case eccentricEmphasized     // nordic curl
    case stretchShorteningCycle  // plyos, jumps
    case isometric               // planks, wall sits
    case mixed
}

enum VelocityType: String, Codable {
    case slow
    case normal
    case explosive
    case plyometric
    case ballistic
}

enum StabilityClass: String, Codable {
    case externallyStabilized    // machines, leg press
    case semiStable              // chest-supported row
    case unstable                // standing DB
    case highlyUnstable          // BOSU, circus stuff
    case other
}

// MARK: - Joint action & tissue load

enum JointAction: String, Codable {
    case shoulderFlexion
    case shoulderExtension
    case shoulderHorizontalFlexion
    case shoulderHorizontalExtension
    case shoulderAbduction
    case shoulderAdduction
    
    case elbowFlexion
    case elbowExtension
    
    case hipFlexion
    case hipExtension
    case hipAbduction
    case hipAdduction
    
    case kneeFlexion
    case kneeExtension
    
    case anklePlantarflexion
    case ankleDorsiflexion
    
    case spinalFlexion
    case spinalExtension
    case spinalLateralFlexion
    case spinalRotation
    case spinalAntiExtension
    case spinalAntiFlexion
    case spinalAntiRotation
    
    case other
}

enum TissueLoadType: String, Codable {
    case tendonDominant
    case muscleDominant
    case jointCompressionHeavy
    case jointShearHeavy
    case mixed
}

// MARK: - Force curve, movement arc, vector, resistance profile

enum ForceCurve: String, Codable {
    case ascending
    case descending
    case bellShaped
    case plateau
    case variable
}

enum MovementArc: String, Codable {
    case verticalPush
    case verticalPull
    case horizontalPush
    case horizontalPull
    case diagonal
    case rotational
    case antiMovement
    case circular
    case other
}

enum ResistanceProfile: String, Codable {
    case freeWeight
    case cable
    case band
    case machine
    case bodyweight
    case hybrid
}

enum ForceVector: String, Codable {
    case vertical
    case horizontal
    case diagonal
    case rotational
    case anteriorPosterior
    case medialLateral
    case other
}

// MARK: - Muscles & joints

enum MuscleGroup: String, Codable {
    case pectorals
    case deltsAnterior
    case deltsLateral
    case deltsPosterior
    case lats
    case midBack
    case traps
    case trapsUpper
    case biceps
    case brachialis
    case brachioradialis
    case triceps
    case forearms
    case abs
    case obliques
    case spinalErectors
    case glutes
    case gluteMedius
    case quads
    case hamstrings
    case calves
    case tibialisAnterior
    case hipFlexors
    case adductors
    case abductors
    case other
}

enum MuscleRole: String, Codable {
    case primaryAgonist
    case synergist
    case antagonist
}

// mono vs bi-articulate etc.
enum MuscleArticulationType: String, Codable {
    case monoarticular   // crosses 1 joint
    case biarticular     // crosses 2 joints
    case multiarticular  // > 2 or complex
    case unknown
}

enum Joint: String, Codable {
    case shoulder
    case elbow
    case wrist
    case spineCervical
    case spineThoracic
    case spineLumbar
    case hip
    case knee
    case ankle
    case other
}

// MARK: - Exercise relations

enum ExerciseRelationType: String, Codable {
    case similar
    case substitute
    case antagonist
    case variation
}

