//
//  SecondTableViewController.swift
//  AutosportInfo
//


import UIKit

class SecondTableViewController: UITableViewController {
    
    var teamJsonInfo: Teams?
    @IBOutlet weak var table: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.separatorStyle = .none
        
        NetworkHelper.instance.getConstructorStandings().then { result in
            
            self.teamJsonInfo = result
            self.table.reloadData()
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            }, completion: nil)
        }
        
        NetworkHelper.instance.getConstructorStandings().catch { Error in
            
            let alert = UIAlertController(title: "Ошибка сети", message: "Вероятно, отсутствует подключение к интернету", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        refreshControl?.isHidden = true
        refreshControl?.endRefreshing()
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl!.isRefreshing {
            NetworkHelper.instance.getConstructorStandings().then { result in
                self.refreshControl?.endRefreshing()
                
                self.teamJsonInfo = result
                self.table.reloadData()
                
                UIView.transition(with: self.table,
                                  duration: 0.8,
                                  options: [.curveEaseInOut],
                                  animations: {
                                    self.teamJsonInfo = result
                                    self.table.reloadData()
                                  }, completion: nil)
            }

            NetworkHelper.instance.getDriverStandings().catch { Error in
                self.refreshControl?.endRefreshing()
                
                let alert = UIAlertController(title: "Ошибка сети", message: "Вероятно, отсутствует подключение к интернету", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func refreshControl(_ sender: UIRefreshControl) {
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

        let constructorName = "\(teams!.constructor.name)"
        cell.cellView.layer.cornerRadius = 15
        
        cell.teamName.text = constructorName
        cell.teamNationalityLabel.text = teams?.constructor.nationality
        
        cell.countWins.text = teams?.wins
        cell.countPosition.text = teams?.position
        
        cell.countPoints.text = teams?.points
        tableView.tableFooterView = UIView()
        
        return cell
        }
}
