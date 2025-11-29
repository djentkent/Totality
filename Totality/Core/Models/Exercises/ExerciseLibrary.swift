//
//  ExerciseLibrary.swift
//  Totality
//
//  Created by Kent Wilson on 11/29/25.
//


//
//  ExerciseLibrary.swift
//  Totality
//
//  Canonical hard-coded exercise library built with ExerciseDefinition.
//  Grouped by implement and region, but exposes a flattened `all` list
//  for use in ExerciseSeeder.
//

import Foundation

enum ExerciseLibrary {

    // MARK: - Top-level flattened access

    static var all: [ExerciseDefinition] {
        Bodyweight.all
        + Dumbbell.all
        + Barbell.all
        + SmithMachine.all
        + Machines.all
        + Cables.all
        + Bands.all
        + CardioMachines.all
    }

    // MARK: - Shared factories (practical metadata only)

    private enum Factory {

        // Generic resistance compound
        static func compound(
            name: String,
            aka: [String] = [],
            implement: ImplementType,
            primaryMovement: MovementPattern,
            primaryMuscle: MuscleGroup,
            stance: StanceType? = .hipWidth,
            lateral: LateralType? = .bilateralSymmetric
        ) -> ExerciseDefinition {
            ExerciseDefinition(
                name: name,
                akaNames: aka,
                category: .resistance,
                implement: implement,
                type: .compound,
                isUserCreated: false,
                primaryMovementPattern: primaryMovement,
                defaultStance: stance,
                lateralType: lateral,
                overloadPotential: overloadForCompound(implement: implement),
                stabilityDemand: stabilityForCompound(implement: implement),
                skillDemand: skillForCompound(implement: implement),
                difficultyRating: difficultyForCompound(implement: implement),
                allowedSetTypes: [.straight, .warmup, .backoff, .failure],
                muscles: [
                    ExerciseMuscleDefinition(
                        muscle: primaryMuscle,
                        role: .primaryAgonist,
                        emphasis: 5,
                        articulation: .unknown
                    )
                ]
            )
        }

        // Generic resistance isolation
        static func isolation(
            name: String,
            aka: [String] = [],
            implement: ImplementType,
            primaryMovement: MovementPattern,
            primaryMuscle: MuscleGroup,
            stance: StanceType? = .hipWidth,
            lateral: LateralType? = .bilateralSymmetric
        ) -> ExerciseDefinition {
            ExerciseDefinition(
                name: name,
                akaNames: aka,
                category: .resistance,
                implement: implement,
                type: .isolation,
                isUserCreated: false,
                primaryMovementPattern: primaryMovement,
                defaultStance: stance,
                lateralType: lateral,
                overloadPotential: 3,
                stabilityDemand: 2,
                skillDemand: 2,
                difficultyRating: 2,
                allowedSetTypes: [.straight, .warmup, .backoff, .failure],
                muscles: [
                    ExerciseMuscleDefinition(
                        muscle: primaryMuscle,
                        role: .primaryAgonist,
                        emphasis: 5,
                        articulation: .unknown
                    )
                ]
            )
        }

        // Generic bodyweight core
        static func core(
            name: String,
            aka: [String] = [],
            primaryMovement: MovementPattern,
            primaryMuscle: MuscleGroup = .abs
        ) -> ExerciseDefinition {
            ExerciseDefinition(
                name: name,
                akaNames: aka,
                category: .resistance,
                implement: .bodyweight,
                type: .isolation,
                isUserCreated: false,
                primaryMovementPattern: primaryMovement,
                defaultStance: .none,
                lateralType: .bilateralSymmetric,
                overloadPotential: 2,
                stabilityDemand: 3,
                skillDemand: 2,
                difficultyRating: 2,
                allowedSetTypes: [.straight, .warmup, .failure],
                muscles: [
                    ExerciseMuscleDefinition(
                        muscle: primaryMuscle,
                        role: .primaryAgonist,
                        emphasis: 5,
                        articulation: .unknown
                    )
                ]
            )
        }

        // Generic cardio machine
        static func cardioMachine(
            name: String,
            aka: [String] = [],
            implement: ImplementType,
            defaultZone: Int = 2
        ) -> ExerciseDefinition {
            ExerciseDefinition(
                name: name,
                akaNames: aka,
                category: .cardio,
                implement: implement,
                type: .cardio,
                isUserCreated: false,
                primaryMovementPattern: .gait,
                defaultStance: .hipWidth,
                lateralType: .gaitPattern,
                overloadPotential: 2,
                stabilityDemand: 2,
                skillDemand: 1,
                difficultyRating: 2,
                allowedSetTypes: [.straight, .warmup, .cardioRound],
                muscles: [
                    ExerciseMuscleDefinition(
                        muscle: .glutes,
                        role: .primaryAgonist,
                        emphasis: 3,
                        articulation: .multiarticular
                    )
                ],
                joints: [],
                cardioProfile: CardioProfileDefinition(
                    defaultRoundType: .steadyState,
                    supportsDistance: true,
                    supportsDuration: true,
                    supportsHRZones: true,
                    defaultZone: defaultZone
                )
            )
        }

        // MARK: Ratings helpers

        private static func overloadForCompound(implement: ImplementType) -> Int {
            switch implement {
            case .barbell, .smithMachine: return 5
            case .machine, .cable, .trapBar: return 4
            case .dumbbell, .kettlebell: return 4
            case .bodyweight, .band: return 3
            default: return 3
            }
        }

        private static func stabilityForCompound(implement: ImplementType) -> Int {
            switch implement {
            case .machine, .smithMachine: return 2
            case .barbell, .dumbbell, .kettlebell: return 3
            case .bodyweight: return 3
            default: return 2
            }
        }

        private static func skillForCompound(implement: ImplementType) -> Int {
            switch implement {
            case .barbell: return 3
            case .dumbbell, .kettlebell: return 3
            case .bodyweight: return 2
            case .machine, .smithMachine: return 2
            default: return 2
            }
        }

