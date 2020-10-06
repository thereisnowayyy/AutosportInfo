//
//  DetailTeamInfoViewController.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 16.09.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//

import UIKit

class DetailTeamInfoViewController: UIViewController {
    
    @IBOutlet var teamNameLabel: UILabel!
    var teamName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Ferrari
        navigationController?.navigationBar.barTintColor = .Ferrari
        teamNameLabel.text = teamName
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
