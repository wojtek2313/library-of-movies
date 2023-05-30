//
//  NetworkManager.swift
//  LibOfMoviesNetwork
//
//  Created by Wojciech Kulas on 29/05/2023.
//

import Foundation
import UIKit

// MARK: - Error

public enum NetworkError: Error {
    case wrongURL
    case couldntFetchData
    case couldntFetchImage
}

// MARK: - Protocol Definition

public protocol NetworkManagerProtocol {
    func fetchNowPlayingMovies() async throws -> [MovieDTO]
}

// MARK: - Class Definition

@globalActor
public final actor NetworkManager: NetworkManagerProtocol {
    // MARK: - Public Properties
    
    public static let shared = NetworkManager()
    
    // MARK: - Private Properties
    
    private var session = URLSession.shared
    private let decoder = JSONDecoder()
    
    // MARK: - Initializer
    
    private init() {}
    
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
    
    public func fetchBackdropImage(fromKey key: String) async throws -> UIImage {
        var backdropImage = UIImage()
        guard let url = APIManager.imageURL(withKey: key) else { throw NetworkError.wrongURL }
        do {
            let (data, _) = try await session.data(from: url)
            guard let image = UIImage(data: data) else { throw NetworkError.couldntFetchImage }
            backdropImage = image
        }
        return backdropImage
    }
}
