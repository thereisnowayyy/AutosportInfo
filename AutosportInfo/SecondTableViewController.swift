//
//  SecondTableViewController.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 16.09.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//

import UIKit

class SecondTableViewController: UITableViewController {
    
    let teamNetworkService = TeamNetworkService()
    var teamJsonInfo: Teams?
    
    @IBOutlet weak var table: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.separatorStyle = .none
        let urlString = "https://ergast.com/api/f1/2020/constructorStandings.json"
            teamNetworkService.request(urlString: urlString) { (result) in
                switch result {
                case .success(let teams):
                    self.teamJsonInfo = teams
                    self.table.reloadData()
                case .failure(let error):
                    print(error)
                }
        }
        }
    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teamJsonInfo?.mrDataTeams.standingsTable.standingsLists[Int()].constructorStandings.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    override   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TeamsTableViewCell
        let teams = self.teamJsonInfo?.mrDataTeams.standingsTable.standingsLists[Int()].constructorStandings[indexPath.row]
        let text2 = "\(teams!.constructor.name)"
       /* viewForInfo.layer.cornerRadius = 15
        viewForInfo.layer.borderColor =
            UIColor.black.cgColor
        viewForInfo.layer.borderWidth = 3 */
        cell.cellView.layer.cornerRadius = 15
        cell.teamName.text = text2
    tableView.tableFooterView = UIView()
    return cell
        }
}
