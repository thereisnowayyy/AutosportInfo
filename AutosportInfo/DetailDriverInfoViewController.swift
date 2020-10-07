//
//  DetailDriverInfoViewController.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 16.09.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//

import UIKit
import SafariServices

class DetailDriverInfoViewController: UIViewController {
    
    
    @IBAction func goToWiki(_ sender: Any) {
        let url = URL(string: driverUrlString)
        let safariVC = SFSafariViewController(url: url!)
        present(safariVC, animated: true, completion: nil)
        
    }
    
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
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewForInfo.layer.cornerRadius = 15
        viewForInfo.layer.borderColor =
            UIColor.black.cgColor
        viewForInfo.layer.borderWidth = 3
        
        
        viewForWins.layer.cornerRadius = viewForInfo.layer.cornerRadius
        viewForWins.layer.borderColor = viewForInfo.layer.borderColor
        viewForWins.layer.borderWidth = viewForInfo.layer.borderWidth
        
        seasonStandingView.layer.cornerRadius = viewForInfo.layer.cornerRadius
        seasonStandingView.layer.borderColor =
            viewForInfo.layer.borderColor
        seasonStandingView.layer.borderWidth =
            viewForInfo.layer.borderWidth
        
        viewForPoints.layer.cornerRadius =
            viewForInfo.layer.cornerRadius
        viewForPoints.layer.borderColor = viewForInfo.layer.borderColor
        viewForPoints.layer.borderWidth = viewForInfo.layer.borderWidth
        
        viewForAge.layer.cornerRadius = viewForInfo.layer.cornerRadius
        viewForAge.layer.borderColor = viewForInfo.layer.borderColor
        viewForAge.layer.borderWidth = viewForInfo.layer.borderWidth
        
        
        champStanding.text = seasonStanding
        winsOfDriver.text = driverWins
        pointsOfDriver.text = driverPoints
        nationality.text = driverNationality
        navigationController?.navigationBar.barTintColor = .gray
        let gradient = CAGradientLayer()
        
        gradient.frame = entryView.bounds
        gradient.colors = [UIColor.black.cgColor,
                        UIColor.gray.cgColor]
        entryView.layer.insertSublayer(gradient, at: 0)
        gradient.isOpaque = false
        
        driverAge.text = driverBirth
        nameDriver.text = driverName
        lastNameDriver.text = driverLastName
        driverTeam.text = teamOfDriver
        driverNumber.text = driverPermanentNumber
        
        imageDownloader()
        
        
        driverImage.alpha = 0.0
        UIView.animate(withDuration: 2.0,
            animations: { [weak self] in
                self?.driverImage.alpha = 1.0
            })
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }


    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.driverImage.image = UIImage(data: data)
            }
        }
    }
    
    
        func imageDownloader() {
            switch driverCode {
            case "HAM":
                    if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/L/LEWHAM01_Lewis_Hamilton/lewham01.png.transform/2col-retina/image.png"){
                        driverImage.contentMode = .scaleAspectFit
                        downloadImage(from: url)
                       // driverImage.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    }
            case "BOT":
                    if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/V/VALBOT01_Valtteri_Bottas/valbot01.png.transform/2col-retina/image.png") {
                        driverImage.contentMode = .scaleAspectFit
                        downloadImage(from: url)}
            case "VER":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/M/MAXVER01_Max_Verstappen/maxver01.png.transform/2col-retina/image.png") {
                    driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "NOR":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/L/LANNOR01_Lando_Norris/lannor01.png.transform/2col-retina/image.png") {
                driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "ALB":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/A/ALEALB01_Alexander_Albon/alealb01.png.transform/2col-retina/image.png") {
                    driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "STR":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/L/LANSTR01_Lance_Stroll/lanstr01.png.transform/2col-retina/image.png") {
                driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "RIC":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/D/DANRIC01_Daniel_Ricciardo/danric01.png.transform/2col-retina/image.png") {
                driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "LEC":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/C/CHALEC01_Charles_Leclerc/chalec01.png.transform/2col-retina/image.png") {
                driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "PER":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/S/SERPER01_Sergio_Perez/serper01.png.transform/2col-retina/image.png") {
                driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "GAS":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/P/PIEGAS01_Pierre_Gasly/piegas01.png.transform/2col-retina/image.png") {
                driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "SAI":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/C/CARSAI01_Carlos_Sainz/carsai01.png.transform/2col-retina/image.png") {
                driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "OCO":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/E/ESTOCO01_Esteban_Ocon/estoco01.png.transform/2col-retina/image.png") {
                driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "VET":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/S/SEBVET01_Sebastian_Vettel/sebvet01.png.transform/2col-retina/image.png") {
                driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "KVY":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/D/DANKVY01_Daniil_Kvyat/dankvy01.png.transform/2col-retina/image.png") {
                driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "HUL":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/N/NICHUL01_Nico_Hulkenberg/nichul01.png.transform/2col-retina/image.png") {
                driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "RAI":
                let originalUrl = "https://www.formula1.com/content/dam/fom-website/drivers/K/KIMRAI01_Kimi_Räikkönen/kimrai01.png.transform/2col-retina/image.png"
                guard let encodedString = originalUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {return}
                 if let url = URL(string:
                    encodedString) {
                    driverImage.contentMode = .scaleAspectFit
                    downloadImage(from: url)}
            case "GIO":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/A/ANTGIO01_Antonio_Giovinazzi/antgio01.png.transform/2col-retina/image.png") {
                driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "MAG":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/K/KEVMAG01_Kevin_Magnussen/kevmag01.png.transform/2col-retina/image.png") {
                driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "LAT":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/N/NICLAF01_Nicholas_Latifi/niclaf01.png.transform/2col-retina/image.png") {
                driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "RUS":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/G/GEORUS01_George_Russell/georus01.png.transform/2col-retina/image.png") {
                driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
            case "GRO":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/R/ROMGRO01_Romain_Grosjean/romgro01.png.transform/2col-retina/image.png") {
                driverImage.contentMode = .scaleAspectFit
                downloadImage(from: url)}
    default:
        break
    }
}
}
/*    extension UIImageView {
        var contentClippingRect: CGRect {
            guard let image = image else { return bounds }
            guard contentMode == .scaleAspectFit else { return bounds }
            guard image.size.width > 0 && image.size.height > 0 else { return bounds }

            let scale: CGFloat
            if image.size.width > image.size.height {
                scale = bounds.width / image.size.width
            } else {
                scale = bounds.height / image.size.height
            }

            let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
            let x = (bounds.width - size.width) / 2.0
            let y = (bounds.height - size.height) / 2.0

            return CGRect(x: x, y: y, width: size.width, height: size.height)
        } */
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

