//
//  ResultsModel.swift
//  AutosportInfo



// MARK: - Results

struct ResultsStart: Codable {
    
    let mrData: ResultsMRData

    enum CodingKeys: String, CodingKey {
        
        case mrData = "MRData"
    }
}

// MARK: - MRData

struct ResultsMRData: Codable {
    
    let xmlns: String
    let series: String
    
    let url: String
    let limit: String
    
    let offset: String
    let total: String
    
    let raceTable: RaceTable

    enum CodingKeys: String, CodingKey {
        
        case xmlns
        case series
        
        case url
        case limit
        
        case offset
        case total
        
        case raceTable = "RaceTable"
    }
}

// MARK: - RaceTable

struct RaceTable: Codable {
    
    let season: String
    let races: [Race]

    enum CodingKeys: String, CodingKey {
        
        case season
        case races = "Races"
    }
}

// MARK: - Race

struct Race: Codable {
    
    let season: String
    let round: String
    
    let url: String
    let raceName: String
    
    let circuit: Circuit
    let date: String
    
    let time: String
    let results: [ResultsGP]

    enum CodingKeys: String, CodingKey {
        
        case season
        case round
        
        case url
        case raceName
        
        case circuit = "Circuit"
        case date
        
        case time
        case results = "Results"
    }
}


// MARK: - Result

struct ResultsGP: Codable {
    
    let number: String
    let position: String
    
    let positionText: String
    let points: String
    
    let driver: Driver
    let constructor: Constructor
    
    let grid: String
    let laps: String
    
    let status: String
    let time: ResultTime?
    
    let fastestLap: FastestLap?

    enum CodingKeys: String, CodingKey {
        
        case number
        case position
        
        case positionText
        case points
        
        case driver = "Driver"
        case constructor = "Constructor"
        
        case grid
        case laps
        
        case status
        case time = "Time"
        
        case fastestLap = "FastestLap"
    }
}

// MARK: - FastestLap

struct FastestLap: Codable {
    
    let rank: String
    let lap: String
    
    let time: FastestLapTime
    let averageSpeed: AverageSpeed

    enum CodingKeys: String, CodingKey {
        
        case rank
        case lap
        
        case time = "Time"
        case averageSpeed = "AverageSpeed"
    }
}

// MARK: - AverageSpeed

struct AverageSpeed: Codable {
    
    let units: Units
    let speed: String

    enum CodingKeys: String, CodingKey {
        
        case units
        case speed
    }
}

enum Units: String, Codable {
    
    case kph = "kph"
}

// MARK: - FastestLapTime

struct FastestLapTime: Codable {
    
    let time: String

    enum CodingKeys: String, CodingKey {
        
        case time
    }
}

// MARK: - ResultTime

struct ResultTime: Codable {
    
    let millis: String
    let time: String

    enum CodingKeys: String, CodingKey {
        
        case millis
        case time
    }
}
