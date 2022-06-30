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
    func gameSelected()
    func getGameViewModels() -> [GameViewModel]?
    // GameListInteractor -> GameListPresenter
    func gameListFetced(gameList:[Game])
    func gameListFetchFailed(with errorMessage:String)
}


protocol GameListRouterInterface {
    // GameListPresenter -> GameListRouter
    func popBack()
    func performSegue(with identifier:String)
    func presentPopup(with message:String)
}

protocol GameListInteractorInterface {
    // GameListPresenter -> GameListInteractor
    func fetchGameList()
}
