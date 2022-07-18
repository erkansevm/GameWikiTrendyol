//
//  GameListInteractor.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 29.06.2022.
//

import Foundation

class GameListInteractor {
    let service = NetworkManager()
    weak var presenter: GameListPresenterInterface?
    var next: String?
    var prev: String?
    
}

extension GameListInteractor: GameListInteractorInterface {
   
    func fetchNextPage(){
        
    }
    func fetchGameList() {
        service.fetchFirstPage(expectedType: GameResult.self) {[weak self] result in
            switch result {
                
            case .success(let gameResult):
                self?.presenter?.gameListFetced(gameList: gameResult.results)
            case .failure(let error):
                self?.presenter?.gameListFetchFailed(with: error.localizedDescription)
            }
        }
    }
    
    
    

}
