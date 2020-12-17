//
//  File.swift
//  AutosportInfo
//

import UIKit

 class DriverImageDownloader {
 
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL, completion: @escaping (UIImage) -> Void) {
        getData(from: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                return
            }
            completion(image)
        }
    }
    
    func getDriverImage(driverCode: String, completion: @escaping (UIImage) -> Void) {
        switch driverCode {
            case driversCode.ham.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/L/LEWHAM01_Lewis_Hamilton/lewham01.png.transform/2col-retina/image.png") {
                        downloadImage(from: url) { image in
                            completion(image)
                    }
                }
            case driversCode.bot.rawValue:
                    if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/V/VALBOT01_Valtteri_Bottas/valbot01.png.transform/2col-retina/image.png") {
                            downloadImage(from: url) { image in
                                completion(image)
                        }
                    }
            case driversCode.ver.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/M/MAXVER01_Max_Verstappen/maxver01.png.transform/2col-retina/image.png") {
                        downloadImage(from: url) { image in
                            completion(image)
                    }
                }
            case driversCode.nor.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/L/LANNOR01_Lando_Norris/lannor01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                    }
                }
            case driversCode.alb.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/A/ALEALB01_Alexander_Albon/alealb01.png.transform/2col-retina/image.png") {
                        downloadImage(from: url) { image in
                            completion(image)
                    }
                }
            case driversCode.str.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/L/LANSTR01_Lance_Stroll/lanstr01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                }
            }
            case driversCode.ric.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/D/DANRIC01_Daniel_Ricciardo/danric01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                }
            }
            case driversCode.lec.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/C/CHALEC01_Charles_Leclerc/chalec01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                }
            }
            case driversCode.per.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/S/SERPER01_Sergio_Perez/serper01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                }
            }
            case driversCode.gas.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/P/PIEGAS01_Pierre_Gasly/piegas01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                }
            }
            case driversCode.sai.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/C/CARSAI01_Carlos_Sainz/carsai01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                }
            }
            case driversCode.oco.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/E/ESTOCO01_Esteban_Ocon/estoco01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                }
            }
            case driversCode.vet.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/S/SEBVET01_Sebastian_Vettel/sebvet01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                }
            }
            case driversCode.kvy.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/D/DANKVY01_Daniil_Kvyat/dankvy01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                }
            }
            case driversCode.hul.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/N/NICHUL01_Nico_Hulkenberg/nichul01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                }
            }
            case driversCode.rai.rawValue:
                let originalUrl = "https://www.formula1.com/content/dam/fom-website/drivers/K/KIMRAI01_Kimi_Räikkönen/kimrai01.png.transform/2col-retina/image.png"
                guard let encodedString = originalUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {return}
                 if let url = URL(string:
                    encodedString) {
                    downloadImage(from: url) { image in
                        completion(image)
                    }
                 }
            case driversCode.gio.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/A/ANTGIO01_Antonio_Giovinazzi/antgio01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                }
            }
            case driversCode.mag.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/K/KEVMAG01_Kevin_Magnussen/kevmag01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                }
            }
            case driversCode.lat.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/N/NICLAF01_Nicholas_Latifi/niclaf01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                }
            }
            case driversCode.rus.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/G/GEORUS01_George_Russell/georus01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                }
            }
            case driversCode.gro.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/R/ROMGRO01_Romain_Grosjean/romgro01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                }
            }
            case driversCode.ait.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/J/JACAIT01_Jack_Aitken/jacait01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                    }
                }
            case driversCode.fit.rawValue:
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/P/PIEFIT01_Pietro_Fittipaldi/piefit01.png.transform/2col-retina/image.png") {
                    downloadImage(from: url) { image in
                        completion(image)
                    }
                }
            default:
                break
            }
      }
    
   enum driversCode: String, CodingKey {
    case ham = "HAM"
    case bot = "BOT"
    
    case ver = "VER"
    case nor = "NOR"
    
    case alb = "ALB"
    case str = "STR"
    
    case ric = "RIC"
    case lec = "LEC"
    
    case per = "PER"
    case gas = "GAS"
    
    case sai = "SAI"
    case oco = "OCO"
    
    case vet = "VET"
    case kvy = "KVY"
    
    case hul = "HUL"
    case rai = "RAI"
    
    case gio = "GIO"
    case mag = "MAG"
    
    case lat = "LAT"
    case rus = "RUS"
    
    case gro = "GRO"
    case ait = "AIT"
    
    case fit = "FIT"
    }
}

