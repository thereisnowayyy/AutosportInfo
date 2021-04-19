//
//  FirstTableViewController.swift
//  AutosportInfo
//

import DateToolsSwift

final class DriversTableViewController: UITableViewController {
    
    var jsonInfo: DriversInfo?
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
        getDriverStandings()
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl!.isRefreshing {
            
            NetworkHelper.instance.getDriverStandings().then { result in
                self.refreshControl?.endRefreshing()
                
                self.jsonInfo = result
                self.table.reloadData()
                
                UIView.transition(with: self.table,
                                  duration: 0.8,
                                  options: [.curveEaseInOut],
                                  animations: {
                                    self.jsonInfo = result
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
    
    func getDriverStandings() {
        NetworkHelper.instance.getDriverStandings().then { result in
            
            self.jsonInfo = result
            self.table.reloadData()
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            }, completion: nil)
        }.catch { Error in
            
            let alert = UIAlertController(title: "Ошибка сети", message: "Вероятно, отсутствует подключение к интернету", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

