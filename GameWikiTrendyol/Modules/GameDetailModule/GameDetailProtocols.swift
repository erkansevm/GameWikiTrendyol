//
//  GameDetailProtocols.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 4.07.2022.
//





protocol GameDetailViewInterface: AnyObject {
    func setupView()
    func setScreenTitle(with title: String)
    func setupData()
}


protocol GameDetailRouterInterface: AnyObject {
    func goBack()
}

protocol GameDetailInteractorInterface: AnyObject {
    func fetchGameDetail()
}

protocol GameDetailPresenterInterface: AnyObject {
    func getGameDetail() -> Game?
    func notifyViewDidLoad()
    func notifyViewWillAppear()
    func gameDetailFetched(gameDetail: Game)
}



