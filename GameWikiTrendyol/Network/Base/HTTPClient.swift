//
//  HTTPClient.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 19.07.2022.
//
import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type, query: [URLQueryItem]) async -> Result<T, RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type,
        query: [URLQueryItem] = [URLQueryItem]()
    ) async -> Result<T, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        let apiKeyQueryItem = URLQueryItem(name: "key", value: Constants .apiKey.rawValue)
        var queryItems = query
        queryItems.append(apiKeyQueryItem)
        urlComponents.queryItems = queryItems
        
        print(urlComponents.url!)
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        print("girdim")

        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                print("no response")
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let decodedResponse = try? decoder.decode(responseModel, from: data) else {
                    
                    return .failure(.decode)
                }
                return .success(decodedResponse)
            case 401:
                print("no unauthorized")

                return .failure(.unauthorized)
            default:
                print("no unexpectedStatusCode")

                return .failure(.unexpectedStatusCode)
            }
        } catch {
            print(error)
            return .failure(.unknown)
        }
    }
    
    
}
