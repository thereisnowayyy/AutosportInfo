//
//  SearchResponse.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 10.09.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//
import UIKit
struct responseResults: Codable {
    var mRData: driverTable
}

struct driverTable: Codable {
    var Drivers: [Drivers1]
}

struct Drivers1: Codable {
    var givenName: String?
    var familyName: String?
}
