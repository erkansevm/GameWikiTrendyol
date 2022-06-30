//
//  GameListPresenter.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 29.06.2022.
//

import Foundation

typealias GameViewModel = (name:String, released:String)

class GameListPresenter {
    weak var view: GameListViewInterface?
    var router: GameListRouterInterface?
    var interactor: GameListInteractorInterface?
    var gameViewModels: [GameViewModel]?
    
    let kgameDetailSegueIdentifier = "showGameDetail"
    let kPageTitle = "Game List"
}

extension GameListPresenter: GameListPresenterInterface {
  
    func getGameViewModels() -> [GameViewModel]? {
        return gameViewModels
    }
    
    func notifyViewLoaded() {
        view?.setupInitialView()
        view?.showLoading()
        interactor?.fetchGameList()
    }
    
    func notifyViewWillAppear() {
        view?.setScreenTitle(with: kPageTitle)
    }
    
    func gameSelected() {
        router?.performSegue(with: kgameDetailSegueIdentifier)
    }
    
    func gameListFetced(gameList: [Game]) {
        var gameViewModels = [GameViewModel]()
        for game in gameList {
            let gameViewModel: GameViewModel = (game.name, game.released)
            gameViewModels.append(gameViewModel)
        }
        self.gameViewModels = gameViewModels
        view?.hideLoading()
        view?.reloadData()
    }
    
    func gameListFetchFailed(with errorMessage: String) {
        router?.presentPopup(with: errorMessage)
    }
    
}
