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
    var circuitJsonData: CircuitStart?
    
    
    @IBOutlet weak var table: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.separatorStyle = .none
        let urlString = "https://ergast.com/api/f1/2020/Circuits/.json"
            circuitNetworkService.request(urlString: urlString) { (result) in
                switch result {
                case .success(let circuits):
                    self.circuitJsonData = circuits
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                        self.table.reloadData()
                    }, completion: nil)
                case .failure(let error):
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Network Error", message: "Вероятно, потеряно соединение с интернетом", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        refreshControl?.isHidden = true
        refreshControl?.endRefreshing()
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
                                          duration: 0.6,
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
                            present(alert, animated: true, completion: nil)
                        refreshControl?.endRefreshing()
                        print(error)
                        }
                    }
            }
        }
    }
        
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
             cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
             
         
     UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations:
             {
                 cell.transform = CGAffineTransform.identity
                 
             },
                 completion: nil)
     }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        
        guard let detailCircuitInfo = self.storyboard?.instantiateViewController(identifier: "DetailCircVC") as? DetailCircuitViewController else {return}
        
        detailCircuitInfo.circuitId = circuitJsonData?.mrData.circuitTable.circuits[indexPath.row].circuitId
        detailCircuitInfo.circuitName = circuitJsonData?.mrData.circuitTable.circuits[indexPath.row].circuitName
        navigationController?.pushViewController(detailCircuitInfo, animated: true)
    }
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circuitJsonData?.mrData.circuitTable.circuits.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CircuitTableViewCell
        let circuitName = circuitJsonData?.mrData.circuitTable.circuits[indexPath.row].circuitName
        
        cell.cellView.layer.cornerRadius = 15
        
        
        cell.circuitNameLabel.text = circuitName
        
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
        let country = circuitJsonData?.mrData.circuitTable.circuits[indexPath.row].location.country ?? ""
        switch country {
        case "Bahrain":
            cell.circuitCountryImage.image = imageBahrain
        case "Spain":
            cell.circuitCountryImage.image = imageSpain
        case "Hungary":
            cell.circuitCountryImage.image = imageHungary
        case "Italy":
            cell.circuitCountryImage.image = imageItaly
        case "Turkey":
            cell.circuitCountryImage.image = imageTurkey
        case "Germany":
            cell.circuitCountryImage.image = imageGermany
        case "Portugal":
            cell.circuitCountryImage.image = imagePortugal
        case "Austria":
            cell.circuitCountryImage.image = imageAustria
        case "UK":
            cell.circuitCountryImage.image = imageUK
        case "Russia":
            cell.circuitCountryImage.image = imageRus
        case "Belgium":
            cell.circuitCountryImage.image = imageBelgium
        case "UAE":
            cell.circuitCountryImage.image = imageUAE
        default:
            break
        }
        return cell
    }
}
