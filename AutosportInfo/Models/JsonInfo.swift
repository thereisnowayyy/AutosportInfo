//
//  JsonInfo.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 11.09.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let mrData: MRData

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - MRData
struct MRData: Codable {
    let xmlns: String
    let series: String
    let url: String
    let limit: String
    let offset: String
    let total: String
    let standingsTable: StandingsTable

    enum CodingKeys: String, CodingKey {
        case xmlns
        case series
        case url
        case limit
        case offset
        case total
        case standingsTable = "StandingsTable"
    }
}

// MARK: - StandingsTable
struct StandingsTable: Codable {
    let season: String
    let standingsLists: [StandingsList]

    enum CodingKeys: String, CodingKey {
        case season
        case standingsLists = "StandingsLists"
    }
}

// MARK: - StandingsList
struct StandingsList: Codable {
    let season: String
    let round: String
    let driverStandings: [DriverStanding]

    enum CodingKeys: String, CodingKey {
        case season
        case round
        case driverStandings = "DriverStandings"
    }
}

// MARK: - DriverStanding
struct DriverStanding: Codable {
    let position: String
    let positionText: String
    let points: String
    let wins: String
    let driver: Driver
    let constructors: [Constructor]

    enum CodingKeys: String, CodingKey {
        case position
        case positionText
        case points
        case wins
        case driver = "Driver"
        case constructors = "Constructors"
    }
}

// MARK: - Constructor
 struct Constructor: Codable {
    let constructorId: String
    let url: String
    let name: String
    let nationality: String

    enum CodingKeys: String, CodingKey {
        case constructorId
        case url
        case name
        case nationality
    }
} 

// MARK: - Driver
struct Driver: Codable {
    let driverId: String
    let permanentNumber: String
    let code: String
    let url: String
    let givenName: String
    let familyName: String
    let dateOfBirth: String
    let nationality: String

    enum CodingKeys: String, CodingKey {
        case driverId
        case permanentNumber
        case code
        case url
        case givenName
        case familyName
        case dateOfBirth
        case nationality
    }
}
