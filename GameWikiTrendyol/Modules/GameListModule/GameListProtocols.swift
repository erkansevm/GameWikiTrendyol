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
    func reloadData()
    func setupInitialView()
    func setScreenTitle(with title:String)
    
}



protocol GameListPresenterInterface: AnyObject{
    // GameListView -> GameListPresenter
    func notifyViewLoaded()
    func notifyViewWillAppear()
    func didSelectRowAt(indexPath: IndexPath)
    func getGameModels() -> [Game]?
    // GameListInteractor -> GameListPresenter
    func gameListFetced(gameList:[Game])
    func gameListFetchFailed(with errorMessage:String)
    func gameDetailFetced(with game:Game)
    func gameDetailFethFailed(with errorMessage: String)
    func cellForItemAt(row: Int) -> Game?
}


protocol GameListRouterInterface {
    // GameListPresenter -> GameListRouter
    func popBack()
    func goGameDetail(with game: Game)
    
    func presentPopup(with message:String)
}

protocol GameListInteractorInterface {
    // GameListPresenter -> GameListInteractor
    func fetchGameList()
    func fetchGameDetail()
}
