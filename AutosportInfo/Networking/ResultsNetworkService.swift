//
//  QualifyingNetworkService.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 22.09.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//

import Foundation

class ResultsGPNetworkService {
    func request(urlString: String, completion: @escaping (Result<ResultsStart?, Error>) -> Void) {
             guard let url = URL(string: urlString) else {return}
             URLSession.shared.dataTask(with: url) { (data, response, error) in
                let queue = DispatchQueue.global(qos: .userInteractive)
                queue.async {
                     if let error = error {
                         print("error")
                         completion(.failure(error))
                         return
                 }
                     guard let data = data else {return}
                     do {
                         let resultsInfo = try JSONDecoder().decode(ResultsStart.self, from: data)
                        DispatchQueue.main.async {

                         completion(.success(resultsInfo))
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
