//
//  TeamsNetworkService.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 16.09.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//

import Foundation


class TeamNetworkService {
    func request(urlString: String, completion: @escaping (Result<Teams?, Error>) -> Void) {
        guard let url = URL(string: urlString) else {return}
        let urlReq = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 5.0)
         URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
             let queue = DispatchQueue.global(qos: .utility)
                     queue.async {
                          if let error = error {
                              print("error")
                              completion(.failure(error))
                              return
                      }
                          guard let data = data else {return}
                          do {
                              let driverInfo = try JSONDecoder().decode(Teams.self, from: data)
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
