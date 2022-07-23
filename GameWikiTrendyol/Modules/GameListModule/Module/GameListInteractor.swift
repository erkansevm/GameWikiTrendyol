//
//  GameListInteractor.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 29.06.2022.
//

import Foundation
import AVFoundation

final class GameListInteractor {
    weak var presenter: GameListPresenterInterface?
    var next: String?
    var prev: String?
    
    let gameService = GameService()
}

extension GameListInteractor: GameListInteractorInterface {
    func fetchGameListNext(url: String) {
        Task(priority: .background) {
            let result = await gameService.getGameListWithUrl(url: url)
            presenter?.gameListNextFetched(result: result)
        }
    }

    
    func fetchPlatforms() {
        Task(priority: .background) {
            let result = await gameService.getPlatforms()
            presenter?.platformsFetched(result: result)
        }
    }
    
    func fetchGameList() {

        Task(priority: .background) {
            let result = await gameService.getGameList()
            presenter?.gameListFetced(result: result)
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
            let result = await gameService.getGameWithQuery(query: queryItems)
            presenter?.gameListFetced(result: result)
        }
    }
    
    
    

}
