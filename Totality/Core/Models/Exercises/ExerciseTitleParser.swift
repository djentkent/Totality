//
//  ExerciseTitleParser.swift
//  Totality
//
//  Created by Kent Wilson on 11/28/25.
//

import Foundation

/// Hints inferred from a free-form exercise title string.
/// Use these to pre-populate fields when creating a custom Exercise.
struct ParsedExerciseHints {
    var cleanedName: String
    
    var implement: ImplementType?
    var lateralType: LateralType?
    var angle: ExerciseAngle?
    var contractionBias: ContractionBias?
    var velocityType: VelocityType?
    var romClass: RangeOfMotionClass?
    var bodyPosition: BodyPosition?
}

/// Parses user-entered exercise titles like:
/// "Barbell Pause Incline Bench Press"
/// "Machine Single-leg Explosive Leg Extension"
/// "Bodyweight Alternating Jumping Lunge"
///
/// and tries to infer implement, angle, lateral, etc.
struct ExerciseTitleParser {
    
    static func parse(_ rawTitle: String) -> ParsedExerciseHints {
        let trimmed = rawTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return ParsedExerciseHints(cleanedName: "", implement: nil, lateralType: nil, angle: nil, contractionBias: nil, velocityType: nil, romClass: nil, bodyPosition: nil)
        }
        
        var implement: ImplementType?
        var lateral: LateralType?
        var angle: ExerciseAngle?
        var contraction: ContractionBias?
        var velocity: VelocityType?
        var romClass: RangeOfMotionClass?
        var bodyPosition: BodyPosition?
        
        // We'll track matched phrases/words so we can strip them out for the cleaned base name.
        var phrasesToStrip: [String] = []
        
        let lower = trimmed.lowercased()
        
        // MARK: - Implement
        
        let implementMap: [(ImplementType, [String])] = [
            (.barbell,   ["barbell", "bb"]),
            (.dumbbell,  ["dumbbell", "db"]),
            (.machine,   ["machine"]),
            (.bodyweight,["bodyweight", "bw"]),
            (.cable,     ["cable"]),
            (.band,      ["band", "banda", "resistance band"]),
            (.kettlebell,["kettlebell", "kb"]),
            (.smithMachine, ["smith", "smith machine"]),
            (.trapBar,   ["trap bar", "hex bar"])
        ]
        
        for (impl, keys) in implementMap where implement == nil {
            if keys.contains(where: { lower.contains($0) }) {
                implement = impl
                phrasesToStrip.append(contentsOf: keys)
            }
        }
        
        // MARK: - Lateral type
        
        if lower.contains("single leg") || lower.contains("single-leg") {
            lateral = .unilateral
            phrasesToStrip.append(contentsOf: ["single leg", "single-leg"])
        } else if lower.contains("single arm") || lower.contains("single-arm") {
            lateral = .unilateral
            phrasesToStrip.append(contentsOf: ["single arm", "single-arm"])
        } else if lower.contains("alternating") || lower.contains("alt ") {
            lateral = .bilateralAlternating
            phrasesToStrip.append("alternating")
            phrasesToStrip.append("alt")
        }
        
        // MARK: - Contraction bias
        
        if lower.contains("pause ") || lower.contains("paused") {
            contraction = .concentricBiased
            phrasesToStrip.append(contentsOf: ["pause", "paused"])
        } else if lower.contains("iso") || lower.contains("isometric") {
            contraction = .isometric
            phrasesToStrip.append(contentsOf: ["iso", "isometric"])
        } else if lower.contains("eccentric") || lower.contains("negative") {
            contraction = .eccentricEmphasized
            phrasesToStrip.append(contentsOf: ["eccentric", "negative"])
        }
        
        // MARK: - Velocity
        
        if lower.contains("explosive") {
            velocity = .explosive
            phrasesToStrip.append("explosive")
        } else if lower.contains("jumping") || lower.contains("jump ") || lower.hasSuffix(" jump") {
            velocity = .plyometric
            phrasesToStrip.append(contentsOf: ["jumping", "jump"])
        } else {
            // normal is the default; we generally don't show it in title
            velocity = nil
        }
        
        // MARK: - Angle
        
        if lower.contains("incline") {
            angle = .inclineMedium
            phrasesToStrip.append("incline")
        } else if lower.contains("decline") {
            angle = .declineMedium
            phrasesToStrip.append("decline")
        } else if lower.contains("upright") {
            angle = .upright
            phrasesToStrip.append("upright")
        } else if lower.contains("90") || lower.contains("90°") || lower.contains("pendlay") {
            angle = .bent90
            phrasesToStrip.append(contentsOf: ["90", "90°", "pendlay"])
        }
        
        // MARK: - ROM
        
        if lower.contains("full rom") || lower.contains("full range") {
            romClass = .full
            phrasesToStrip.append(contentsOf: ["full rom", "full range"])
        } else if lower.contains("partial") || lower.contains("partials") {
            romClass = .partial
            phrasesToStrip.append(contentsOf: ["partial", "partials"])
        } else if lower.contains("stretch") {
            romClass = .longMuscleLength
            phrasesToStrip.append("stretch")
        } else if lower.contains("top half") || lower.contains("lockout") {
            romClass = .shortMuscleLength
            phrasesToStrip.append(contentsOf: ["top half", "lockout"])
        }
        
        // MARK: - Body Position hints
        
        if lower.contains("seated") {
            bodyPosition = .seated
            phrasesToStrip.append("seated")
        } else if lower.contains("standing") {
            bodyPosition = .standing
            phrasesToStrip.append("standing")
        } else if lower.contains("lying") || lower.contains("laying") {
            // could be supine or prone; we default to supine for now
            bodyPosition = .supine
            phrasesToStrip.append(contentsOf: ["lying", "laying"])
        } else if lower.contains("prone") {
            bodyPosition = .prone
            phrasesToStrip.append("prone")
        } else if lower.contains("kneeling") {
            bodyPosition = .kneeling
            phrasesToStrip.append("kneeling")
        }
        
        // MARK: - Build cleaned name
        
        let cleaned = stripPhrases(raw: trimmed, phrases: phrasesToStrip)
        
        return ParsedExerciseHints(
            cleanedName: cleaned,
            implement: implement,
            lateralType: lateral,
            angle: angle,
            contractionBias: contraction,
            velocityType: velocity,
            romClass: romClass,
            bodyPosition: bodyPosition
        )
    }
    
    /// Removes known phrases and extra whitespace, returns a nicer base exercise name.
    private static func stripPhrases(raw: String, phrases: [String]) -> String {
        guard !phrases.isEmpty else {
            return raw.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        var result = raw
        
        for phrase in phrases {
            guard !phrase.isEmpty else { continue }
            result = replaceCaseInsensitive(in: result, target: phrase, with: "")
        }
        
        // Collapse multiple spaces
        while result.contains("  ") {
            result = result.replacingOccurrences(of: "  ", with: " ")
        }
        
        return result
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "  ", with: " ")
    }
    
    private static func replaceCaseInsensitive(in source: String, target: String, with replacement: String) -> String {
        let pattern = "\\b" + NSRegularExpression.escapedPattern(for: target) + "\\b"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive]) else {
            return source
        }
        let range = NSRange(source.startIndex..<source.endIndex, in: source)
        return regex.stringByReplacingMatches(in: source, options: [], range: range, withTemplate: replacement)
    }
}
