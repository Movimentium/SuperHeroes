//
//  HeroTableViewCell.swift
//  SuperHeroes
//
//  Created by Miguel Gallego on 21/6/17.
//  Copyright © 2017 Miguel Gallego. All rights reserved.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgVw.layer.cornerRadius = 4.0
        imgVw.layer.borderWidth = 1.0
        imgVw.layer.borderColor = UIColor(red: 242/255.0, green: 118/255.0, blue: 78/255.0, alpha: 1.0).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
