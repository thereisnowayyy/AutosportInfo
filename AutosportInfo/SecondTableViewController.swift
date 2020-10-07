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
        self.navigationController?.navigationBar.barTintColor = .none
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.separatorStyle = .none
        let urlString = "https://ergast.com/api/f1/2020/ConstructorStandings.json"
            teamNetworkService.request(urlString: urlString) { (result) in
                switch result {
                case .success(let teams):
                    self.teamJsonInfo = teams
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                        self.table.reloadData()
                    }, completion: nil)
                case .failure(let error):
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Network Error", message: "Вероятно, потеряно соединение с интернетом", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                        print(error)
                }
        }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        refreshControl?.isHidden = true
        refreshControl?.endRefreshing()
    }
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl!.isRefreshing {
            let urlString = "https://ergast.com/api/f1/2020/ConstructorStandings.json"
            teamNetworkService.request(urlString: urlString) { [self] (result) in
                    switch result {
                    case .success(let teams):
                        refreshControl?.endRefreshing()
                        UIView.transition(with: self.table,
                                          duration: 0.8,
                                          options: [.curveEaseInOut],
                                          animations: {
                                            self.teamJsonInfo = teams
                                            self.table.reloadData()
                        }, completion: nil)
                    case .failure(let error):
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Network Error", message: "Вероятно, потеряно соединение с интернетом", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default, handler: .none)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        refreshControl?.endRefreshing()
                        print(error)
        }
            }
            }
        }
    }
    
    @IBAction func refreshControl(_ sender: UIRefreshControl) {
        refreshControl?.beginRefreshing()
    }
    
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
             cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
             
         
     UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations:
             {
                 cell.transform = CGAffineTransform.identity
                 
             },
                 completion: nil)
     }
    
    
    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teamJsonInfo?.mrDataTeams.standingsTable.standingsLists[Int()].constructorStandings.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TeamsTableViewCell
        let teams = self.teamJsonInfo?.mrDataTeams.standingsTable.standingsLists[Int()].constructorStandings[indexPath.row]
        let text2 = "\(teams!.constructor.name)"
        cell.cellView.layer.cornerRadius = 15
        cell.teamName.text = text2
        cell.teamNationalityLabel.text = teams?.constructor.nationality
        cell.countWins.text = teams?.wins
        cell.countPosition.text = teams?.position
        cell.countPoints.text = teams?.points
    tableView.tableFooterView = UIView()
    return cell
        }
}
