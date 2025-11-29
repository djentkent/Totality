//
//  ExerciseSeeder.swift
//  Totality
//
//  Created by Kent Wilson on 11/28/25.
//

import Foundation
import SwiftData

struct ExerciseSeeder {
    
    static func seedIfNeeded(in context: ModelContext) throws {
        let fetch = FetchDescriptor<Exercise>()
        let count = try context.fetch(fetch).count
        if count > 0 {
            return
        }
        
        let definitions: [ExerciseDefinition] = ExerciseLibrary.all
        
        for def in definitions {
            let exercise = def.makeExercise()
            context.insert(exercise)
        }
        
        try context.save()
    }
}

// MARK: - Individual Exercise Definitions

private extension ExerciseSeeder {
    
    static func barbellFlatBenchPress() -> ExerciseDefinition {
        ExerciseDefinition(
            name: "Barbell Flat Bench Press",
            akaNames: ["Barbell Bench Press", "Barbell Chest Press", "Flat Barbell Bench"],
            category: .resistance,
            implement: .barbell,
            type: .compound,
            isUserCreated: false,
            
            primaryMovementPattern: .push,
            primaryPlane: .transverse,
            
            romBias: .full,
            rangeOfMotionClass: .full,
            
            angle: .flat,
            bodyPosition: .supine,
            
            defaultGripOrientation: .pronated,
            defaultGripWidth: .shoulderWidth,
            defaultStance: .hipWidth,
            
            lateralType: .bilateralSymmetric,
            
            contractionBias: .mixed,
            velocityType: .normal,
            stabilityClass: .semiStable,
            
            primaryJointAction: .shoulderHorizontalFlexion,
            tissueLoadType: .mixed,
            
            forceCurve: .descending,
            movementArc: .horizontalPush,
            resistanceProfile: .freeWeight,
            forceVector: .vertical,
            
            overloadPotential: 5,
            stabilityDemand: 2,
            skillDemand: 3,
            difficultyRating: 3,
            
            allowedSetTypes: [
                .straight,
                .warmup,
                .backoff,
                .failure,
                .drop,
                .partialShort
            ],
            
            muscles: [
                ExerciseMuscleDefinition(
                    muscle: .pectorals,
                    role: .primaryAgonist,
                    emphasis: 5,
                    articulation: .monoarticular
                ),
                ExerciseMuscleDefinition(
                    muscle: .deltsAnterior,
                    role: .synergist,
                    emphasis: 3,
                    articulation: .monoarticular
                ),
                ExerciseMuscleDefinition(
                    muscle: .triceps,
                    role: .synergist,
                    emphasis: 4,
                    articulation: .biarticular
                ),
                ExerciseMuscleDefinition(
                    muscle: .lats,
                    role: .antagonist,
                    emphasis: 2,
                    articulation: .multiarticular
                )
            ],
            
            joints: [
                ExerciseJointDefinition(joint: .shoulder, loadEmphasis: 4),
                ExerciseJointDefinition(joint: .elbow, loadEmphasis: 3),
                ExerciseJointDefinition(joint: .wrist, loadEmphasis: 2)
            ],
            
            cardioProfile: nil,
            descriptionText: "Lie on a flat bench and press the barbell from chest to extended arms with control.",
            videoURL: nil
        )
    }
    
    static func inclineDumbbellBenchPress() -> ExerciseDefinition {
        ExerciseDefinition(
            name: "Dumbbell Incline Bench Press",
            akaNames: ["Incline DB Press", "Incline Dumbbell Chest Press"],
            category: .resistance,
            implement: .dumbbell,
            type: .compound,
            isUserCreated: false,
            
            primaryMovementPattern: .push,
            primaryPlane: .transverse,
            
            romBias: .full,
            rangeOfMotionClass: .full,
            
            angle: .inclineMedium,
            bodyPosition: .supine,
            
            defaultGripOrientation: .neutral,
            defaultGripWidth: .shoulderWidth,
            defaultStance: .hipWidth,
            
            lateralType: .bilateralSymmetric,
            
            contractionBias: .mixed,
            velocityType: .normal,
            stabilityClass: .unstable,
            
            primaryJointAction: .shoulderHorizontalFlexion,
            tissueLoadType: .muscleDominant,
            
            forceCurve: .descending,
            movementArc: .diagonal,
            resistanceProfile: .freeWeight,
            forceVector: .vertical,
            
            overloadPotential: 4,
            stabilityDemand: 3,
            skillDemand: 3,
            difficultyRating: 3,
            
            allowedSetTypes: [
                .straight,
                .warmup,
                .backoff,
                .failure,
                .drop,
                .myo
            ],
            
            muscles: [
                ExerciseMuscleDefinition(
                    muscle: .pectorals,
                    role: .primaryAgonist,
                    emphasis: 5,
                    articulation: .monoarticular
                ),
                ExerciseMuscleDefinition(
                    muscle: .deltsAnterior,
                    role: .synergist,
                    emphasis: 4,
                    articulation: .monoarticular
                ),
                ExerciseMuscleDefinition(
                    muscle: .triceps,
                    role: .synergist,
                    emphasis: 3,
                    articulation: .biarticular
                )
            ],
            
            joints: [
                ExerciseJointDefinition(joint: .shoulder, loadEmphasis: 4),
                ExerciseJointDefinition(joint: .elbow, loadEmphasis: 3)
            ],
            
            cardioProfile: nil,
            descriptionText: "Press dumbbells from chest to arms-length on an incline bench to emphasize upper chest.",
            videoURL: nil
        )
    }
    
