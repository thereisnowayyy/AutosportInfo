//
//  Server.Method.swift
//  AutosportInfo
//

import Moya

extension Server {
    
    enum Method: TargetType {
        
        case getDriverStandings
        case getTeamStandings
        
        case getCircuitsInfo
        case getRacesResults
        
        // MARK: - Configurations
        
        var baseURL: URL {
            return Server.getBaseURL()
        }
        
        var path: String {
            var target: String
            
            switch self {
                case .getDriverStandings:
                   target = "DriverStandings.json"
                    
                case .getTeamStandings:
                   target = "ConstructorStandings.json"
                    
                case .getCircuitsInfo:
                    target = "Circuits/.json"
                    
                case .getRacesResults:   #warning ("need to fix")
                    target = "races.json"
            } 
            
            return "/\(target)"
            
        }
        
        var task: Task {
            
            return Task.requestPlain
        }
        
        var method: Moya.Method {
            switch self {
                case .getDriverStandings:
                    return .get
                    
                case .getTeamStandings:
                    return .get
                    
                case .getCircuitsInfo:
                    return .get
                    
                case .getRacesResults:
                    return .get
            }
        }
    
        var headers: [String : String]? {.none}
    
        var sampleData: Data {
            return Data()
        }
    }
}
