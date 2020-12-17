//
//  TeamsModel.swift
//  AutosportInfo
//


// MARK: - Teams

struct Teams: Codable {
    
    let mrDataTeams: TeamMRData

    enum CodingKeys: String, CodingKey {
        case mrDataTeams = "MRData"
    }
}

// MARK: - MRData

struct TeamMRData: Codable {
    
    let xmlns: String
    let series: String
    let url: String
    let limit: String
    let offset: String
    let total: String
    let standingsTable: TeamStandingsTable

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

struct TeamStandingsTable: Codable {
    
    let season: String
    let standingsLists: [TeamStandingsList]

    enum CodingKeys: String, CodingKey {
        
        case season
        case standingsLists = "StandingsLists"
    }
}

// MARK: - StandingsList

struct TeamStandingsList: Codable {
    
    let season: String
    let round: String
    let constructorStandings: [ConstructorStanding]

    enum CodingKeys: String, CodingKey {
        
        case season
        case round
        case constructorStandings = "ConstructorStandings"
    }
}

// MARK: - ConstructorStanding

struct ConstructorStanding: Codable {
    
    let position: String
    let positionText: String
    let points: String
    let wins: String
    let constructor: ConstructorTeams

    enum CodingKeys: String, CodingKey {
        
        case position
        case positionText
        case points
        case wins
        case constructor = "Constructor"
    }
}

// MARK: - Constructor

struct ConstructorTeams: Codable {
    
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
