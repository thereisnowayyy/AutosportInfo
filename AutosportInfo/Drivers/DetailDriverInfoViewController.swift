//
//  DetailDriverInfoViewController.swift
//  AutosportInfo
//

import SafariServices

class DetailDriverInfoViewController: UIViewController {
    
    var driverImageDownloader = DriverImageDownloader()
    
    @IBOutlet weak var viewForInfo: UIView!
    @IBOutlet weak var nationality: UILabel!
    
    @IBOutlet weak var driverImage: UIImageView!
    @IBOutlet weak var nameDriver: UILabel!
    
    @IBOutlet weak var lastNameDriver: UILabel!
    @IBOutlet weak var driverTeam: UILabel!
    
    @IBOutlet weak var driverNumber: UILabel!
    @IBOutlet weak var driverAge: UILabel!
    
    @IBOutlet weak var entryView: UIView!
    @IBOutlet weak var viewForAge: UIView!
    
    @IBOutlet weak var viewForPoints: UIView!
    @IBOutlet weak var viewForWins: UIView!
    
    @IBOutlet weak var winsOfDriver: UILabel!
    @IBOutlet weak var pointsOfDriver: UILabel!
    
    @IBOutlet weak var nationalityFixedLabel: UILabel!
    @IBOutlet weak var seasonStandingView: UIView!
    
    @IBOutlet weak var championshipStandingFixedLabel: UILabel!
    @IBOutlet weak var champStanding: UILabel!
    
    var driverUrlString: String!
    var driverName: String!
    
    var driverNationality: String!
    var driverLastName: String!
    
    var teamOfDriver: String!
    var driverPermanentNumber: String!
    
    var driverCode: String!
    var driverBirth: String!
    
    var driverPoints: String!
    var driverWins: String!
    var seasonStanding: String!
    
    @IBAction func goToWiki(_ sender: Any) {
        guard let url = URL(string: driverUrlString) else {return}
        let safariVC = SFSafariViewController(url: url)
        
        present(safariVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
       
        driverImageDownloader.getDriverImage(driverCode: driverCode) { image in
            DispatchQueue.main.async {
                self.driverImage.image = image
            }
        }
    }
    
    func configureViews() {
        let allViews = [viewForInfo,viewForWins,viewForAge,viewForPoints,seasonStandingView]
        allViews.forEach { $0?.layer.cornerRadius = 15
            
            $0?.layer.borderColor = UIColor.black.cgColor
            $0?.layer.borderWidth = 3
        }
    
        champStanding.text = seasonStanding
        winsOfDriver.text = driverWins
        
        pointsOfDriver.text = driverPoints
        nationality.text = driverNationality
        
        driverAge.text = driverBirth
        nameDriver.text = driverName
        
        lastNameDriver.text = driverLastName
        driverTeam.text = teamOfDriver
        driverNumber.text = driverPermanentNumber
        
        driverImage.alpha = 0.0
        UIView.animate(withDuration: 2.0,
            animations: { [weak self] in
                self?.driverImage.alpha = 1.0
            })
    
        navigationController?.navigationBar.barTintColor = .lightGray

        let gradient = CAGradientLayer()
        gradient.frame = entryView.bounds
        
        gradient.colors = [UIColor.black.cgColor,
                        UIColor.gray.cgColor]
        entryView.layer.insertSublayer(gradient, at: 0)
        gradient.isOpaque = false
        
        driverImage.contentMode = .scaleAspectFit
    }
}
