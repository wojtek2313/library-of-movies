//
//  NetworkManager.swift
//  LibOfMoviesNetwork
//
//  Created by Wojciech Kulas on 29/05/2023.
//

import Foundation

// MARK: - Error

public enum NetworkError: Error {
    case wrongURL
    case couldntFetchData
}

// MARK: - Protocol Definition

public protocol NetworkManagerProtocol {
    func fetchNowPlayingMovies() async throws
}

// MARK: - Class Definition

@MainActor
public final class NetworkManager {
    // MARK: - Private Properties
    
    private var session = URLSession.shared
    private let decoder = JSONDecoder()
    
    // MARK: - Initializer
    
    public init() {}
    
    // MARK: - Public Methods
    
    public func fetchNowPlayingMovies() async throws -> [MovieDTO] {
        var decodedMovies: [MovieDTO] = []
        guard let url = APIManager.nowPlaying.url else { throw NetworkError.wrongURL }
        do {
            let (data, _) = try await session.data(from: url)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decodedMovies = try decoder.decode(ResultsDTO.self, from: data).results
        }
        return decodedMovies
    }
}
