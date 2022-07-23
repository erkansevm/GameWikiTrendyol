//
//  GameDetail.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 7.07.2022.
//

import Foundation
import UIKit


struct GameDetail: Codable {
    let id : Int
    let name: String
    let released: String
    let metacritic: Int?
    let descriptionRaw: String?
    let genres: [Genre]?
    let playtime: Int?
    let publishers: [Publisher]?
    let redditUrl: String?
    let website: String?
    let backgroundImage: String?
    
    var genresString: String {
        get {
            var genresString = ""
            guard let genres = genres else {
                return genresString
            }
            for (index,genre) in genres.enumerated() {
                genresString += index != genres.count + -1 ? (genre.name + ",") : genre.name
                
            }
            return genresString
        }
    }
    
    var publishersString: String {
        get {
            var publishersString = ""
            guard let publishers = publishers else {
                return publishersString
            }

            for (index,publisher) in publishers.enumerated() {
                publishersString += index != publishers.count + -1 ? (publisher.name + ",") : publisher.name
                
            }
            return publishersString
        }
    }
    
    var color: UIColor? {
        get {
            guard let metacritic = metacritic else {
                return nil
            }
            
            switch metacritic {
            case 0..<50:
                return UIColor.systemRed
            case 50..<75:
                return UIColor.systemYellow
            case 75..<100:
                return UIColor.systemGreen
            default:
                return nil
            }
        }
    }
}

struct Publisher: Codable {
    let id: Int
    let name: String
}

struct Genre: Codable {
    let id: Int
    let name: String
}
