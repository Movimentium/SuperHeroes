//
//  DetailViewController.swift
//  SuperHeroes
//
//  Created by Miguel Gallego on 21/6/17.
//  Copyright © 2017 Miguel Gallego. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let dataProv = DataProvider.singleInstance
    
  @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblRealName: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblPowers: UILabel!
    @IBOutlet weak var lblAbilities: UILabel!
    @IBOutlet weak var lblGroups: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hero = dataProv.superHeroes[dataProv.selectedIndex!]
        title = hero.name
        imgVw.image = hero.photo
        lblRealName.text = hero.realName
        lblHeight.text = "\(hero.height)m"
        lblPowers.text = hero.power
        lblAbilities.text = hero.abilities
        var strGroups = ""
        for group in hero.groups {
            strGroups += "▫️"
            strGroups += group
            strGroups += "\n"
        }
        lblGroups.text = strGroups
        imgVw.layer.cornerRadius = 4.0
        imgVw.layer.borderWidth = 1.0
        imgVw.layer.borderColor = UIColor(red: 242/255.0, green: 118/255.0, blue: 78/255.0, alpha: 1.0).cgColor
        scroll.layer.borderWidth = 0.5
        scroll.layer.borderColor = UIColor(red: 106/255.0, green: 130/255.0, blue: 137/255.0, alpha: 1.0).cgColor
    }
    
 
}
