//
//  TabBarRouter.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 1.07.2022.
//

import Foundation
import UIKit

class TabBarRouter {
    weak var presenter: TabBarPresenterInterface?
    
    
    
    static func createModule() -> TabBarViewController {
        // Create layers

        let navigationController = UINavigationController()
        let gameListModule = GameListRouter.createModule(using: navigationController)
        navigationController.setViewControllers([gameListModule], animated: false)
        
        let tabBarStoryBoard = AppStoryboard.TabBar.instance
        let tabBarView = tabBarStoryBoard.instantiateViewController(withIdentifier: TabBarViewController.identifier) as! TabBarViewController

        let router = TabBarRouter()
        let presenter = TabBarPresenter(view: tabBarView, router: router)
        tabBarView.presenter = presenter
        router.presenter = presenter
        tabBarView.viewControllers = [navigationController]
        return tabBarView
    }
}


extension TabBarRouter: TabBarRouterInterface {
    func goToGames() {
        print("go to games")
    }
    
    func goToWhislist() {
        print("go to whistlist")
    }
    
    
}
