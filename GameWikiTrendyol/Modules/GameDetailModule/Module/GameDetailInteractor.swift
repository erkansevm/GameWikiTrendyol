//
//  GameDetailInteractor.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 4.07.2022.
//

import Foundation


final class GameDetailInteractor {
    weak var presenter: GameDetailPresenter?
    let gameService = GameService()
    
}

extension GameDetailInteractor: GameDetailInteractorInterface {

    
    func fetchGameDetail(gameId: Int) {
        Task(priority: .background) {
            let result = await gameService.getGameDetail(id: gameId)
            
            switch result {
                
            case .success(let gameDetail):
                presenter?.gameDetailFetched(gameDetail: gameDetail)
            case .failure(let error):
                presenter?.gameDetailFethFailed(error: error.localizedDescription)
            }
        }
    }
}
