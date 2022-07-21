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
    func notifySearchButtonPressed(search: String)
    func notifySearchCancelButtonPressed()
    func didSelectRowAt(indexPath: IndexPath)
    func didSelectPlatformAt(indexPath: IndexPath)
    func getGameModels() -> [Game]?
    func getPlatforms() -> [Platform]?
    // GameListInteractor -> GameListPresenter
    func platformsFetched(platforms:[Platform])
    func platformFetchFailed(with errorMesssage: String)
    func gameListFetced(gameList:[Game])
    func gameListFetchFailed(with errorMessage:String)
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
}
