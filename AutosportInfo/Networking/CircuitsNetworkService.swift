//
//  CircuitsNetworkService.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 21.09.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//

import Foundation

class CircuitsNetworkService {
    func request(urlString: String, completion: @escaping (Result<CircuitStart?, Error>) -> Void) {
        guard let url = URL(string: urlString) else {return}
        let urlReq = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 7.0)
        
         URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            let queue = DispatchQueue.global(qos: .userInteractive)
            queue.async {
                 if let error = error {
                    DispatchQueue.main.async {
                     completion(.failure(error))
                     return
             }
                 }
                 guard let data = data else {return}
                 do {
                    
                     let circuitInfo = try JSONDecoder().decode(CircuitStart.self, from: data)
                     DispatchQueue.main.async {
                     completion(.success(circuitInfo))
                 }
                 }
                 catch let jsonError {
                     print("Failed to decode JSON", jsonError)
                     completion(.failure(jsonError))
                 }
                 
                 
             }
         }.resume()
}
}
