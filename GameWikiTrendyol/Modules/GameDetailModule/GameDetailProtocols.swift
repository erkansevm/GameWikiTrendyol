//
//  GameDetailProtocols.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 4.07.2022.
//

import Foundation





protocol GameDetailViewInterface: AnyObject {
    func setupView()
    func setScreenTitle(with title: String)
    func setupData()
    func changeDescp(with descExpanded: Bool)
}


protocol GameDetailRouterInterface: AnyObject {
    func goBack()
    func openSafari(with url: URL)
}

protocol GameDetailInteractorInterface: AnyObject {
    func fetchGameDetail(gameId: Int)
}

protocol GameDetailPresenterInterface: AnyObject {
    func getGameDetail() -> GameDetail?
    func notifyViewDidLoad()
    func notifyViewWillAppear()
    func didTapDesc()
    func didTapVisitReddit()
    func didTapVisitWebsite()
    
    func gameDetailFetched(gameDetail: GameDetail)
    func gameDetailFethFailed(error: NetworkError)
}



