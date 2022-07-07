//
//  GameDetailInteractor.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 4.07.2022.
//

import Foundation


class GameDetailInteractor {
    let game: Game
    weak var presenter: GameDetailPresenter?
    
    init(game: Game){
        self.game = game
    }
}

extension GameDetailInteractor: GameDetailInteractorInterface {
    func fetchGameDetail() {
        presenter?.gameDetailFetched(gameDetail: game)
    }
}
