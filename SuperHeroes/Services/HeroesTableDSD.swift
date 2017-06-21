//
//  HeroesTableDSD.swift
//  SuperHeroes
//
//  Created by Miguel Gallego on 21/6/17.
//  Copyright © 2017 Miguel Gallego. All rights reserved.
//

import UIKit


import UIKit

protocol HeroesTableDelegate {
    func heroesTableDidSelectRow(atIndex idx: Int)
}

class HeroesTableDSD: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var delegate: HeroesTableDelegate?
    private let dataProv = DataProvider.singleInstance
    private var isTableConfig = false
    private let strIdCell = String(describing: HeroTableViewCell.self)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isTableConfig == false {
            tableView.rowHeight = 117.0
            tableView.register(UINib(nibName: strIdCell, bundle: nil),  forCellReuseIdentifier: strIdCell)
            tableView.separatorInset = UIEdgeInsets.zero
            isTableConfig = true
        }
        return dataProv.superHeroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeroTableViewCell.self), for: indexPath) as! HeroTableViewCell
        let hero = dataProv.superHeroes[indexPath.row]
        cell.lblName.text = hero.name
        cell.imgVw.image = hero.photo
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.heroesTableDidSelectRow(atIndex: indexPath.row)
    }
    
}

