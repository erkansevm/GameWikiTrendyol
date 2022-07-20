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
    private var games: [Game]?
    private var platforms: [Platform]?
    
    init(router: GameListRouterInterface, interactor: GameListInteractorInterface){
        self.router = router
        self.interactor = interactor
    }
    
    let kgameDetailSegueIdentifier = "showGameDetail"
    let kPageTitle = "Games"
}

extension GameListPresenter: GameListPresenterInterface {
    func didSelectPlatformAt(indexPath: IndexPath) {
        guard let platform = platforms?[indexPath.row] else {
            return
        }
        view?.showLoading()
        interactor.fetchGameListWithQuery(search: nil, platform: "\(platform.id)")
    }
    
    func platformForItemAt(row: Int) -> Platform? {
        let platform = platforms?[row]
        return platform
    }
    
    func platformFetchFailed(with errorMesssage: String) {
        router.presentPopup(with: errorMesssage)
    }
    
    func platformsFetched(platforms: [Platform]) {
        self.platforms = platforms
        view?.reloadData()
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
    
    func getPlatforms() -> [Platform]? {
        return platforms
    }
    
    func notifyViewLoaded() {
        view?.setupInitialView()
        view?.showLoading()
        interactor.fetchGameList()
        
        interactor.fetchPlatforms()
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
