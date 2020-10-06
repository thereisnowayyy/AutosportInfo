//
//  TeamsCollectionViewCell.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 04.10.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamNameLabel: UILabel!
    func configure(with teamName: String)  {
        teamNameLabel.text = teamName
    }
}
