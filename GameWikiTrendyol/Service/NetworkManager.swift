//
//  NetworkManager.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 29.06.2022.
//

import Foundation

private enum URLS: String {
    case baseUrl = "https://api.rawg.io/api"
    case apiKey = "0e50318730bf4480877af913a2a170c2"
    case firstPage = "https://api.rawg.io/api/games?key=0e50318730bf4480877af913a2a170c2"

}

enum NetworkError: Error {
    case failedToFetch
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    
    
    func fetchGame(with id: Int, completion: @escaping (Result<GameDetail, NetworkError>) -> Void) {
        let urlString = "\(URLS.baseUrl.rawValue)/games/\(id)?key=\(URLS.apiKey.rawValue)"
        print("single game request url -> " + urlString)
        guard let url = URL(string: urlString) else {
            completion(.failure(.failedToFetch))
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data,  error == nil else {
                print(error!)
                completion(.failure(.failedToFetch))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let decodedData = try decoder.decode(GameDetail.self, from: data)
                completion(.success(decodedData))
            } catch  {
                print(error)
                completion(.failure(.failedToFetch))
            }
        }
        task.resume()
    }
    
    func fetchFirstPage<T: Codable>( expectedType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: URLS.firstPage.rawValue) else {
            completion(.failure(.failedToFetch))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print(error!)
                completion(.failure(.failedToFetch))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let decodedData = try decoder.decode(expectedType, from: data)
                completion(.success(decodedData))
            } catch  {
                print(error)
                completion(.failure(.failedToFetch))
            }
        }
        
        task.resume()
    }
}

struct GameResult: Codable {
    let next: String?
    let previous: String?
    let results: [Game]
}
