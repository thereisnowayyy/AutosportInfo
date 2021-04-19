//
//  Server.swift
//  AutosportInfo
//

import UIKit

final class Server {
    
    // MARK: - Life Cycle
    
    private init() { }
    
    // MARK: - Static Functions
    
    static func getBaseURL() -> URL {
        let season = 2021
        return URL(string: "https://ergast.com/api/f1/\(season)")!
    }
    
}
