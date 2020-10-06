//
//  LaunchScreenViewController.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 23.09.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//

import UIKit


class LaunchScreenViewController: UIViewController {
    
    let networkService = NetworkService()
    var jsonInfo: Welcome?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       let urlString = "https://ergast.com/api/f1/2020/DriverStandings.json"
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let teams):
                self.jsonInfo = teams
                print(self.jsonInfo)
            case .failure(let error):
                print(error)
}
}
}
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

