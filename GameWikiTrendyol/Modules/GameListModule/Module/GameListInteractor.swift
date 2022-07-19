//
//  GameListInteractor.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 29.06.2022.
//

import Foundation

final class GameListInteractor {
    let service = NetworkManager()
    weak var presenter: GameListPresenterInterface?
<<<<<<< HEAD:GameWikiTrendyol/Modules/GameListModule/GameListInteractor.swift
    var next: String?
    var prev: String?
    
=======
    let service2 = GameService()
>>>>>>> 64624cf83085315a4de4060e3dd949bcb9304a66:GameWikiTrendyol/Modules/GameListModule/Module/GameListInteractor.swift
}

extension GameListInteractor: GameListInteractorInterface {
   
    func fetchNextPage(){
        
    }
    func fetchGameList() {
        /*
        service.fetchFirstPage(expectedType: GameResult.self) {[weak self] result in
            switch result {
                
            case .success(let gameResult):
                self?.presenter?.gameListFetced(gameList: gameResult.results)
            case .failure(let error):
                self?.presenter?.gameListFetchFailed(with: error.localizedDescription)
            }
        }
        */
        Task(priority: .background) {
            
            let result = await service2.getGameList()
            switch result {
            case .success(let gameListResponse):
                presenter?.gameListFetced(gameList: gameListResponse.results)
            case .failure( let error):
                presenter?.gameListFetchFailed(with: error.localizedDescription)
            }
        }
    }
    
    
    

}
