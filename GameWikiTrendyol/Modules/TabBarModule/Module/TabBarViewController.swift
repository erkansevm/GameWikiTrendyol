//
//  TabBarViewController.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 1.07.2022.
//

import UIKit

final class TabBarViewController: UITabBarController {
    static let identifier: String = "TabBarViewController"
    var presenter: TabBarPresenterInterface?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewLoaded()
    }

}


extension TabBarViewController: TabBarViewIntercafe {
    func setupInitialView() {
    }
    
    
}
