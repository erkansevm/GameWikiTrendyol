//
//  GameListPresenter.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 29.06.2022.
//

import Foundation

 //typealias GameViewModel = (name:String, released:String)

final class GameListPresenter {
    weak var view: GameListViewInterface?
    var router: GameListRouterInterface
    var interactor: GameListInteractorInterface
    var games: [Game]?
    
    init(router: GameListRouterInterface, interactor: GameListInteractorInterface){
        self.router = router
        self.interactor = interactor
    }
    
    let kgameDetailSegueIdentifier = "showGameDetail"
    let kPageTitle = "Games"
}

extension GameListPresenter: GameListPresenterInterface {
    func gameDetailFetced(with game: Game) {
        
    }
    
    func gameDetailFethFailed(with errorMessage: String) {
        
    }
    

    
    func didSelectRowAt(indexPath: IndexPath) {
        guard let gameModel = games?[indexPath.row] else { return }
        print(gameModel)
        router.goGameDetail(with: gameModel.id)
    }
    
    func cellForItemAt(row: Int) -> Game? {
        let gameModel = games?[row]
        return gameModel
    }
    
  
    func getGameModels() -> [Game]? {
        return games
    }
    
    func notifyViewLoaded() {
        view?.setupInitialView()
        view?.showLoading()
        interactor.fetchGameList()
    }
    
    func notifyViewWillAppear() {
        view?.setScreenTitle(with: kPageTitle)
    }
    
 
    
    func gameListFetced(gameList: [Game]) {
//        var gameViewModels = [GameViewModel]()
//        for game in gameList {
//            let gameViewModel: GameViewModel = (game.name, game.released)
//            gameViewModels.append(gameViewModel)
//        }
//        self.gameViewModels = gameViewModels
        self.games = gameList
        view?.hideLoading()
        view?.reloadData()
    }
    
    func gameListFetchFailed(with errorMessage: String) {
        router.presentPopup(with: errorMessage)
    }
    
}
