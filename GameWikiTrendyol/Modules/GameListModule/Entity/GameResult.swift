//
//  GameResult.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 20.07.2022.
//


struct GameResult: Codable {
    let next: String?
    let previous: String?
    let results: [Game]
}
