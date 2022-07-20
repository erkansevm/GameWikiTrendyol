//
//  GameDetailInteractor.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 4.07.2022.
//

import Foundation


final class GameDetailInteractor {
    weak var presenter: GameDetailPresenter?
    let service2 = GameService()
    
}

extension GameDetailInteractor: GameDetailInteractorInterface {

    
    func fetchGameDetail(gameId: Int) {
        /*
        service.fetchGame(with: gameId) { [weak self] result in
            switch result {
            case .success(let gameDetail):
                self?.presenter?.gameDetailFetched(gameDetail: gameDetail)
            case .failure(let error):
                self?.presenter?.gameDetailFethFailed(error: error)
            }
        } */
        
        Task(priority: .background) {
            let result = await service2.getGameDetail(id: gameId)
            
            switch result {
                
            case .success(let gameDetail):
                presenter?.gameDetailFetched(gameDetail: gameDetail)
            case .failure(let error):
                presenter?.gameDetailFethFailed(error: error.localizedDescription)
            }
        }
    }
}
