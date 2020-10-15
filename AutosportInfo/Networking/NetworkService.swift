//
//  NetworkService.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 15.09.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//

import Foundation

class NetworkService {
    func request(urlString: String, completion: @escaping (Result<Welcome?, Error>) -> Void) {
         guard let url = URL(string: urlString) else {return}
         let urlReq = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 5.0)
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
                        let driverInfo = try JSONDecoder().decode(Welcome.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(driverInfo))

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
