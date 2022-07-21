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
    private var selectedPlatform: Platform?
    private var searchText: String?
    
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
        selectedPlatform = platform
        view?.showLoading()
        interactor.fetchGameListWithQuery(search: searchText, platform: selectedPlatform)
    }
    
    func notifySearchButtonPressed(search: String){
        searchText = search
        view?.showLoading()
        interactor.fetchGameListWithQuery(search: searchText, platform: selectedPlatform)
    }
    
    func notifySearchCancelButtonPressed(){
        searchText = nil
        view?.showLoading()
        interactor.fetchGameListWithQuery(search: searchText, platform: selectedPlatform)
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
        view?.reloadPlatformData()
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        guard let gameModel = games?[indexPath.row] else { return }
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
        self.games = gameList
        view?.hideLoading()
        view?.reloadGameListData()
        if games?.count == 0 {
            view?.showNoResult()
        }
    }
    
    func gameListFetchFailed(with errorMessage: String) {
        router.presentPopup(with: errorMessage)
    }
    
}
