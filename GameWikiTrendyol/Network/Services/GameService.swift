//
//  MovieService.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 19.07.2022.
//

import Foundation

protocol IGameService {
    func getGameList() async -> Result<GameResult, RequestError>
    func getGameDetail(id: Int) async -> Result<GameDetail, RequestError>
}

struct GameService: HTTPClient, IGameService {
    func getGameList() async -> Result<GameResult, RequestError> {
        return await sendRequest(endpoint: GamesEndpoint.gameList, responseModel: GameResult.self)
    }
    
    func getGameDetail(id: Int) async -> Result<GameDetail, RequestError> {
        return await sendRequest(endpoint: GamesEndpoint.gameDetail(id: id), responseModel: GameDetail.self)
    }
}