        private static func difficultyForCompound(implement: ImplementType) -> Int {
            switch implement {
            case .barbell: return 4
            case .dumbbell, .kettlebell, .bodyweight: return 3
            case .machine, .smithMachine: return 2
            default: return 3
            }
        }
    }

    // MARK: - Bodyweight

    enum Bodyweight {
        static var all: [ExerciseDefinition] {
            upperBody + lowerBody + core
        }

        // Upper body
        private static let upperBody: [ExerciseDefinition] = [
            Factory.compound(
                name: "Push-Up",
                aka: ["Pushup", "Standard Push-Up"],
                implement: .bodyweight,
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            Factory.compound(
                name: "Deficit Push-Up",
                aka: ["Deficit Pushup", "Deep Push-Up"],
                implement: .bodyweight,
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            Factory.compound(
                name: "Pull-Up",
                aka: ["Overhand Pull-Up"],
                implement: .bodyweight,
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            Factory.compound(
                name: "Chin-Up",
                aka: ["Underhand Pull-Up"],
                implement: .bodyweight,
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            Factory.compound(
                name: "Dip",
                aka: ["Parallel Bar Dip"],
                implement: .bodyweight,
                primaryMovement: .push,
                primaryMuscle: .pectorals,
                stance: .none
            ),
            Factory.compound(
                name: "Leaning Dip",
                aka: ["Chest-Focused Dip"],
                implement: .bodyweight,
                primaryMovement: .push,
                primaryMuscle: .pectorals,
                stance: .none
            ),
            Factory.compound(
                name: "Inverted Row",
                aka: ["Bodyweight Row"],
                implement: .bodyweight,
                primaryMovement: .pull,
                primaryMuscle: .midBack
            )
        ]

        // Lower body
        private static let lowerBody: [ExerciseDefinition] = [
            Factory.compound(
                name: "Bodyweight Squat",
                aka: ["Air Squat"],
                implement: .bodyweight,
                primaryMovement: .squat,
                primaryMuscle: .quads
            ),
            Factory.compound(
                name: "Split Squat",
                aka: ["Static Lunge"],
                implement: .bodyweight,
                primaryMovement: .lunge,
                primaryMuscle: .quads,
                stance: .splitStance,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Lunge",
                aka: ["Forward Lunge"],
                implement: .bodyweight,
                primaryMovement: .lunge,
                primaryMuscle: .quads,
                stance: .splitStance,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Walking Lunge",
                aka: ["Lunge Walk"],
                implement: .bodyweight,
                primaryMovement: .lunge,
                primaryMuscle: .quads,
                stance: .splitStance,
                lateral: .gaitPattern
            ),
            Factory.compound(
                name: "Reverse Lunge",
                aka: ["Backward Lunge"],
                implement: .bodyweight,
                primaryMovement: .lunge,
                primaryMuscle: .glutes,
                stance: .splitStance,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Lateral Lunge",
                aka: ["Cossack Lunge"],
                implement: .bodyweight,
                primaryMovement: .lunge,
                primaryMuscle: .adductors,
                stance: .wide,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Step-Up",
                aka: ["Box Step-Up"],
                implement: .bodyweight,
                primaryMovement: .lunge,
                primaryMuscle: .glutes,
                stance: .singleLeg,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Glute Bridge",
                aka: ["Hip Bridge"],
                implement: .bodyweight,
                primaryMovement: .hinge,
                primaryMuscle: .glutes
            ),
            Factory.compound(
                name: "Kneeling Leg Extension",
                aka: ["Sissy Squat (Kneeling)"],
                implement: .bodyweight,
                primaryMovement: .squat,
                primaryMuscle: .quads
            ),
            Factory.isolation(
                name: "Nordic Hamstring Curl",
                aka: ["Nordic Curl", "Hamstring Curl (Nordic)"],
                implement: .bodyweight,
                primaryMovement: .hinge,
                primaryMuscle: .hamstrings
            ),
            Factory.isolation(
                name: "Standing Calf Raise",
                aka: ["Bodyweight Calf Raise"],
                implement: .bodyweight,
                primaryMovement: .calfRaise,
                primaryMuscle: .calves
            ),
            Factory.isolation(
                name: "Standing Tibialis Raise",
                aka: ["Tib Raise"],
                implement: .bodyweight,
                primaryMovement: .dorsiflexion,
                primaryMuscle: .tibialisAnterior
            )
        ]

        // Core / trunk
        private static let core: [ExerciseDefinition] = [
            Factory.core(
                name: "Plank",
                aka: ["Front Plank"],
                primaryMovement: .coreAntiExtension
            ),
            Factory.core(
                name: "Side Plank",
                aka: ["Lateral Plank"],
                primaryMovement: .coreAntiLateralFlexion
            ),
            Factory.core(
                name: "Hollow Hold",
                aka: ["Hollow Body Hold"],
                primaryMovement: .coreAntiExtension
            ),
            Factory.core(
                name: "Back Extension",
                aka: ["Roman Chair Back Extension", "Hyperextension"],
                primaryMovement: .hipExtension,
                primaryMuscle: .spinalErectors
            ),
            Factory.core(
                name: "Leg Raise",
                aka: ["Hanging Leg Raise"],
                primaryMovement: .hipFlexion,
                primaryMuscle: .hipFlexors
            ),
            Factory.core(
                name: "Lying Leg Raise",
                aka: ["Supine Leg Raise"],
                primaryMovement: .hipFlexion,
                primaryMuscle: .hipFlexors
            ),
            Factory.core(
                name: "Crunch",
                aka: ["Ab Crunch"],
                primaryMovement: .spinalFlexion
            ),
            Factory.core(
                name: "Sit-Up",
                aka: ["Full Sit-Up"],
                primaryMovement: .spinalFlexion
            ),
            Factory.core(
                name: "Russian Twist",
                aka: ["Seated Russian Twist"],
                primaryMovement: .coreRotation
            ),
            Factory.core(
                name: "Bicycle Crunch",
                aka: ["Bicycles"],
                primaryMovement: .spinalFlexion
            ),
            Factory.core(
                name: "Superman",
                aka: ["Prone Back Extension (Superman)"],
                primaryMovement: .hipExtension,
                primaryMuscle: .spinalErectors
            )
        ]
    }

    // MARK: - Dumbbells

    enum Dumbbell {
        static var all: [ExerciseDefinition] {
            upperBody + lowerBody + core
        }

        private static let upperBody: [ExerciseDefinition] = [
            // Chest
            Factory.compound(
                name: "Dumbbell Bench Press",
                aka: ["DB Bench Press"],
                implement: .dumbbell,
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            Factory.compound(
                name: "Dumbbell Floor Press",
                aka: ["DB Floor Press"],
                implement: .dumbbell,
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            Factory.compound(
                name: "Dumbbell Incline Bench Press",
                aka: ["DB Incline Bench Press", "Incline DB Press"],
                implement: .dumbbell,
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            Factory.compound(
                name: "Dumbbell Pullover",
                aka: ["DB Pullover"],
                implement: .dumbbell,
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            Factory.isolation(
                name: "Dumbbell Chest Fly",
                aka: ["DB Fly"],
                implement: .dumbbell,
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            Factory.isolation(
                name: "Dumbbell Incline Chest Fly",
                aka: ["DB Incline Fly"],
                implement: .dumbbell,
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            Factory.isolation(
                name: "Dumbbell Decline Chest Fly",
                aka: ["DB Decline Fly"],
                implement: .dumbbell,
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            Factory.isolation(
                name: "Dumbbell Full ROM Chest Fly",
                aka: ["DB Full ROM Fly"],
                implement: .dumbbell,
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),

            // Shoulders
            Factory.compound(
                name: "Dumbbell Shoulder Press",
                aka: ["DB Shoulder Press", "Standing DB Press"],
                implement: .dumbbell,
                primaryMovement: .push,
                primaryMuscle: .deltsAnterior
            ),
            Factory.compound(
                name: "Seated Dumbbell Shoulder Press",
                aka: ["DB Seated Shoulder Press"],
                implement: .dumbbell,
                primaryMovement: .push,
                primaryMuscle: .deltsAnterior
            ),
            Factory.isolation(
                name: "Dumbbell Lateral Raise",
                aka: ["DB Lateral Raise"],
                implement: .dumbbell,
                primaryMovement: .abduction,
                primaryMuscle: .deltsLateral
            ),
            Factory.isolation(
                name: "Dumbbell Front Raise",
                aka: ["DB Front Raise"],
                implement: .dumbbell,
                primaryMovement: .flexion,
                primaryMuscle: .deltsAnterior
            ),
            Factory.isolation(
                name: "Dumbbell Rear Delt Fly",
                aka: ["DB Rear Delt Fly"],
                implement: .dumbbell,
                primaryMovement: .horizontalAbduction,
                primaryMuscle: .deltsPosterior
            ),
            Factory.compound(
                name: "Dumbbell Upright Row",
                aka: ["DB Upright Row"],
                implement: .dumbbell,
                primaryMovement: .pull,
                primaryMuscle: .deltsLateral
            ),
            Factory.compound(
                name: "Dumbbell Military Press",
                aka: ["DB Military Press"],
                implement: .dumbbell,
                primaryMovement: .push,
                primaryMuscle: .deltsAnterior
            ),
            Factory.compound(
                name: "Dumbbell Arnold Press",
                aka: ["DB Arnold Press"],
                implement: .dumbbell,
                primaryMovement: .push,
                primaryMuscle: .deltsAnterior
            ),
            Factory.isolation(
                name: "Dumbbell Y Raise",
                aka: ["DB Y Raise"],
                implement: .dumbbell,
                primaryMovement: .abduction,
                primaryMuscle: .deltsPosterior
            ),
            Factory.isolation(
                name: "Dumbbell Shrug",
                aka: ["DB Shrug"],
                implement: .dumbbell,
                primaryMovement: .elevation,
                primaryMuscle: .trapsUpper
            ),

            // Back
            Factory.compound(
                name: "Dumbbell Row",
                aka: ["DB Row"],
                implement: .dumbbell,
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            Factory.compound(
                name: "Dumbbell Full ROM Row",
                aka: ["DB Full ROM Row"],
                implement: .dumbbell,
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            Factory.compound(
                name: "Single-Arm Dumbbell Row",
                aka: ["DB Single-Arm Row"],
                implement: .dumbbell,
                primaryMovement: .pull,
                primaryMuscle: .lats,
                stance: .splitStance,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Chest-Supported Dumbbell Row",
                aka: ["DB Chest-Supported Row"],
                implement: .dumbbell,
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            Factory.isolation(
                name: "Dumbbell Shrug (Back)",
                aka: ["DB Trap Shrug"],
                implement: .dumbbell,
                primaryMovement: .elevation,
                primaryMuscle: .trapsUpper
            ),

            // Biceps
            Factory.isolation(
                name: "Dumbbell Biceps Curl",
                aka: ["DB Curl"],
                implement: .dumbbell,
                primaryMovement: .elbowFlexion,
                primaryMuscle: .biceps
            ),
            Factory.isolation(
                name: "Dumbbell Hammer Curl",
                aka: ["DB Hammer Curl"],
                implement: .dumbbell,
                primaryMovement: .elbowFlexion,
                primaryMuscle: .brachialis
            ),
            Factory.isolation(
                name: "Dumbbell Concentration Curl",
                aka: ["DB Concentration Curl"],
                implement: .dumbbell,
                primaryMovement: .elbowFlexion,
                primaryMuscle: .biceps
            ),
            Factory.isolation(
                name: "Lying Dumbbell Biceps Curl",
                aka: ["DB Lying Biceps Curl"],
                implement: .dumbbell,
                primaryMovement: .elbowFlexion,
                primaryMuscle: .biceps
            ),
            Factory.isolation(
                name: "Dumbbell Preacher Curl",
                aka: ["DB Bench Preacher Curl"],
                implement: .dumbbell,
                primaryMovement: .elbowFlexion,
                primaryMuscle: .biceps
            ),
            Factory.isolation(
                name: "Alternating Dumbbell Curl",
                aka: ["DB Alternating Curl"],
                implement: .dumbbell,
                primaryMovement: .elbowFlexion,
                primaryMuscle: .biceps,
                lateral: .bilateralAlternating
            ),
            Factory.isolation(
                name: "Seated Dumbbell Curl",
                aka: ["DB Seated Curl"],
                implement: .dumbbell,
                primaryMovement: .elbowFlexion,
                primaryMuscle: .biceps
            ),
            Factory.isolation(
                name: "Dumbbell Zottman Curl",
                aka: ["DB Zottman Curl"],
                implement: .dumbbell,
                primaryMovement: .elbowFlexion,
                primaryMuscle: .biceps
            ),
            Factory.isolation(
                name: "Reverse-Grip Dumbbell Curl",
                aka: ["DB Reverse Grip Curl"],
                implement: .dumbbell,
                primaryMovement: .elbowFlexion,
                primaryMuscle: .brachioradialis
            ),
            Factory.isolation(
                name: "Dumbbell Spider Curl",
                aka: ["DB Spider Curl"],
                implement: .dumbbell,
                primaryMovement: .elbowFlexion,
                primaryMuscle: .biceps
            ),

            // Triceps
            Factory.isolation(
                name: "Overhead Dumbbell Triceps Extension",
                aka: ["DB Triceps Extension (Overhead)"],
                implement: .dumbbell,
                primaryMovement: .elbowExtension,
                primaryMuscle: .triceps
            ),
            Factory.isolation(
                name: "Single-Arm Overhead Dumbbell Extension",
                aka: ["DB Single-Arm Overhead Extension"],
                implement: .dumbbell,
                primaryMovement: .elbowExtension,
                primaryMuscle: .triceps,
                lateral: .unilateral
            ),
            Factory.isolation(
                name: "Dumbbell Triceps Kickback",
                aka: ["DB Kickback"],
                implement: .dumbbell,
                primaryMovement: .elbowExtension,
                primaryMuscle: .triceps
            ),
            Factory.isolation(
                name: "Dumbbell Skull Crusher",
                aka: ["DB Lying Triceps Extension"],
                implement: .dumbbell,
                primaryMovement: .elbowExtension,
                primaryMuscle: .triceps
            ),
            Factory.isolation(
                name: "Dumbbell French Press",
                aka: ["DB French Press"],
                implement: .dumbbell,
                primaryMovement: .elbowExtension,
                primaryMuscle: .triceps
            ),
            Factory.isolation(
                name: "Single-Arm Lying Dumbbell Triceps Extension",
                aka: ["DB Lying Single-Arm Triceps Extension"],
                implement: .dumbbell,
                primaryMovement: .elbowExtension,
                primaryMuscle: .triceps,
                lateral: .unilateral
            )
        ]

        private static let core: [ExerciseDefinition] = [
            Factory.core(
                name: "Dumbbell Leg Raise",
                aka: ["Weighted Leg Raise (DB)"],
                primaryMovement: .hipFlexion,
                primaryMuscle: .hipFlexors
            ),
            Factory.core(
                name: "Dumbbell Crunch",
                aka: ["Weighted Crunch (DB)"],
                primaryMovement: .spinalFlexion
            ),
            Factory.core(
                name: "Dumbbell Russian Twist",
                aka: ["Weighted Russian Twist (DB)"],
                primaryMovement: .coreRotation
            )
        ]

        private static let lowerBody: [ExerciseDefinition] = [
            Factory.compound(
                name: "Dumbbell Lunge",
                aka: ["DB Lunge"],
                implement: .dumbbell,
                primaryMovement: .lunge,
                primaryMuscle: .quads,
                stance: .splitStance,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Dumbbell Split Squat",
                aka: ["DB Split Squat"],
                implement: .dumbbell,
                primaryMovement: .lunge,
                primaryMuscle: .quads,
                stance: .splitStance,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Dumbbell Bulgarian Split Squat",
                aka: ["DB Bulgarian Split Squat"],
                implement: .dumbbell,
                primaryMovement: .lunge,
                primaryMuscle: .quads,
                stance: .splitStance,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Dumbbell Step-Up",
                aka: ["DB Step-Up"],
                implement: .dumbbell,
                primaryMovement: .lunge,
                primaryMuscle: .glutes,
                stance: .singleLeg,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Dumbbell Hip Thrust",
                aka: ["DB Hip Thrust"],
                implement: .dumbbell,
                primaryMovement: .hinge,
                primaryMuscle: .glutes
            ),
            Factory.compound(
                name: "Dumbbell Romanian Deadlift",
                aka: ["DB Romanian Deadlift"],
                implement: .dumbbell,
                primaryMovement: .hinge,
                primaryMuscle: .hamstrings
            ),
            Factory.compound(
                name: "Dumbbell Stiff-Leg Deadlift",
                aka: ["DB Stiff Leg Deadlift"],
                implement: .dumbbell,
                primaryMovement: .hinge,
                primaryMuscle: .hamstrings
            ),
            Factory.compound(
                name: "Single-Leg Dumbbell Deadlift",
                aka: ["DB Single-Leg Deadlift"],
                implement: .dumbbell,
                primaryMovement: .hinge,
                primaryMuscle: .hamstrings,
                stance: .singleLeg,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Goblet Squat",
                aka: ["Dumbbell Goblet Squat"],
                implement: .dumbbell,
                primaryMovement: .squat,
                primaryMuscle: .quads
            ),
            Factory.compound(
                name: "Front Rack Dumbbell Split Squat",
                aka: ["DB Front Rack Split Squat"],
                implement: .dumbbell,
                primaryMovement: .lunge,
                primaryMuscle: .quads,
                stance: .splitStance,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Leaning Dumbbell Lunge",
                aka: ["DB Leaning Lunge"],
                implement: .dumbbell,
                primaryMovement: .lunge,
                primaryMuscle: .glutes,
                stance: .splitStance,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Walking Dumbbell Lunge",
                aka: ["DB Walking Lunge"],
                implement: .dumbbell,
                primaryMovement: .lunge,
                primaryMuscle: .quads,
                stance: .splitStance,
                lateral: .gaitPattern
            ),
            Factory.compound(
                name: "Reverse Dumbbell Lunge",
                aka: ["DB Reverse Lunge"],
                implement: .dumbbell,
                primaryMovement: .lunge,
                primaryMuscle: .glutes,
                stance: .splitStance,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Dumbbell Lateral Lunge",
                aka: ["DB Lateral Lunge"],
                implement: .dumbbell,
                primaryMovement: .lunge,
                primaryMuscle: .adductors
            ),
            Factory.isolation(
                name: "Dumbbell Calf Raise",
                aka: ["DB Calf Raise"],
                implement: .dumbbell,
                primaryMovement: .calfRaise,
                primaryMuscle: .calves
            )
        ]
    }

    // MARK: - Barbell

    enum Barbell {
        static var all: [ExerciseDefinition] {
            upperBody + lowerBody
        }

        private static let upperBody: [ExerciseDefinition] = [
            Factory.compound(
                name: "Barbell Bench Press",
                aka: ["Flat Barbell Bench Press", "Barbell Chest Press"],
                implement: .barbell,
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            Factory.compound(
                name: "Barbell Incline Bench Press",
                aka: ["Incline Barbell Bench Press"],
                implement: .barbell,
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            Factory.compound(
                name: "Barbell Decline Bench Press",
                aka: ["Decline Barbell Bench Press"],
                implement: .barbell,
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            Factory.compound(
                name: "Close-Grip Barbell Bench Press",
                aka: ["Barbell Close-Grip Bench Press"],
                implement: .barbell,
                primaryMovement: .push,
                primaryMuscle: .triceps
            ),
            Factory.compound(
                name: "Barbell Floor Press",
                aka: ["BB Floor Press"],
                implement: .barbell,
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            Factory.compound(
                name: "Barbell Shoulder Press",
                aka: ["Standing Barbell Press", "Overhead Press"],
                implement: .barbell,
                primaryMovement: .push,
                primaryMuscle: .deltsAnterior
            ),
            Factory.compound(
                name: "Barbell Upright Row",
                aka: ["BB Upright Row"],
                implement: .barbell,
                primaryMovement: .pull,
                primaryMuscle: .deltsLateral
            ),
            Factory.compound(
                name: "Barbell Military Press",
                aka: ["BB Military Press"],
                implement: .barbell,
                primaryMovement: .push,
                primaryMuscle: .deltsAnterior
            ),
            Factory.isolation(
                name: "Barbell Face Pull",
                aka: ["BB Face Pull"],
                implement: .barbell,
                primaryMovement: .horizontalAbduction,
                primaryMuscle: .deltsPosterior
            ),
            Factory.isolation(
                name: "Barbell Shrug",
                aka: ["BB Shrug"],
                implement: .barbell,
                primaryMovement: .elevation,
                primaryMuscle: .trapsUpper
            ),
            Factory.isolation(
                name: "Snatch-Grip Barbell Shrug",
                aka: ["Barbell Snatch Grip Shrug"],
                implement: .barbell,
                primaryMovement: .elevation,
                primaryMuscle: .trapsUpper
            ),
            Factory.compound(
                name: "Snatch-Grip Deadlift",
                aka: ["Barbell Snatch Grip Deadlift"],
                implement: .barbell,
                primaryMovement: .hinge,
                primaryMuscle: .hamstrings
            ),
            Factory.compound(
                name: "Barbell Row",
                aka: ["Bent-Over Barbell Row"],
                implement: .barbell,
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            Factory.compound(
                name: "Pendlay Row",
                aka: ["Barbell Pendlay Row"],
                implement: .barbell,
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            Factory.compound(
                name: "Underhand Barbell Row",
                aka: ["Barbell Underhand Row"],
                implement: .barbell,
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            Factory.compound(
                name: "Full ROM Barbell Row",
                aka: ["Barbell Full ROM Row"],
                implement: .barbell,
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            Factory.isolation(
                name: "Barbell Curl",
                aka: ["BB Curl"],
                implement: .barbell,
                primaryMovement: .elbowFlexion,
                primaryMuscle: .biceps
            ),
            Factory.isolation(
                name: "Reverse-Grip Barbell Curl",
                aka: ["Barbell Reverse Biceps Curl"],
                implement: .barbell,
                primaryMovement: .elbowFlexion,
                primaryMuscle: .brachioradialis
            ),
            Factory.isolation(
                name: "Barbell Skull Crusher",
                aka: ["Lying Barbell Triceps Extension"],
                implement: .barbell,
                primaryMovement: .elbowExtension,
                primaryMuscle: .triceps
            ),
            Factory.isolation(
                name: "Barbell JM Press",
                aka: ["JM Press"],
                implement: .barbell,
                primaryMovement: .elbowExtension,
                primaryMuscle: .triceps
            ),
            Factory.isolation(
                name: "Overhead Barbell Triceps Extension",
                aka: ["Barbell Overhead Triceps Extension"],
                implement: .barbell,
                primaryMovement: .elbowExtension,
                primaryMuscle: .triceps
            ),
            Factory.compound(
                name: "Landmine Single-Arm Row",
                aka: ["Barbell Landmine Single-Arm Row"],
                implement: .barbell,
                primaryMovement: .pull,
                primaryMuscle: .lats,
                stance: .splitStance,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Barbell Rack Pull",
                aka: ["Rack Deadlift"],
                implement: .barbell,
                primaryMovement: .hinge,
                primaryMuscle: .hamstrings
            )
        ]

        private static let lowerBody: [ExerciseDefinition] = [
            Factory.compound(
                name: "Back Squat",
                aka: ["Barbell Back Squat"],
                implement: .barbell,
                primaryMovement: .squat,
                primaryMuscle: .quads
            ),
            Factory.compound(
                name: "Front Squat",
                aka: ["Barbell Front Squat"],
                implement: .barbell,
                primaryMovement: .squat,
                primaryMuscle: .quads
            ),
            Factory.compound(
                name: "Zercher Squat",
                aka: ["Barbell Zercher Squat"],
                implement: .barbell,
                primaryMovement: .squat,
                primaryMuscle: .quads
            ),
            Factory.compound(
                name: "Deadlift",
                aka: ["Conventional Deadlift", "Barbell Deadlift"],
                implement: .barbell,
                primaryMovement: .hinge,
                primaryMuscle: .hamstrings
            ),
            Factory.compound(
                name: "Deficit Deadlift",
                aka: ["Barbell Deficit Deadlift"],
                implement: .barbell,
                primaryMovement: .hinge,
                primaryMuscle: .hamstrings
            ),
            Factory.compound(
                name: "Romanian Deadlift",
                aka: ["Barbell Romanian Deadlift"],
                implement: .barbell,
                primaryMovement: .hinge,
                primaryMuscle: .hamstrings
            ),
            Factory.compound(
                name: "Stiff-Leg Deadlift",
                aka: ["Barbell Stiff Leg Deadlift"],
                implement: .barbell,
                primaryMovement: .hinge,
                primaryMuscle: .hamstrings
            ),
            Factory.compound(
                name: "Barbell Hip Thrust",
                aka: ["Hip Thrust (Barbell)"],
                implement: .barbell,
                primaryMovement: .hinge,
                primaryMuscle: .glutes
            ),
            Factory.compound(
                name: "Barbell Lunge",
                aka: ["BB Lunge"],
                implement: .barbell,
                primaryMovement: .lunge,
                primaryMuscle: .quads,
                stance: .splitStance,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Walking Barbell Lunge",
                aka: ["Barbell Walking Lunge"],
                implement: .barbell,
                primaryMovement: .lunge,
                primaryMuscle: .quads,
                stance: .splitStance,
                lateral: .gaitPattern
            ),
            Factory.compound(
                name: "Reverse Barbell Lunge",
                aka: ["Barbell Reverse Lunge"],
                implement: .barbell,
                primaryMovement: .lunge,
                primaryMuscle: .glutes,
                stance: .splitStance,
                lateral: .unilateral
            ),
            Factory.compound(
                name: "Barbell Split Squat",
                aka: ["BB Split Squat"],
                implement: .barbell,
                primaryMovement: .lunge,
                primaryMuscle: .quads,
                stance: .splitStance,
                lateral: .unilateral
            )
        ]
    }

    // MARK: - Smith Machine

    enum SmithMachine {
        static var all: [ExerciseDefinition] {
            upperBody + lowerBody
        }

        private static func smithCompound(
            name: String,
            aka: [String] = [],
            primaryMovement: MovementPattern,
            primaryMuscle: MuscleGroup
        ) -> ExerciseDefinition {
            Factory.compound(
                name: name,
                aka: aka,
                implement: .smithMachine,
                primaryMovement: primaryMovement,
                primaryMuscle: primaryMuscle
            )
        }

        private static func smithIsolation(
            name: String,
            aka: [String] = [],
            primaryMovement: MovementPattern,
            primaryMuscle: MuscleGroup
        ) -> ExerciseDefinition {
            Factory.isolation(
                name: name,
                aka: aka,
                implement: .smithMachine,
                primaryMovement: primaryMovement,
                primaryMuscle: primaryMuscle
            )
        }

        private static let upperBody: [ExerciseDefinition] = [
            smithCompound(
                name: "Smith Machine Bench Press",
                aka: ["Smith Bench Press"],
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            smithCompound(
                name: "Smith Machine Incline Bench Press",
                aka: ["Smith Incline Press"],
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            smithCompound(
                name: "Smith Machine Decline Bench Press",
                aka: ["Smith Decline Press"],
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            smithCompound(
                name: "Smith Machine Close-Grip Bench Press",
                aka: ["Smith Close Grip Bench Press"],
                primaryMovement: .push,
                primaryMuscle: .triceps
            ),
            smithCompound(
                name: "Smith Machine Floor Press",
                aka: ["Smith Floor Press"],
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            smithCompound(
                name: "Smith Machine Shoulder Press",
                aka: ["Smith Shoulder Press"],
                primaryMovement: .push,
                primaryMuscle: .deltsAnterior
            ),
            smithCompound(
                name: "Smith Machine Upright Row",
                aka: ["Smith Upright Row"],
                primaryMovement: .pull,
                primaryMuscle: .deltsLateral
            ),
            smithCompound(
                name: "Smith Machine Military Press",
                aka: ["Smith Military Press"],
                primaryMovement: .push,
                primaryMuscle: .deltsAnterior
            ),
            smithIsolation(
                name: "Smith Machine Face Pull",
                aka: ["Smith Face Pull"],
                primaryMovement: .horizontalAbduction,
                primaryMuscle: .deltsPosterior
            ),
            smithIsolation(
                name: "Smith Machine Shrug",
                aka: ["Smith Shrug"],
                primaryMovement: .elevation,
                primaryMuscle: .trapsUpper
            ),
            smithIsolation(
                name: "Smith Machine Snatch-Grip Shrug",
                aka: ["Smith Snatch Grip Shrug"],
                primaryMovement: .elevation,
                primaryMuscle: .trapsUpper
            ),
            smithCompound(
                name: "Smith Machine Snatch-Grip Deadlift",
                aka: ["Smith Snatch Grip Deadlift"],
                primaryMovement: .hinge,
                primaryMuscle: .hamstrings
            ),
            smithCompound(
                name: "Smith Machine Row",
                aka: ["Smith Row"],
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            smithCompound(
                name: "Smith Machine Pendlay Row",
                aka: ["Smith Pendlay Row"],
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            smithCompound(
                name: "Smith Machine Underhand Row",
                aka: ["Smith Underhand Row"],
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            smithCompound(
                name: "Smith Machine Full ROM Row",
                aka: ["Smith Full ROM Row"],
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            smithIsolation(
                name: "Smith Machine Curl",
                aka: ["Smith Curl"],
                primaryMovement: .elbowFlexion,
                primaryMuscle: .biceps
            ),
            smithIsolation(
                name: "Smith Machine Reverse Curl",
                aka: ["Smith Reverse Biceps Curl"],
                primaryMovement: .elbowFlexion,
                primaryMuscle: .brachioradialis
            ),
            smithIsolation(
                name: "Smith Machine Skull Crusher",
                aka: ["Smith Skull Crusher"],
                primaryMovement: .elbowExtension,
                primaryMuscle: .triceps
            ),
            smithIsolation(
                name: "Smith Machine JM Press",
                aka: ["Smith JM Press"],
                primaryMovement: .elbowExtension,
                primaryMuscle: .triceps
            ),
            smithIsolation(
                name: "Smith Machine Overhead Triceps Extension",
                aka: ["Smith Overhead Triceps Extension"],
                primaryMovement: .elbowExtension,
                primaryMuscle: .triceps
            ),
            smithCompound(
                name: "Smith Machine Landmine Single-Arm Row",
                aka: ["Smith Landmine Single-Arm Row"],
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            smithCompound(
                name: "Smith Machine Rack Pull",
                aka: ["Smith Rack Pull"],
                primaryMovement: .hinge,
                primaryMuscle: .hamstrings
            )
        ]

        private static let lowerBody: [ExerciseDefinition] = [
            smithCompound(
                name: "Smith Machine Back Squat",
                aka: ["Smith Back Squat"],
                primaryMovement: .squat,
                primaryMuscle: .quads
            ),
            smithCompound(
                name: "Smith Machine Front Squat",
                aka: ["Smith Front Squat"],
                primaryMovement: .squat,
                primaryMuscle: .quads
            ),
            smithCompound(
                name: "Smith Machine Zercher Squat",
                aka: ["Smith Zercher Squat"],
                primaryMovement: .squat,
                primaryMuscle: .quads
            ),
            smithCompound(
                name: "Smith Machine Deadlift",
                aka: ["Smith Deadlift"],
                primaryMovement: .hinge,
                primaryMuscle: .hamstrings
            ),
            smithCompound(
                name: "Smith Machine Deficit Deadlift",
                aka: ["Smith Deficit Deadlift"],
                primaryMovement: .hinge,
                primaryMuscle: .hamstrings
            ),
            smithCompound(
                name: "Smith Machine Romanian Deadlift",
                aka: ["Smith Romanian Deadlift"],
                primaryMovement: .hinge,
                primaryMuscle: .hamstrings
            ),
            smithCompound(
                name: "Smith Machine Stiff-Leg Deadlift",
                aka: ["Smith Stiff Leg Deadlift"],
                primaryMovement: .hinge,
                primaryMuscle: .hamstrings
            ),
            smithCompound(
                name: "Smith Machine Hip Thrust",
                aka: ["Smith Hip Thrust"],
                primaryMovement: .hinge,
                primaryMuscle: .glutes
            ),
            smithCompound(
                name: "Smith Machine Lunge",
                aka: ["Smith Lunge"],
                primaryMovement: .lunge,
                primaryMuscle: .quads
            ),
            smithCompound(
                name: "Smith Machine Front-Foot Elevated Lunge",
                aka: ["Smith Front-Foot Elevated Lunge"],
                primaryMovement: .lunge,
                primaryMuscle: .quads
            ),
            smithCompound(
                name: "Smith Machine Reverse Lunge",
                aka: ["Smith Reverse Lunge"],
                primaryMovement: .lunge,
                primaryMuscle: .glutes
            ),
            smithCompound(
                name: "Smith Machine Split Squat",
                aka: ["Smith Split Squat"],
                primaryMovement: .lunge,
                primaryMuscle: .quads
            )
        ]
    }

    // MARK: - Machines (selectorized)

    enum Machines {
        static var all: [ExerciseDefinition] {
            chestShoulders + back + legs
        }

        private static func machineCompound(
            name: String,
            aka: [String] = [],
            primaryMovement: MovementPattern,
            primaryMuscle: MuscleGroup
        ) -> ExerciseDefinition {
            Factory.compound(
                name: name,
                aka: aka,
                implement: .machine,
                primaryMovement: primaryMovement,
                primaryMuscle: primaryMuscle
            )
        }

        private static func machineIsolation(
            name: String,
            aka: [String] = [],
            primaryMovement: MovementPattern,
            primaryMuscle: MuscleGroup
        ) -> ExerciseDefinition {
            Factory.isolation(
                name: name,
                aka: aka,
                implement: .machine,
                primaryMovement: primaryMovement,
                primaryMuscle: primaryMuscle
            )
        }

        private static let chestShoulders: [ExerciseDefinition] = [
            machineCompound(
                name: "Chest Press Machine",
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            machineCompound(
                name: "Incline Chest Press Machine",
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            machineIsolation(
                name: "Pec Deck Machine",
                aka: ["Chest Fly Machine"],
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            machineCompound(
                name: "Shoulder Press Machine",
                primaryMovement: .push,
                primaryMuscle: .deltsAnterior
            )
        ]

        private static let back: [ExerciseDefinition] = [
            machineCompound(
                name: "Lat Pulldown Machine",
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            machineCompound(
                name: "Seated Row Machine",
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            machineIsolation(
                name: "Rear Delt Fly Machine",
                aka: ["Reverse Fly Machine"],
                primaryMovement: .horizontalAbduction,
                primaryMuscle: .deltsPosterior
            )
        ]

        private static let legs: [ExerciseDefinition] = [
            machineCompound(
                name: "Leg Press",
                aka: ["Leg Press Machine", "45° Leg Press"],
                primaryMovement: .squat,
                primaryMuscle: .quads
            ),
            machineIsolation(
                name: "Leg Extension Machine",
                aka: ["Leg Extension"],
                primaryMovement: .kneeExtension,
                primaryMuscle: .quads
            ),
            machineIsolation(
                name: "Seated Leg Curl Machine",
                primaryMovement: .kneeFlexion,
                primaryMuscle: .hamstrings
            ),
            machineIsolation(
                name: "Lying Leg Curl Machine",
                aka: ["Hamstring Curl (Lying)"],
                primaryMovement: .kneeFlexion,
                primaryMuscle: .hamstrings
            ),
            machineIsolation(
                name: "Calf Raise Machine",
                primaryMovement: .calfRaise,
                primaryMuscle: .calves
            )
        ]
    }

    // MARK: - Cables

    enum Cables {
        static var all: [ExerciseDefinition] {
            upperBody + lowerBody
        }

        private static func cableIsolation(
            name: String,
            aka: [String] = [],
            primaryMovement: MovementPattern,
            primaryMuscle: MuscleGroup
        ) -> ExerciseDefinition {
            Factory.isolation(
                name: name,
                aka: aka,
                implement: .cable,
                primaryMovement: primaryMovement,
                primaryMuscle: primaryMuscle
            )
        }

        private static func cableCompound(
            name: String,
            aka: [String] = [],
            primaryMovement: MovementPattern,
            primaryMuscle: MuscleGroup
        ) -> ExerciseDefinition {
            Factory.compound(
                name: name,
                aka: aka,
                implement: .cable,
                primaryMovement: primaryMovement,
                primaryMuscle: primaryMuscle
            )
        }

        private static let upperBody: [ExerciseDefinition] = [
            cableIsolation(
                name: "Cable Chest Fly",
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            cableCompound(
                name: "Cable Chest Press",
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            cableCompound(
                name: "Seated Cable Chest Press",
                aka: ["Cable Seated Chest Press"],
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            cableIsolation(
                name: "Cable Crossover",
                primaryMovement: .push,
                primaryMuscle: .pectorals
            ),
            cableCompound(
                name: "Cable Row",
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            cableCompound(
                name: "Cable Full ROM Row",
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            cableCompound(
                name: "Cable Lat Pulldown",
                aka: ["Cable Pulldown"],
                primaryMovement: .pull,
                primaryMuscle: .lats
            ),
            cableIsolation(
                name: "Cable Face Pull",
                primaryMovement: .horizontalAbduction,
                primaryMuscle: .deltsPosterior
            ),
            cableIsolation(
                name: "Cable Lateral Raise",
                primaryMovement: .abduction,
                primaryMuscle: .deltsLateral
            ),
            cableCompound(
                name: "Cable Upright Row",
                aka: ["Cable Upright Tow"],
                primaryMovement: .pull,
                primaryMuscle: .deltsLateral
            ),
            cableIsolation(
                name: "Cable Biceps Curl",
                primaryMovement: .elbowFlexion,
                primaryMuscle: .biceps
            ),
            cableIsolation(
                name: "Cable Rope Curl",
                primaryMovement: .elbowFlexion,
                primaryMuscle: .biceps
            ),
            cableIsolation(
                name: "Cable Triceps Rope Pushdown",
                primaryMovement: .elbowExtension,
                primaryMuscle: .triceps
            ),
            cableIsolation(
                name: "Overhead Cable Triceps Extension",
                aka: ["Cable Overhead Triceps Extension"],
                primaryMovement: .elbowExtension,
                primaryMuscle: .triceps
            ),
            cableIsolation(
                name: "Cable Triceps Kickback",
                aka: ["Cable Kickback"],
                primaryMovement: .elbowExtension,
                primaryMuscle: .triceps
            )
        ]

        private static let lowerBody: [ExerciseDefinition] = [
            cableIsolation(
                name: "Cable Glute Kickback",
                aka: ["Cable Kickback (Glutes)"],
                primaryMovement: .hipExtension,
                primaryMuscle: .glutes
            ),
            cableIsolation(
                name: "Cable Hip Abduction",
                primaryMovement: .hipAbduction,
                primaryMuscle: .gluteMedius
            ),
            cableIsolation(
                name: "Cable Hip Adduction",
                primaryMovement: .hipAdduction,
                primaryMuscle: .adductors
            )
        ]
    }

    // MARK: - Bands

    enum Bands {
        static var all: [ExerciseDefinition] {
            exercises
        }

        private static let exercises: [ExerciseDefinition] = [
            Factory.isolation(
                name: "Band Pull-Apart",
                aka: ["Resistance Band Pull-Apart"],
                implement: .band,
                primaryMovement: .horizontalAbduction,
                primaryMuscle: .deltsPosterior
            ),
            Factory.isolation(
                name: "Band Face Pull",
                implement: .band,
                primaryMovement: .horizontalAbduction,
                primaryMuscle: .deltsPosterior
            ),
            Factory.compound(
                name: "Band Squat",
                implement: .band,
                primaryMovement: .squat,
                primaryMuscle: .quads
            ),
            Factory.compound(
                name: "Band Hip Thrust",
                implement: .band,
                primaryMovement: .hinge,
                primaryMuscle: .glutes
            ),
            Factory.isolation(
                name: "Band Kickback",
                aka: ["Band Glute Kickback"],
                implement: .band,
                primaryMovement: .hipExtension,
                primaryMuscle: .glutes
            )
        ]
    }

    // MARK: - Cardio Machines

    enum CardioMachines {
        static var all: [ExerciseDefinition] {
            [
                Factory.cardioMachine(
                    name: "Treadmill Run",
                    aka: ["Run (Treadmill)"],
                    implement: .treadmill
                ),
                Factory.cardioMachine(
                    name: "Treadmill Walk",
                    aka: ["Walk (Treadmill)"],
                    implement: .treadmill
                ),
                Factory.cardioMachine(
                    name: "Stair Climber",
                    aka: ["StairMaster"],
                    implement: .stairClimber
                ),
                Factory.cardioMachine(
                    name: "Rowing Machine",
                    aka: ["Rower", "Concept2 Row"],
                    implement: .rower
                ),
                Factory.cardioMachine(
                    name: "Elliptical",
                    aka: ["Elliptical Trainer"],
                    implement: .elliptical
                ),
                Factory.cardioMachine(
                    name: "Air Bike",
                    aka: ["Assault Bike", "AirBike"],
                    implement: .airBike
                ),
                Factory.cardioMachine(
                    name: "Stationary Bike",
                    aka: ["Spin Bike", "Exercise Bike"],
                    implement: .stationaryBike
                )
            ]
        }
    }
}
