//
//  GamesEndpoint.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 19.07.2022.
//

import Foundation

enum GamesEndpoint {
    case gameList
    case gameDetail(id: Int)
}

extension GamesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .gameList:
            return "/api/games"
        case .gameDetail(let id):
            return "/api/games/\(id)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .gameList, .gameDetail:
            return .get
        }
    }
    
    
    
    var body: [String: String]? {
        switch self {
        case .gameList, .gameDetail:
            return nil
        }
    }
}
