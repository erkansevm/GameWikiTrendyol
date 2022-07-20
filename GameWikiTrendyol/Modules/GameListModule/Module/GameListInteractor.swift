//
//  GameListInteractor.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 29.06.2022.
//

import Foundation

final class GameListInteractor {
    weak var presenter: GameListPresenterInterface?
    var next: String?
    var prev: String?

    let service2 = GameService()
}

extension GameListInteractor: GameListInteractorInterface {
   
    func fetchNextPage(){
        
    }
    
    func fetchPlatforms() {
        Task(priority: .background) {
            let result = await service2.getPlatforms()
            switch result {
            case .success(let platformResponse):
                presenter?.platformsFetched(platforms: platformResponse.results)
                print("platofrms -> \(platformResponse.results)")
            case .failure(let error):
                presenter?.platformFetchFailed(with: error.localizedDescription)
            }
        }
    }
    
    func fetchGameList() {

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
    
    func fetchGameListWithQuery(search: String?, platform: Platform?){
        Task(priority: .background) {
            var queryItems = [URLQueryItem]()
            if search != nil {
                let searchQueryItem = URLQueryItem(name: "search", value: search)
                queryItems.append(searchQueryItem)
            }
            if platform != nil {
                guard let platform = platform else {
                    return
                }

                let platformQueryItem = URLQueryItem(name: "parent_platforms", value: "\(platform.id)" )
                queryItems.append(platformQueryItem)
            }
            let result = await service2.getGameWithQuery(query: queryItems)
            switch result {
            case .success(let gameListResponse):
                print("filtreli gameList")
                print(gameListResponse)
                presenter?.gameListFetced(gameList: gameListResponse.results)
            case .failure( let error):
                print(error)
                presenter?.gameListFetchFailed(with: error.localizedDescription)
            }
        }
    }
    
    
    

}
