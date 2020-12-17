//
//  PreferencesViewController.swift
//  AutosportInfo
//


import UIKit

class StatsViewController: UITableViewController {
    
    var resultJsonData: ResultsStart? = nil
    @IBOutlet weak var resultsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkHelper.instance.getRacesResults().then { result in
            
            self.resultJsonData = result
            self.resultsTable.reloadData()
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            }, completion: nil)
        }.catch { Error in
            
            let alert = UIAlertController(title: "Ошибка сети", message: "Вероятно, отсутствует подключение к интернету", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultJsonData?.mrData.raceTable.races.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let gpName = resultJsonData?.mrData.raceTable.races[indexPath.row].raceName
        
        cell.textLabel?.text = gpName
        tableView.tableFooterView = UIView()
        return cell
    }
        
}
