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
    
 /*  @IBAction func backToTable(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    } */
    
    
    @IBOutlet weak var table: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = .none
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        refreshControl?.isHidden = true
        refreshControl?.endRefreshing()
    }
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            let urlString = "https://ergast.com/api/f1/2020/DriverStandings.json"
               networkService.request(urlString: urlString) { (result) in
                    switch result {
                    case .success(let drivers):
                        self.jsonInfo = drivers
                        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                            self.table.reloadData()
                        }, completion: nil)
                    case .failure(let error):
                        let alert = UIAlertController(title: "Network Error", message: "Вероятно, потеряно соединение с интернетом", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(action)
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailDriverInfo" {
            if let indexPath = self.table.indexPathForSelectedRow {
                let cell = self.table.cellForRow(at: indexPath)
                
            let tableViewCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: tableViewCell)!
        
                
                
                let dataTransfer = segue.destination as! DetailDriverInfoViewController
                dataTransfer.driverNationality = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.nationality
                
                dataTransfer.driverPermanentNumber = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.permanentNumber
                
                dataTransfer.driverName = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.givenName
                
                dataTransfer.driverLastName = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.familyName
                
                dataTransfer.teamOfDriver = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].constructors[Int()].name
                
                dataTransfer.driverCode = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.code
                
                guard let birthday = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.dateOfBirth else {return}
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                guard let dateDriver = dateFormatter.date(from: birthday) else {return}

                let ageString = String((Date() as Date).years(from: dateDriver))
                
                dataTransfer.driverBirth = ageString
                
                dataTransfer.driverPoints = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].points
                
                dataTransfer.driverWins = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].wins
                
                dataTransfer.driverUrlString = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.url
                
                dataTransfer.seasonStanding = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].position
                
            }
        }
}
}
