
// CircuitModel.swift
// AutosportInfo

// MARK: - Welcome

struct CircuitStart: Codable {
    
    let mrData: MRDataCircuit

    enum CodingKeys: String, CodingKey {
        
        case mrData = "MRData"
    }
}

// MARK: - MRData

struct MRDataCircuit: Codable {
    
    let xmlns: String
    let series: String
    
    let url: String
    let limit: String
    
    let offset: String
    let total: String
    
    let circuitTable: CircuitTable

    enum CodingKeys: String, CodingKey {
        
        case xmlns
        case series
        
        case url
        case limit
        
        case offset
        case total
        
        case circuitTable = "CircuitTable"
    }
}

// MARK: - CircuitTable

struct CircuitTable: Codable {
    
    let season: String
    let circuitId: String
    
    let circuits: [Circuit]

    enum CodingKeys: String, CodingKey {
        
        case season
        case circuitId
        
        case circuits = "Circuits"
    }
}

// MARK: - Circuit

struct Circuit: Codable {
    
    let circuitId: String
    let url: String
    
    let circuitName: String
    let location: Location

    enum CodingKeys: String, CodingKey {
        
        case circuitId
        case url
        
        case circuitName
        case location = "Location"
    }
}

// MARK: - Location

struct Location: Codable {
    
    let lat: String
    let long: String
    
    let locality: String
    let country: String

    enum CodingKeys: String, CodingKey {
        
        case lat
        case long
        
        case locality
        case country
    }
}
