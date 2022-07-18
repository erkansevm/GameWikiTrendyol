//
//  GameDetailInteractor.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 4.07.2022.
//

import Foundation


class GameDetailInteractor {
    let service = NetworkManager()
    weak var presenter: GameDetailPresenter?
    
}

extension GameDetailInteractor: GameDetailInteractorInterface {

    
    func fetchGameDetail(gameId: Int) {
        service.fetchGame(with: gameId) { [weak self] result in
            switch result {
            case .success(let gameDetail):
                self?.presenter?.gameDetailFetched(gameDetail: gameDetail)
            case .failure(let error):
                self?.presenter?.gameDetailFethFailed(error: error)
            }
        }
    }
}
