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
    var jsonInfo: Welcome? 
    
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
        return jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings.count ?? 0
    }
        
   override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
        
    UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations:
            {
                cell.transform = CGAffineTransform.identity
                
            },
                completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> DriverTableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DriverTableViewCell 
        let driver = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row]
        let name = driver?.driver.givenName ?? ""
        let familyName = driver?.driver.familyName ?? ""
        let fullName = "\(name)" + " " + "\(familyName)"
        cell.driverFullName.text = fullName
        cell.driversPoints.text = driver?.points
        cell.driversTeam.text = driver?.constructors[Int()].name
                
        
        return cell
            }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        
        guard let detailDriverInfo = self.storyboard?.instantiateViewController(identifier: "DetailDriverInfoVC") as? DetailDriverInfoViewController else {return}
        
        
        detailDriverInfo.driverPoints = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].points
        
        detailDriverInfo.seasonStanding = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].position
        
        detailDriverInfo.driverCode = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.code
        
        guard let driversBirthday = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.dateOfBirth else {return}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let dateDriver = dateFormatter.date(from: driversBirthday) else {return}
        
        let ageString = String((Date() as Date).years(from: dateDriver))
        
        detailDriverInfo.driverBirth = ageString
        
        detailDriverInfo.driverWins = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].wins
        
        detailDriverInfo.driverLastName = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.familyName
        
        detailDriverInfo.driverName = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.givenName
        
        detailDriverInfo.driverNationality = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.nationality
        
        detailDriverInfo.teamOfDriver = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].constructors[Int()].name
        
        detailDriverInfo.driverPermanentNumber = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.permanentNumber
        
        detailDriverInfo.driverUrlString = jsonInfo?.mrData.standingsTable.standingsLists[Int()].driverStandings[indexPath.row].driver.url
        
        navigationController?.pushViewController(detailDriverInfo, animated: true)
}
}
