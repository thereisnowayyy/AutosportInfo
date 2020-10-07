//
//  FirstTableViewController.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 16.09.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//

import UIKit
import DateToolsSwift

class FirstTableViewController: UITableViewController {
    let networkService = NetworkService()
    var jsonInfo: Welcome? = nil

    
    @IBOutlet weak var table: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = .none
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        refreshControl?.endRefreshing()
    }
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            let urlString = "https://ergast.com/api/f1/2020/DriverStandings.json"
               networkService.request(urlString: urlString) { (result) in
                    switch result {
                    case .success(let teams):
                        self.jsonInfo = teams
                        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                            self.table.reloadData()
                        }, completion: nil)
                    case .failure(let error):
                        let alert = UIAlertController(title: "Network Error", message: "Вероятно, потеряно соединение с интернетом", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        self.present(alert, animated: true, completion: nil)
                    }
            }
    }
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl!.isRefreshing {
            let urlString = "https://ergast.com/api/f1/2020/DriverStandings.json"
            networkService.request(urlString: urlString) { [self] (result) in
                    switch result {
                    case .success(let teams):
                        refreshControl?.endRefreshing()
                        UIView.transition(with: self.table,
                                          duration: 0.8,
                                          options: [.curveEaseInOut],
                                          animations: {
                                            self.jsonInfo = teams
                                            self.table.reloadData()
                        }, completion: nil)
                    case .failure(let error):
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Network Error", message: "Вероятно, потеряно соединение с интернетом", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
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
    
    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings.count ?? 0
    }
        
   override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
        
    UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations:
            {
                cell.transform = CGAffineTransform.identity
                
            },
                completion: nil)
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let driver = self.jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row]
        let text = "\(driver!.driver.givenName)" + " " + "\(driver!.driver.familyName)"
        cell.textLabel?.text = text
        
        
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.text = driver?.constructors[Int()].name
        return cell
            }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailDriverInfo" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let cell = self.tableView.cellForRow(at: indexPath)
                guard var driverName = cell?.textLabel?.text else {return}
                
                
            let tableViewCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: tableViewCell)!
                let sizeVC = segue.destination as! DetailDriverInfoViewController
                sizeVC.driverName = self.jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.permanentNumber
            let sys = segue.destination as! DetailDriverInfoViewController
                let nationality = segue.destination as! DetailDriverInfoViewController
                nationality.driverNationality = self.jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.nationality
                var driverPermNumber = segue.destination as! DetailDriverInfoViewController
                driverPermNumber.driverPermanentNumber = self.jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.permanentNumber
                
                var nameOfDriver = segue.destination as! DetailDriverInfoViewController
                nameOfDriver.driverName = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.givenName
                
                var lastNameOfDriver = segue.destination as! DetailDriverInfoViewController
                lastNameOfDriver.driverLastName = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.familyName
                
                var driverTeam = segue.destination as! DetailDriverInfoViewController
                driverTeam.teamOfDriver = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].constructors[Int()].name
                
                var codeOfDriver = segue.destination as! DetailDriverInfoViewController
                codeOfDriver.driverCode = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.code
   
                guard let birthday = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.dateOfBirth else {return}
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateDriver = dateFormatter.date(from: birthday)

                let ageString = String((Date() as Date).years(from: dateDriver!))

                var driverDateOfBirth = segue.destination as! DetailDriverInfoViewController
                driverDateOfBirth.driverBirth = ageString
                
                var pointsOfDriver = segue.destination as! DetailDriverInfoViewController
                pointsOfDriver.driverPoints = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].points
                
                var winsOfDriver = segue.destination as! DetailDriverInfoViewController
                winsOfDriver.driverWins = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].wins
                
                var driverUrlToWiki = segue.destination as! DetailDriverInfoViewController
                driverUrlToWiki.driverUrlString = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.url
                
                var positionStanding = segue.destination as! DetailDriverInfoViewController
                positionStanding.seasonStanding = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].position
                
            }
        }
}
}
