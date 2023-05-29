//
//  MainViewModel.swift
//  LibOfMovies
//
//  Created by Wojciech Kulas on 29/05/2023.
//

import Foundation
import LibOfMoviesNetwork

// MARK: - Protocol Definition

protocol MainViewModelProtocol {
    // MARK: - Callbacks
    var selectedIndex: ((Int) -> Void)? { get set }
}

// MARK: - Class Definition

class MainViewModel: MainViewModelProtocol {
    // MARK: - Public Callbacks
    
    var selectedIndex: ((Int) -> Void)?
    
    // MARK: - Private Properties
    private var networkManager: NetworkManager
    
    @MainActor @Published
    var thrownError: Error? = nil
    
    @MainActor @Published
    var allNowPlayingMovies: [MovieDTO] = []
    {
        didSet { print(allNowPlayingMovies) }
    }
    
    // MARK: - Initializers
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        setupCollectionData()
        fetchNowPlaying()
    }
    
    // MARK: - Private Methods
    
    private func setupCollectionData() {
        selectedIndex = { [unowned self] selectionIndex in
            print(selectionIndex)
            print(APIManager.nowPlaying.url)
        }
    }
    
    private func updateNowPlaying(movies: [MovieDTO]) async {
        await MainActor.run {
            allNowPlayingMovies = movies
        }
    }
    
    private func updateThrownError(error: Error) async {
        await MainActor.run {
            self.thrownError = error
        }
    }
    
    // MARK: - Public Methods
    
    public func fetchNowPlaying() {
        Task {
            do {
                let movies = await try networkManager.fetchNowPlayingMovies()
                await updateNowPlaying(movies: movies)
            } catch NetworkError.wrongURL {
                await updateThrownError(error: NetworkError.wrongURL)
            } catch NetworkError.couldntFetchData {
                await updateThrownError(error: NetworkError.couldntFetchData)
            }
        }
    }
}
