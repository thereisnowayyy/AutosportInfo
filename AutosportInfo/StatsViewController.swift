//
//  PreferencesViewController.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 21.09.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//

import UIKit

class StatsViewController: UITableViewController {
    let resultsNetworkService = ResultsGPNetworkService()
    var resultJsonData: ResultsStart? = nil
    
    @IBOutlet weak var resultsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://ergast.com/api/f1/2020/results.json?limit=1000"
            resultsNetworkService.request(urlString: urlString) { (result) in
                switch result {
                case .success(let ResultsOfRace):
                    self.resultJsonData = ResultsOfRace
                    self.resultsTable.reloadData()
                case .failure(let error):
                    print(error)
                }
        }
        }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultJsonData?.mrData.raceTable.races.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellText = resultJsonData?.mrData.raceTable.races[indexPath.row].raceName
        cell.textLabel?.text = cellText
        tableView.tableFooterView = UIView()
        return cell
    }
        
}
