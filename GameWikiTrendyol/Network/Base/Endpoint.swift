//
//  Endpoint.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 19.07.2022.
//


protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.rawg.io"
    }
}
