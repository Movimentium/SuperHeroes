//
//  SuperHeroe.swift
//  SuperHeroes
//
//  Created by Miguel Gallego on 20/6/17.
//  Copyright © 2017 Miguel Gallego. All rights reserved.
//

import UIKit

// Using a struct,

struct SuperHeroe {
    
    let name: String
    let realName: String
    let height: Float
    let photo: UIImage
    let abilities: String
    let power: String
    let groups: [String]
}

extension SuperHeroe {
    init?(dicJson: [String: String]) {
        guard let strName = dicJson["name"],
            let strRealName = dicJson["realName"],
            let strHeight = dicJson["height"],
            let strPhoto = dicJson["strPhoto"],
            let strAbilities = dicJson["strAbilities"],
            let strPower = dicJson["strPower"],
            let strGroups = dicJson["strGroups"]
        else {
            return nil
        }
        let idx = strHeight.index(strHeight.startIndex, offsetBy: 4)
        guard let floatheight = Float(strHeight.substring(to: idx)),
            let img = DataProvider.singleInstance.imageFrom(strUrl: strPhoto)
        else {
            return nil
        }
        name = strName
        realName = strRealName
        height = floatheight
        photo = img
        abilities = strAbilities
        power = strPower
        groups = strGroups.components(separatedBy: ", ")
    }
    
    func debugDescription() {
        print(self)
    }
}



