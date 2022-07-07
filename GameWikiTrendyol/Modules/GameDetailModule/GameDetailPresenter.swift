//
//  GameDetailPresenter.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 4.07.2022.
//

import Foundation

class GameDetailPresenter {
    weak var view: GameDetailViewInterface?
    var router: GameDetailRouterInterface
    var interactor: GameDetailInteractorInterface
    var game: Game?
    
    init(router: GameDetailRouterInterface, interactor: GameDetailInteractorInterface) {
        self.router = router
        self.interactor = interactor
    }
}

extension GameDetailPresenter: GameDetailPresenterInterface {
    func gameDetailFetched(gameDetail: Game) {
        self.game = gameDetail
    }
    
    func getGameDetail() -> Game? {
        return game
    }
    
    func notifyViewDidLoad() {
        view?.setupView()
        interactor.fetchGameDetail()
        view?.setupData()
    }
    
    
    func notifyViewWillAppear() {
        view?.setScreenTitle(with: "Game Detail")
    }
    
    
}
