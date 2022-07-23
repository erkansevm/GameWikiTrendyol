//
//  GameListProtocols.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 29.06.2022.
//

import Foundation


// GameListPresenter -> GameListView

protocol GameListViewInterface: AnyObject {
    func showLoading()
    func hideLoading()
    func bottomLoadingState(shouldShow: Bool)
    func reloadGameListData()
    func reloadPlatformData()
    func setupInitialView()
    func setScreenTitle(with title:String)
    func showNoResult()
}



protocol GameListPresenterInterface: AnyObject{
    // GameListView -> GameListPresenter
    func notifyViewLoaded()
    func notifyViewWillAppear()
    func notifySearchButtonPressed()
    func notifySearchCancelButtonPressed()
    func notifyFetchNext() 
    func didSelectRowAt(indexPath: IndexPath)
    func didSelectPlatformAt(indexPath: IndexPath)
    func didDeSelectPlatform()
    func getGameModels() -> [Game]
    func getPlatforms() -> [Platform]
    func updateSerchTerm(text: String)
    // GameListInteractor -> GameListPresenter
    func platformsFetched(result: Result<PlatformResponse, RequestError>)
    func gameListNextFetched(result: Result<GameResult,RequestError>)
    func gameListFetced(result: Result<GameResult, RequestError>)
    func cellForItemAt(row: Int) -> Game?
    func platformForItemAt(row: Int) -> Platform?
}


protocol GameListRouterInterface {
    // GameListPresenter -> GameListRouter
    func popBack()
    func goGameDetail(with gameId: Int)
    
    func presentPopup(with message:String)
}

protocol GameListInteractorInterface {
    // GameListPresenter -> GameListInteractor
    func fetchPlatforms()
    func fetchGameList()
    func fetchGameListWithQuery(search: String?, platform: Platform?)
    func fetchGameListNext(url: String)
}
