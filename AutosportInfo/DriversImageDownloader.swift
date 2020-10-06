//
//  DriversImageDownloader.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 24.09.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//

import Foundation
import UIKit

class DriversImageDownloader: UIViewController {
    let detailDriverInfo = DetailDriverInfoViewController()

func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
}


func downloadImage(from url: URL) {
    print("Download Started")
    getData(from: url) { data, response, error in
        guard let data = data, error == nil else { return }
        print(response?.suggestedFilename ?? url.lastPathComponent)
        print("Download Finished")
        DispatchQueue.main.async() {
            self.detailDriverInfo.driverImage.image = UIImage(data: data)
        }
    }
}

    func imageDownloader() {
        switch detailDriverInfo.driverCode {
        case "HAM":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/L/LEWHAM01_Lewis_Hamilton/lewham01.png.transform/2col-retina/image.png"){
                    detailDriverInfo.driverImage.contentMode = .scaleAspectFit
                    downloadImage(from: url)}
        case "BOT":
                if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/V/VALBOT01_Valtteri_Bottas/valbot01.png.transform/2col-retina/image.png") {
                    detailDriverInfo.driverImage.contentMode = .scaleAspectFit
                    downloadImage(from: url)}
        case "VER":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/M/MAXVER01_Max_Verstappen/maxver01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "NOR":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/L/LANNOR01_Lando_Norris/lannor01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "ALB":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/A/ALEALB01_Alexander_Albon/alealb01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "STR":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/L/LANSTR01_Lance_Stroll/lanstr01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "RIC":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/D/DANRIC01_Daniel_Ricciardo/danric01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "LEC":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/C/CHALEC01_Charles_Leclerc/chalec01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "PER":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/S/SERPER01_Sergio_Perez/serper01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "GAS":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/P/PIEGAS01_Pierre_Gasly/piegas01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "SAI":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/C/CARSAI01_Carlos_Sainz/carsai01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "OCO":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/E/ESTOCO01_Esteban_Ocon/estoco01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "VET":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/S/SEBVET01_Sebastian_Vettel/sebvet01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "KVY":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/D/DANKVY01_Daniil_Kvyat/dankvy01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "HUL":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/N/NICHUL01_Nico_Hulkenberg/nichul01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "RAI":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/K/KIMRAI01_Kimi_Räikkönen/kimrai01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "GIO":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/A/ANTGIO01_Antonio_Giovinazzi/antgio01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "MAG":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/K/KEVMAG01_Kevin_Magnussen/kevmag01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "LAT":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/N/NICLAF01_Nicholas_Latifi/niclaf01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "RUS":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/G/GEORUS01_George_Russell/georus01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
        case "GRO":
            if let url = URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/R/ROMGRO01_Romain_Grosjean/romgro01.png.transform/2col-retina/image.png") {
            detailDriverInfo.driverImage.contentMode = .scaleAspectFit
            downloadImage(from: url)}
default:
    break
}
}
}
