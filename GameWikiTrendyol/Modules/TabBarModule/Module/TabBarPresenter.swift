//
//  TabBarPresenter.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 1.07.2022.
//

import Foundation


final class TabBarPresenter {
    weak var view: TabBarViewIntercafe?
    var router: TabBarRouterInterface
    
    init(view: TabBarViewIntercafe, router: TabBarRouterInterface) {
        self.view = view
        self.router = router
    }
}

extension TabBarPresenter: TabBarPresenterInterface {
    func notifyViewLoaded() {
        view?.setupInitialView()
    }
    
    func notifyViewWillAppear() {
        print("viewWillAppear")
    }
    
    func tabSelected() {
        print("tabSeleted")
    }
    
    
}
