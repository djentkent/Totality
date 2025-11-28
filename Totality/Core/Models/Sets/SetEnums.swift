//
//  SetEnums.swift
//  Totality
//
//  Created by Kent Wilson on 11/28/25.
//

// MARK: - Set enums

enum SetCategory: String, Codable {
    case resistance
    case cardio
    case special
}

enum SetStimulus: String, Codable {
    case standard
    case metabolite
    case strength
    case power
    case endurance
}

// High level types used across the app
enum SetType: String, Codable {
    case straight
    case warmup
    case backoff
    case failure
    case drop
    case myo
    case forced
    case partialLong
    case partialShort
    case cardioRound
}

// For explicit failure info if needed later
enum SetFailureType: String, Codable {
    case none
    case technical
    case muscular
    case cardiovascular
}

// Rest classification between sets
enum RestType: String, Codable {
    case passive
    case active
}
