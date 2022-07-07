//
//  TabBarProtocols.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 1.07.2022.
//

import Foundation


protocol TabBarViewIntercafe: AnyObject {
    func setupInitialView()
}


protocol TabBarPresenterInterface: AnyObject {
    func notifyViewLoaded()
    func notifyViewWillAppear()
    func tabSelected()
}

protocol TabBarRouterInterface: AnyObject {
    func goToGames()
    func goToWhislist()
}

