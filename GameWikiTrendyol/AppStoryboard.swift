//
//  AppStoryboard.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 4.07.2022.
//

import UIKit


enum AppStoryboard: String {
    case GameList = "GameList"
    case GameDetail = "GameDetail"
    case TabBar = "TabBar"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}



