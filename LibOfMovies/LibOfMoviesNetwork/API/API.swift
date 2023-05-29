//
//  API.swift
//  LibOfMoviesNetwork
//
//  Created by Wojciech Kulas on 29/05/2023.
//

import Foundation

fileprivate struct APIConstants {
    static let apiKey: String = "c5259c99c38044a347327a8a2c66d335"
}

public enum APIManager: String {
    case nowPlaying
    
    public var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie"
        switch self {
        case .nowPlaying:
            components.path += "/now_playing"
            components.queryItems = [URLQueryItem(name: "api_key", value: APIConstants.apiKey)]
            return components.url
        }
    }
}
