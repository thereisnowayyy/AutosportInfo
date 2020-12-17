//
//  NetworkHelper.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 22.10.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//

import Moya

final class NetworkHelper {
    
    static let instance = NetworkHelper()
    
    private let serverProvider: MoyaProvider<Server.Method> = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 25
        
        let session = Session(configuration: configuration)
        return MoyaProvider<Server.Method>(session: session)
    } ()
    
    // MARK: - Life Cycle
    
    private init() {}

    // MARK: - Available Requests
    
    func getDriverStandings() -> NetworkPromise<DriversInfo> {
        let method = Server.Method.getDriverStandings
        return NetworkPromise(method)
    }
    
    func getConstructorStandings() -> NetworkPromise<Teams> {
        let method = Server.Method.getTeamStandings
        return NetworkPromise(method)
    }
    
    func getCircuitInfo() -> NetworkPromise<CircuitStart> {
        let method = Server.Method.getCircuitsInfo
        return NetworkPromise(method)
    }
    
    func getRacesResults() -> NetworkPromise<ResultsStart> {
        let method = Server.Method.getTeamStandings
        return NetworkPromise(method)
    }
    
    // MARK: - Public Functions
    
    func request<T: Decodable>(_ method: Server.Method, with promise: NetworkPromise<T>) -> Cancellable {
        return serverProvider.request(method) { response in
            let responseHandler = Server.ResponseHandler(response)
            responseHandler.handle(method, with: promise)
        }
    }
}
