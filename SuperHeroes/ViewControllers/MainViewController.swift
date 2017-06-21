//
//  MainViewController.swift
//  SuperHeroes
//
//  Created by Miguel Gallego on 20/6/17.
//  Copyright © 2017 Miguel Gallego. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, HeroesTableDelegate, DataProviderDelegate {

    @IBOutlet weak var heroesTable: UITableView!
    
    let dataProv = DataProvider.singleInstance
    let heroesTableDSD = HeroesTableDSD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroesTableDSD.delegate = self
        heroesTable.dataSource = heroesTableDSD
        heroesTable.delegate = heroesTableDSD
        showTable(isToShow: false, animated: false)
        dataProv.delegate = self
        dataProv.callWebService()
    }

    func showTable(isToShow: Bool, animated: Bool) {
        let alpha = isToShow ? 1.0 : 0.0
        let animTime = animated ? 0.25 : 0.0
        UIView.animate(withDuration: animTime) {
            self.heroesTable.alpha = CGFloat(alpha)
        }
    }
    
    // MARK - HeroesTableDelegate ==============
    func dataProvider(didFinishOk: Bool, withError error: DataProviderError?) {
        print(#function)
        if didFinishOk {

            heroesTable.reloadData()
            showTable(isToShow: true, animated: true)
        } else {
            print(error!.info())
        }
    }
    
    // MARK - HeroesTableDelegate ==============
    func heroesTableDidSelectRow(atIndex idx: Int) {
        dataProv.selectedIndex = idx
        performSegue(withIdentifier: "showDetail", sender: nil)
        heroesTable.deselectRow(at: IndexPath(row: idx, section: 0), animated: false)
    }
}