    static func bentOverBarbellRow90() -> ExerciseDefinition {
        ExerciseDefinition(
            name: "Bent-Over Barbell Row (90°)",
            akaNames: ["Barbell Row", "Pendlay Row"],
            category: .resistance,
            implement: .barbell,
            type: .compound,
            isUserCreated: false,
            
            primaryMovementPattern: .pull,
            primaryPlane: .transverse,
            
            romBias: .full,
            rangeOfMotionClass: .full,
            
            angle: .bent90,
            bodyPosition: .hipHinged,
            
            defaultGripOrientation: .pronated,
            defaultGripWidth: .shoulderWidth,
            defaultStance: .hipWidth,
            
            lateralType: .bilateralSymmetric,
            
            contractionBias: .mixed,
            velocityType: .normal,
            stabilityClass: .unstable,
            
            primaryJointAction: .shoulderHorizontalExtension,
            tissueLoadType: .muscleDominant,
            
            forceCurve: .bellShaped,
            movementArc: .horizontalPull,
            resistanceProfile: .freeWeight,
            forceVector: .vertical,
            
            overloadPotential: 4,
            stabilityDemand: 4,
            skillDemand: 4,
            difficultyRating: 4,
            
            allowedSetTypes: [
                .straight,
                .warmup,
                .backoff,
                .failure
            ],
            
            muscles: [
                ExerciseMuscleDefinition(
                    muscle: .lats,
                    role: .primaryAgonist,
                    emphasis: 5,
                    articulation: .multiarticular
                ),
                ExerciseMuscleDefinition(
                    muscle: .midBack,
                    role: .synergist,
                    emphasis: 4,
                    articulation: .multiarticular
                ),
                ExerciseMuscleDefinition(
                    muscle: .biceps,
                    role: .synergist,
                    emphasis: 3,
                    articulation: .biarticular
                ),
                ExerciseMuscleDefinition(
                    muscle: .spinalErectors,
                    role: .synergist,
                    emphasis: 3,
                    articulation: .multiarticular
                )
            ],
            
            joints: [
                ExerciseJointDefinition(joint: .shoulder, loadEmphasis: 4),
                ExerciseJointDefinition(joint: .elbow, loadEmphasis: 3),
                ExerciseJointDefinition(joint: .spineLumbar, loadEmphasis: 4)
            ],
            
            cardioProfile: nil,
            descriptionText: "Hinge to 90° and row the bar from the floor or dead stop to your torso.",
            videoURL: nil
        )
    }
    
    static func treadmillSteadyState() -> ExerciseDefinition {
        ExerciseDefinition(
            name: "Treadmill Walk/Run",
            akaNames: ["Treadmill", "Treadmill Cardio"],
            category: .cardio,
            implement: .treadmill,
            type: .cardio,
            isUserCreated: false,
            
            primaryMovementPattern: .gait,
            primaryPlane: .sagittal,
            
            romBias: .variable,
            rangeOfMotionClass: .dynamic,
            
            angle: .flat,
            bodyPosition: .standing,
            
            defaultGripOrientation: .none,
            defaultGripWidth: .variable,
            defaultStance: .hipWidth,
            
            lateralType: .gaitPattern,
            
            contractionBias: .mixed,
            velocityType: .normal,
            stabilityClass: .externallyStabilized,
            
            primaryJointAction: .hipExtension,
            tissueLoadType: .mixed,
            
            forceCurve: .plateau,
            movementArc: .verticalPush,
            resistanceProfile: .machine,
            forceVector: .vertical,
            
            overloadPotential: 2,
            stabilityDemand: 2,
            skillDemand: 1,
            difficultyRating: 2,
            
            allowedSetTypes: [
                .straight,
                .warmup,
                .backoff,
                .cardioRound
            ],
            
            muscles: [
                ExerciseMuscleDefinition(
                    muscle: .glutes,
                    role: .primaryAgonist,
                    emphasis: 3,
                    articulation: .multiarticular
                ),
                ExerciseMuscleDefinition(
                    muscle: .quads,
                    role: .synergist,
                    emphasis: 3,
                    articulation: .biarticular
                ),
                ExerciseMuscleDefinition(
                    muscle: .hamstrings,
                    role: .synergist,
                    emphasis: 3,
                    articulation: .biarticular
                ),
                ExerciseMuscleDefinition(
                    muscle: .calves,
                    role: .synergist,
                    emphasis: 3,
                    articulation: .biarticular
                )
            ],
            
            joints: [
                ExerciseJointDefinition(joint: .hip, loadEmphasis: 3),
                ExerciseJointDefinition(joint: .knee, loadEmphasis: 3),
                ExerciseJointDefinition(joint: .ankle, loadEmphasis: 3)
            ],
            
            cardioProfile: CardioProfileDefinition(
                defaultRoundType: .steadyState,
                supportsDistance: true,
                supportsDuration: true,
                supportsHRZones: true,
                defaultZone: 2
            ),
            
            descriptionText: "Continuous walking or running on a treadmill at a chosen speed and incline.",
            videoURL: nil
        )
    }
}
