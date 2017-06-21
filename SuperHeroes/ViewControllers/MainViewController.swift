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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var btnReload: UIButton!

    let dataProv = DataProvider.singleInstance
    let heroesTableDSD = HeroesTableDSD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfigView()
        heroesTableDSD.delegate = self
        heroesTable.dataSource = heroesTableDSD
        heroesTable.delegate = heroesTableDSD
        dataProv.delegate = self
    }
    
    private func initialConfigView() {
        heroesTable.alpha = 0.0
        lblError.alpha = 0.0
        btnReload.alpha = 0.0
        spinner.alpha = 0.0
        btnReload.layer.cornerRadius = 4.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onBtnReload()
    }
    
    private func showView(view: UIView, isToShow: Bool, animated: Bool) {
        let alpha: CGFloat = isToShow ? 1.0 : 0.0
        if alpha == view.alpha {
            return
        }
        let animTime = animated ? 0.25 : 0.0
        UIView.animate(withDuration: animTime) {
            view.alpha = alpha
        }
    }
    
    @IBAction func onBtnReload() {
        spinner.startAnimating()
        showView(view: spinner, isToShow: true, animated: true)
        showView(view: lblError, isToShow: false, animated: true)
        showView(view: btnReload, isToShow: false, animated: true)
        dataProv.callWebService()
    }
    
    // MARK - HeroesTableDelegate ==============
    func dataProvider(didFinishOk: Bool, withError error: DataProviderError?) {
        showView(view: spinner, isToShow: false, animated: true)
        spinner.stopAnimating()
        if didFinishOk {
            heroesTable.reloadData()
            showView(view: heroesTable, isToShow: true, animated: true)
        } else {
            showView(view: lblError, isToShow: true, animated: true)
            showView(view: btnReload, isToShow: true, animated: true)
            lblError.text = "ERROR\n" + error!.info()
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
