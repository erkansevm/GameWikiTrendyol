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
    func getPlatforms() async -> Result<PlatformResponse, RequestError>
    func getGameWithQuery(query: [URLQueryItem]) async -> Result<GameResult, RequestError>
    func getGameListWithUrl(url: String) async -> Result<GameResult,RequestError>
}

struct GameService: HTTPClient, IGameService {
    func getGameListWithUrl(url: String) async -> Result<GameResult, RequestError> {
        return await sendRequestWithUrl(url: url, responseModel: GameResult.self)
    }
    
    func getGameWithQuery(query: [URLQueryItem]) async -> Result<GameResult, RequestError> {
       
        return await sendRequest(endpoint: GamesEndpoint.gameList, responseModel: GameResult.self, query: query)
    }
    
    func getPlatforms() async -> Result<PlatformResponse, RequestError> {
        return await sendRequest(endpoint: GamesEndpoint.platforms, responseModel: PlatformResponse.self)
    }
    
    func getGameList() async -> Result<GameResult, RequestError> {
        return await sendRequest(endpoint: GamesEndpoint.gameList, responseModel: GameResult.self)
    }
    
    func getGameDetail(id: Int) async -> Result<GameDetail, RequestError> {
        return await sendRequest(endpoint: GamesEndpoint.gameDetail(id: id), responseModel: GameDetail.self)
    }
}
