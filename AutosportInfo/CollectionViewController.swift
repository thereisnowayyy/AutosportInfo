//
//  CollectionViewController.swift
//  AutosportInfo
//
//  Created by Egor Salnikov on 04.10.2020.
//  Copyright © 2020 Egor Salnikov. All rights reserved.
//

import UIKit


class CollectionViewController: UICollectionViewController {
    
    let networkService = TeamNetworkService()
    var jsInfo: Teams?
    @IBOutlet var collView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://ergast.com/api/f1/2020/ConstructorStandings.json"
            networkService.request(urlString: urlString) { (result) in
                switch result {
                case .success(let teams):
                    self.jsInfo = teams
                    self.collView.reloadData()
                    print("TEST")
                case .failure(let error):
                    print(error)
                    
                }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.jsInfo?.mrDataTeams.standingsTable.standingsLists[Int()].constructorStandings.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configure the cell
        var cell =  UICollectionViewCell()
        if let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TeamsCollectionViewCell {
        let teamNames = jsInfo?.mrDataTeams.standingsTable.standingsLists[Int()].constructorStandings[indexPath.row].constructor.name
        teamCell.configure(with: teamNames!)
         cell = teamCell
    }
        cell.layer.borderWidth = view.bounds.width 
        return cell

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
}
