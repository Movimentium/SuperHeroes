//
//  DataProvider.swift
//  SuperHeroes
//
//  Created by Miguel Gallego on 20/6/17.
//  Copyright © 2017 Miguel Gallego. All rights reserved.
//

import UIKit
import Alamofire

protocol DataProviderDelegate {
    func dataProvider(didFinishOk: Bool, withError error: DataProviderError?);
}

enum DataProviderError: Error {
    case noDataResponse
    case jsonSerialization
    case creatingSuperHeroesArray
    case unknow
    
    func info() -> String {
        var str: String = "Unknow"
        switch self {
        case .noDataResponse:  str = "No data response"
        case .jsonSerialization:  str = "creating superHeroes array"
        case .creatingSuperHeroesArray:  str = "creating superHeroes array"
        default:  break
        }
        return str
    }
}

class DataProvider {
    
    static let singleInstance = DataProvider()

    var superHeroes = [SuperHero]()
    var delegate: DataProviderDelegate?
    var selectedIndex: Int?
    private let url = URL(string: "https://api.myjson.com/bins/bvyob")!
    
    private init() {}
    
    func callWebService() {
        Alamofire.request(url).responseJSON(completionHandler: { response in
            if let jsonData = response.data {
                self.parse(jsonData)
            } else {
                self.errorHandle(.noDataResponse)
            }
        })
    }
    
    private func parse(_ jsonData: Data) {
        superHeroes = []
        let dicJson = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [String : [[String : String]]]
        if dicJson == nil {
            self.errorHandle(.jsonSerialization);  return
        }
        if let arrSuperHeroes: [[String : String]] = dicJson?["superheroes"] {
            for i in 0..<arrSuperHeroes.count {
                print(arrSuperHeroes[i])
                if let aHero = SuperHero(dicJson: arrSuperHeroes[i]) {
                    superHeroes.append(aHero)
                } else {
                    self.errorHandle(.creatingSuperHeroesArray);  return
                }
            }
        }
        self.delegate?.dataProvider(didFinishOk: true, withError: nil)
    }
    
    private func errorHandle(_ error: DataProviderError) {
        self.delegate?.dataProvider(didFinishOk: false, withError: error)
    }
    
    func imageFrom(strUrl: String) -> UIImage? {
        if let img = try? UIImage(data:Data(contentsOf: URL(string: strUrl)!)) {
            return img
        }
        return nil
    }
}
