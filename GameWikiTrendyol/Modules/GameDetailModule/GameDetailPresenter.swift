//
//  GameDetailPresenter.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 4.07.2022.
//

import Foundation

class GameDetailPresenter {
    weak var view: GameDetailViewInterface?
    var router: GameDetailRouterInterface
    var interactor: GameDetailInteractorInterface
    private let gameId: Int
    private var gameDetail: GameDetail?
    private var descExpanded = false
    
    init(gameId: Int,router: GameDetailRouterInterface, interactor: GameDetailInteractorInterface) {
        self.gameId = gameId
        self.router = router
        self.interactor = interactor
    }
}

extension GameDetailPresenter: GameDetailPresenterInterface {
    func didTapVisitReddit() {
        guard let gameDetail = gameDetail,
              let urlString = gameDetail.redditUrl,
              let url = URL(string: urlString)
        else {
            return
        }
        router.openSafari(with: url)
    }
    
    func didTapVisitWebsite() {
        guard let gameDetail = gameDetail,
              let urlString = gameDetail.website,
              let url = URL(string: urlString)
        else {
            return
        }
        router.openSafari(with: url)
    }
    
    func didTapDesc() {
        descExpanded.toggle()
        view?.changeDescp(with: descExpanded)
    }
    
    func gameDetailFethFailed(error: NetworkError) {
        print(error.localizedDescription)
    }
    
    func gameDetailFetched(gameDetail: GameDetail) {
        print("geldi -> " + gameDetail.name)
        self.gameDetail = gameDetail
        view?.setupData()
    }
    
    func getGameDetail() -> GameDetail? {
        return gameDetail
    }
    
    func notifyViewDidLoad() {
        view?.setupView()
        interactor.fetchGameDetail(gameId: gameId)
    }
    
    
    func notifyViewWillAppear() {
        view?.setScreenTitle(with: "Game Detail")
    }
    
    
}
