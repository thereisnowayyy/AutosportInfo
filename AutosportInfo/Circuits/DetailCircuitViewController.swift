//
//  DetailCircuitViewController.swift
//  AutosportInfo
//


import UIKit

final class DetailCircuitViewController: UIViewController {
    
    @IBOutlet weak var circuitNameLabel: UILabel!
    @IBOutlet weak var circImageView: UIImageView!
    @IBOutlet weak var circuitLocalityLabel: UILabel!
    
    var circuitName: String!
    var circCountry: String!
    
    var circuitId: String!
    var circLocality: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Circuits"
        imageDownloader()
        circuitNameLabel.text = circuitName
        
        circImageView.contentMode = .scaleAspectFit
        let circuitFullLocation = "\(circLocality ?? "")" + "," + " " + "\(circCountry ?? "")"
        
        circuitLocalityLabel.text = circuitFullLocation
        circImageView.alpha = 0.0
        UIView.animate(withDuration: 2.0,
            animations: { [weak self] in
                self?.circImageView.alpha = 1.0
            })
    
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.circImageView.image = UIImage(data: data)
            }
        }
    }
    
    func imageDownloader() {
        switch circuitId {
            case "bahrain":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Bahrain_Circuit.png.transform/7col-retina/image.png"){
                downloadImage(from: url)}
        case "catalunya":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Spain_Circuit.png.transform/7col-retina/image.png"){
                downloadImage(from: url)}
        case "hungaroring":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Hungary_Circuit.png.transform/7col-retina/image.png"){
                downloadImage(from: url)}
        case "imola":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Emilia_Romagna_Circuit.png.transform/7col-retina/image.png"){
                downloadImage(from: url)}
        case "istanbul":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Turkey_Circuit.png.transform/7col-retina/image.png"){
                downloadImage(from: url)}
        case "monza":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Italy_Circuit.png.transform/7col-retina/image.png"){
                downloadImage(from: url)}
        case "mugello":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Tuscany_Circuit.png.transform/7col-retina/image.png"){
                downloadImage(from: url)}
        case "nurburgring":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Germany_Circuit.png.transform/7col-retina/image.png"){
                downloadImage(from: url)}
        case "portimao":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Portugal_Circuit.png.transform/7col-retina/image.png"){
                downloadImage(from: url)}
        case "red_bull_ring":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Austria_Circuit.png.transform/7col-retina/image.png"){
                downloadImage(from: url)}
        case "silverstone":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/70th_Anniversary_Circuit.png.transform/7col-retina/image.png"){
                downloadImage(from: url)}
        case "sochi":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Russia_Circuit.png.transform/7col-retina/image.png"){
                downloadImage(from: url)}
        case "spa":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Belgium_Circuit.png.transform/7col-retina/image.png"){
                downloadImage(from: url)}
        case "yas_marina":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/2018-redesign-assets/Circuit%20maps%2016x9/Abu_Dhabi_Circuit.png.transform/7col-retina/image.png"){
                downloadImage(from: url)}
        default:
            break
        }
    }
}
