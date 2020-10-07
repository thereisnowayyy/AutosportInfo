//
//  CircuitsTableViewController.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 21.09.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//

import UIKit

class CircuitsTableViewController: UITableViewController {
    let circuitNetworkService = CircuitsNetworkService()
    @IBOutlet weak var table: UITableView!
    var circuitJsonData: CircuitStart? 
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://ergast.com/api/f1/2020/Circuits/.json"
            circuitNetworkService.request(urlString: urlString) { (result) in
                switch result {
                case .success(let circuits):
                    self.circuitJsonData = circuits
                    self.table.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }

    
    
    
    
    @IBAction func refreshControl(_ sender: UIRefreshControl) {
        refreshControl?.beginRefreshing()
    }
    
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl!.isRefreshing {
            let urlString = "https://ergast.com/api/f1/2020/Circuits/.json"
            circuitNetworkService.request(urlString: urlString) { [self] (result) in
                    switch result {
                    case .success(let circuits):
                        refreshControl?.endRefreshing()
                        UIView.transition(with: self.table,
                                          duration: 0.8,
                                          options: [.curveEaseInOut],
                                          animations: {
                                            self.circuitJsonData = circuits
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
        
    
    
    
    
    
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circuitJsonData?.mrData.circuitTable.circuits.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellText = circuitJsonData?.mrData.circuitTable.circuits[indexPath.row].circuitName
        cell.textLabel?.text = cellText
        tableView.tableFooterView = UIView()
        let imageBahrain = UIImage(named: "bahrain")
        let imageSpain = UIImage(named: "spain")
        let imageHungary = UIImage(named: "hungary")
        let imageItaly = UIImage(named: "italy")
        let imageTurkey = UIImage(named: "turkey")
        let imageGermany = UIImage(named: "germany")
        let imagePortugal = UIImage(named: "portugal")
        let imageAustria = UIImage(named: "austria")
        let imageUK = UIImage(named: "uk")
        let imageRus = UIImage(named: "rus")
        let imageBelgium = UIImage(named: "belgium")
        let imageUAE = UIImage(named: "uae")
        let nat = circuitJsonData?.mrData.circuitTable.circuits[indexPath.row].location.country ?? ""
        switch nat {
        case "Bahrain":
            cell.imageView?.image = imageBahrain
        case "Spain":
            cell.imageView?.image = imageSpain
        case "Hungary":
            cell.imageView?.image = imageHungary
        case "Italy":
            cell.imageView?.image = imageItaly
        case "Turkey":
            cell.imageView?.image = imageTurkey
        case "Germany":
            cell.imageView?.image = imageGermany
        case "Portugal":
            cell.imageView?.image = imagePortugal
        case "Austria":
            cell.imageView?.image = imageAustria
        case "UK":
            cell.imageView?.image = imageUK
        case "Russia":
            cell.imageView?.image = imageRus
        case "Belgium":
            cell.imageView?.image = imageBelgium
        case "UAE":
            cell.imageView?.image = imageUAE
        default:
            break
        }
        return cell
    }
}
