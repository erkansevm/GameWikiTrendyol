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
    private var next: String?
    private var prev: String?
    private var platforms: [Platform]?
    private var selectedPlatform: Platform?
    private var searchText: String?
    private var nextFetched: Bool
    
    init(router: GameListRouterInterface, interactor: GameListInteractorInterface){
        self.router = router
        self.interactor = interactor
        nextFetched = false
    }
    
    let kgameDetailSegueIdentifier = "showGameDetail"
    let kPageTitle = "Games"
}

extension GameListPresenter: GameListPresenterInterface {
    func gameListNextFetched(result: Result<GameResult, RequestError>) {
        switch result {
            
        case .success(let gameResponse):
            next = gameResponse.next
            prev = gameResponse.previous
            games?.append(contentsOf: gameResponse.results)
            DispatchQueue.main.async {
                self.view?.hideLoading()
                self.view?.reloadGameListData()
                self.view?.bottomLoadingState(shouldShow: false)
            }
        case .failure(let error):
            router.presentPopup(with: error.localizedDescription)
        }
    }
    
    func updateSerchTerm(text: String) {
        searchText = text
    }
    
    func didDeSelectPlatform() {
        selectedPlatform = nil
        view?.showLoading()
        interactor.fetchGameListWithQuery(search: searchText, platform: selectedPlatform)
    }

    func notifyFetchNext() {
        guard let next = next else  {
            return
        }
        view?.bottomLoadingState(shouldShow: true)
        interactor.fetchGameListNext(url: next)
    }
    
    func didSelectPlatformAt(indexPath: IndexPath) {
        guard let platform = platforms?[indexPath.row] else {
            return
        }
        selectedPlatform = platform
        view?.showLoading()
        interactor.fetchGameListWithQuery(search: searchText, platform: selectedPlatform)
    }
    
    func notifySearchButtonPressed(){
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
    
    
    func platformsFetched(result: Result<PlatformResponse, RequestError>) {
        switch result {
            
        case .success(let platformResponse):
            self.platforms = platformResponse.results
            DispatchQueue.main.async {
                self.view?.reloadPlatformData()
            }
        case .failure(let error):
            router.presentPopup(with: error.localizedDescription)
        }
       
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        guard let gameModel = games?[indexPath.row] else { return }
        router.goGameDetail(with: gameModel.id)
    }
    
    func cellForItemAt(row: Int) -> Game? {
        let gameModel = games?[row]
        return gameModel
    }
    
  
    func getGameModels() -> [Game] {
        guard let games = games else {
            return [Game]()
        }
        return games
    }
    
    func getPlatforms() -> [Platform] {
        guard let platforms = platforms else {
            return [Platform]()
        }
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
    
 
    
    func gameListFetced(result: Result<GameResult, RequestError>) {
        switch result {
        case .success(let gameResponse):
            games = gameResponse.results
            next = gameResponse.next
            prev = gameResponse.previous
            DispatchQueue.main.async {
                self.view?.hideLoading()
                self.view?.reloadGameListData()
                if self.games?.count == 0 {
                    self.view?.showNoResult()
                }
            }
        case .failure(let error):
            router.presentPopup(with: error.localizedDescription)
        }
        
    }

    
}
