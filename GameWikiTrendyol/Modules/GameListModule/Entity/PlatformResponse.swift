//
//  PlatformResponse.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 19.07.2022.
//

import Foundation

struct PlatformResponse: Codable {
    let count: Int
    let results: [Platform]
}
